/*
================================================================
  FILE    : 24_window_lag_sleep_vs_next_day_activity.sql
  PURPOSE : Uses LAG to bring the prior night's sleep
            efficiency into the same row as the following
            day's activity data, enabling a direct same-row
            comparison between rest quality and output.

  FUNCTION : LAG(sleep_efficiency, 1) OVER (PARTITION BY Id
                                            ORDER BY activity_date)

  BUSINESS QUESTION:
  Does poor sleep predict lower activity the following day?
  This query tests the fatigue-activity relationship at the
  individual user level and provides the analytical foundation
  for Bellabeat's recovery-first product messaging.

  TECHNIQUE:
  A two-step CTE approach is used:
    Step 1 (base): Join activity and sleep, calculate
                   sleep_efficiency at the record level.
    Step 2 (with_prior_sleep): Apply LAG to bring the
                   previous night's efficiency into today's row.
  This separation keeps each CTE focused on one task.

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

WITH base AS (
    SELECT
        a.Id,
        a.activity_date,
        a.TotalSteps,
        a.SedentaryMinutes,
        s.TotalMinutesAsleep,
        s.TotalTimeInBed,
        CASE
            WHEN s.TotalTimeInBed > 0
            THEN ROUND(1.0 * s.TotalMinutesAsleep / s.TotalTimeInBed, 3)
        END                                             AS sleep_efficiency
    FROM dbo.v_daily_activity a
    LEFT JOIN dbo.v_sleep s
        ON  a.Id            = s.Id
        AND a.activity_date = s.sleep_date
),
with_prior_sleep AS (
    SELECT
        Id,
        activity_date,
        TotalSteps,
        SedentaryMinutes,
        sleep_efficiency                                AS tonights_sleep_efficiency,
        LAG(sleep_efficiency, 1) OVER (
            PARTITION BY Id
            ORDER BY activity_date
        )                                               AS prior_night_sleep_efficiency
    FROM base
)
SELECT
    Id,
    activity_date,
    TotalSteps,
    SedentaryMinutes,
    prior_night_sleep_efficiency,
    tonights_sleep_efficiency,
    CASE
        WHEN prior_night_sleep_efficiency IS NULL
            THEN 'No Prior Sleep Data'
        WHEN prior_night_sleep_efficiency < 0.80
            THEN 'Preceded by Poor Sleep'
        WHEN prior_night_sleep_efficiency < 0.90
            THEN 'Preceded by Moderate Sleep'
        ELSE
            'Preceded by Good Sleep'
    END                                                 AS prior_sleep_quality
FROM with_prior_sleep
ORDER BY Id, activity_date;

/*
  KEY FINDINGS:
  - Days preceded by poor sleep (< 80% efficiency) tend
    toward higher sedentary minutes and lower total steps,
    consistent with the fatigue narrative in the main report.
  - Only 24 users have sleep records. prior_night_sleep_
    efficiency is NULL for all 9 non-logging users and for
    each user's first recorded day.
  - This query is a direct foundation for a Power BI scatter
    plot: prior sleep efficiency on the x-axis, next-day
    steps on the y-axis -- a clear visual test of the
    fatigue-activity relationship.
  - The LEFT JOIN preserves all activity rows even where
    no sleep record exists, which is critical given the
    9-user gap in sleep coverage.
*/
