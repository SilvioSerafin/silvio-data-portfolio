/*
================================================================
  FILE    : 26_window_peak_activity_hour.sql
  PURPOSE : Ranks each hour of the day by average step count
            across all users and all days in the study period.
            Identifies peak and rest movement windows.

  FUNCTION : RANK() OVER (ORDER BY avg_steps DESC)

  BUSINESS QUESTION:
  At what hour of the day are users most active? Knowing
  peak movement windows allows Bellabeat to time app
  nudges and challenges for maximum engagement -- a push
  notification at 17:30 when users are already moving
  outperforms one at 14:00 when sedentary time is highest.

  SOURCE TABLE NOTE:
  This query uses dbo.hourlySteps_merged2 directly as no
  cleaning view exists for hourly data. In a production
  pipeline, a v_hourly_steps view would be built first
  following the same deduplication pattern as the daily views.
  Direct table use is acceptable here for exploratory analysis.

  DEPENDENCY: dbo.hourlySteps_merged2 (raw table)
================================================================
*/

USE BellaBeat;
GO

WITH hourly_parsed AS (
    SELECT
        Id,
        CAST(ActivityHour AS DATETIME)                  AS activity_datetime,
        DATEPART(HOUR, CAST(ActivityHour AS DATETIME))  AS hour_of_day,
        StepTotal
    FROM dbo.hourlySteps_merged2
),
hourly_avg AS (
    SELECT
        hour_of_day,
        ROUND(AVG(CAST(StepTotal AS FLOAT)), 1)         AS avg_steps,
        ROUND(MAX(CAST(StepTotal AS FLOAT)), 0)         AS max_steps,
        COUNT(*)                                         AS observations
    FROM hourly_parsed
    GROUP BY hour_of_day
)
SELECT
    hour_of_day,
    CAST(hour_of_day AS VARCHAR) + ':00'                AS hour_label,
    avg_steps,
    max_steps,
    observations,
    RANK() OVER (
        ORDER BY avg_steps DESC
    )                                                   AS activity_rank,
    CASE
        WHEN RANK() OVER (ORDER BY avg_steps DESC) <= 3
            THEN 'Peak Window'
        WHEN RANK() OVER (ORDER BY avg_steps DESC) >= 22
            THEN 'Rest Window'
        ELSE 'Standard'
    END                                                 AS window_type
FROM hourly_avg
ORDER BY hour_of_day;

/*
  KEY FINDINGS:
  - Peak activity windows fall in late morning (~10:00-12:00)
    and early evening (~17:00-19:00), reflecting commute
    and post-work exercise patterns.
  - Lowest activity hours are 00:00-05:00, confirming
    expected overnight rest periods.
  - observations column shows data volume per hour. Early
    morning hours have fewer records and should be
    interpreted with appropriate caution.
  - This insight directly informs Bellabeat's notification
    timing strategy -- the highest-impact nudge windows
    are early evening, not midday.
*/
