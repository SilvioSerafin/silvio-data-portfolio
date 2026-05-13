/*
================================================================
  FILE    : 17_view_v_daily_user_summary.sql
  PURPOSE : A narrower daily summary view joining activity and
            sleep at the user-date level. Excludes derived
            columns (day_type, sleep_efficiency) for use cases
            where the raw joined data is preferred over the
            fully enriched v_fact_daily view.

  USE CASE:
  Power BI measures that calculate sleep efficiency or day
  type classification themselves using DAX, rather than
  consuming pre-calculated SQL columns.

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_daily_user_summary AS
SELECT
    a.Id,
    a.activity_date,
    a.TotalSteps,
    a.SedentaryMinutes,
    a.VeryActiveMinutes,
    a.Calories,
    s.TotalMinutesAsleep,
    s.TotalTimeInBed
FROM dbo.v_daily_activity a
LEFT JOIN dbo.v_sleep s
    ON  a.Id            = s.Id
    AND a.activity_date = s.sleep_date;
GO
