/*
================================================================
  FILE    : 16_view_v_fact_daily.sql
  PURPOSE : Consolidated daily fact view — the primary data
            source for the Power BI dashboard. Joins activity
            and sleep, adds day type classification and
            pre-calculated sleep efficiency for direct use
            in visuals without further transformation.

  COLUMNS:
    Id                   User identifier
    activity_date        Cleaned date (DATE type)
    weekday_num          1 = Sunday ... 7 = Saturday (SQL Server default)
    weekday_name         Full weekday name for chart labels
    day_type             'Weekday' or 'Weekend'
    TotalSteps           Raw daily step count
    SedentaryMinutes     Raw daily sedentary minutes
    VeryActiveMinutes    Raw daily very active minutes
    Calories             Raw daily calorie burn
    TotalMinutesAsleep   NULL where no sleep record exists
    TotalTimeInBed       NULL where no sleep record exists
    sleep_efficiency     NULL where TotalTimeInBed = 0 or no sleep record

  NOTE ON DAY_TYPE:
  DATENAME is used rather than DATEPART(WEEKDAY) IN (1,7)
  for robustness against SET DATEFIRST session differences.

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_fact_daily AS
SELECT
    a.Id,
    a.activity_date,
    DATEPART(WEEKDAY, a.activity_date)                                  AS weekday_num,
    DATENAME(WEEKDAY, a.activity_date)                                  AS weekday_name,
    CASE
        WHEN DATENAME(WEEKDAY, a.activity_date) IN ('Saturday', 'Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END                                                                 AS day_type,
    a.TotalSteps,
    a.SedentaryMinutes,
    a.VeryActiveMinutes,
    a.Calories,
    s.TotalMinutesAsleep,
    s.TotalTimeInBed,
    CASE
        WHEN s.TotalTimeInBed > 0
        THEN 1.0 * s.TotalMinutesAsleep / s.TotalTimeInBed
    END                                                                 AS sleep_efficiency
FROM dbo.v_daily_activity a
LEFT JOIN dbo.v_sleep s
    ON  a.Id            = s.Id
    AND a.activity_date = s.sleep_date;
GO
