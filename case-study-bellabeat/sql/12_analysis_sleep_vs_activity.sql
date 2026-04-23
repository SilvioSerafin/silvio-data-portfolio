/*
================================================================
  FILE    : 12_analysis_sleep_vs_activity.sql
  PURPOSE : Calculates population-level averages for sleep
            duration, time in bed, daily steps, and calories
            across all user-days where sleep data exists.
            Provides the headline summary statistics for the
            executive report.

  BUSINESS QUESTION:
  What is the overall relationship between sleep and activity
  across the user base? Are users sleeping enough, and does
  the data suggest fatigue is affecting daily movement?

  KEY FINDING:
  Users average ~7 hours of sleep but spend ~40 minutes
  awake in bed. Those sleeping under 6 hours still average
  higher daily steps than longer sleepers, suggesting
  persistent activity despite fatigue -- the "triple
  workload" pattern identified in the full report.

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

WITH ds AS (
    SELECT
        a.Id,
        a.activity_date,
        a.TotalSteps,
        a.Calories,
        s.TotalMinutesAsleep,
        s.TotalTimeInBed
    FROM dbo.v_daily_activity a
    LEFT JOIN dbo.v_sleep s
        ON  a.Id            = s.Id
        AND a.activity_date = s.sleep_date
)
SELECT
    CONVERT(DECIMAL(10,1), AVG(CAST(TotalMinutesAsleep AS FLOAT)) / 60.0)  AS avg_sleep_hours,
    CONVERT(DECIMAL(10,1), AVG(CAST(TotalTimeInBed     AS FLOAT)) / 60.0)  AS avg_time_in_bed_hours,
    CONVERT(DECIMAL(10,1), AVG(CAST(TotalSteps         AS FLOAT)))         AS avg_steps,
    CONVERT(DECIMAL(10,1), AVG(CAST(Calories           AS FLOAT)))         AS avg_calories
FROM ds;
