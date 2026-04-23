/*
================================================================
  FILE    : 13_kpi_weekday_vs_weekend.sql
  PURPOSE : Calculates average daily steps split by weekday
            vs weekend. Feeds directly into the headline KPI
            reported in the executive summary.

  BUSINESS QUESTION:
  Do Bellabeat users move significantly more on weekdays
  or weekends? A small difference challenges the assumption
  that women become less active when not working.

  KEY FINDING:
  Weekday avg: ~7,608 steps. Weekend avg: ~7,550 steps.
  A difference of only 0.7%, suggesting users maintain
  consistent activity regardless of the day type -- evidence
  of the "triple workload" behavioural pattern.

  NOTE ON WEEKEND DEFINITION:
  DATENAME is used rather than DATEPART(WEEKDAY) IN (1,7)
  to avoid sensitivity to SET DATEFIRST session settings,
  which can change the numeric day mapping. DATENAME is
  always locale-safe for English day names.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH day_split AS (
    SELECT
        CASE
            WHEN DATENAME(WEEKDAY, a.activity_date) IN ('Saturday', 'Sunday')
            THEN 'Weekend'
            ELSE 'Weekday'
        END                             AS day_type,
        CAST(a.TotalSteps AS FLOAT)     AS steps
    FROM dbo.v_daily_activity a
)
SELECT
    day_type,
    CONVERT(DECIMAL(10,0), AVG(steps))  AS avg_steps
FROM day_split
GROUP BY day_type;
