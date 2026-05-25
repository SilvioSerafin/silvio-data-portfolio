/*
================================================================
  FILE    : 23_window_lag_daily_step_change.sql
  PURPOSE : Uses LAG to compare each user's daily step count
            to the previous day, calculating the change and
            classifying the direction of movement.

  FUNCTION : LAG(TotalSteps, 1) OVER (PARTITION BY Id
                                      ORDER BY activity_date)

  BUSINESS QUESTION:
  How volatile is each user's day-to-day activity? Identifying
  sharp single-day drops is the earliest warning signal of
  disengagement -- more actionable than waiting for a
  weekly average to decline.

  LAG BEHAVIOUR:
  LAG(col, 1) returns the value from the previous row within
  the partition. The first row per user returns NULL as there
  is no prior row. NULL is preferred over a default of 0
  here -- returning 0 would falsely imply the user started
  from zero steps, inflating the calculated step_change.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH daily_with_lag AS (
    SELECT
        Id,
        activity_date,
        TotalSteps,
        LAG(TotalSteps, 1) OVER (
            PARTITION BY Id
            ORDER BY activity_date
        )                                               AS prev_day_steps
    FROM dbo.v_daily_activity
)
SELECT
    Id,
    activity_date,
    TotalSteps                                          AS today_steps,
    prev_day_steps,
    TotalSteps - prev_day_steps                         AS step_change,
    CASE
        WHEN prev_day_steps IS NULL
            THEN 'First Record'
        WHEN TotalSteps - prev_day_steps >= 3000
            THEN 'Strong Increase'
        WHEN TotalSteps - prev_day_steps BETWEEN 0 AND 2999
            THEN 'Modest Increase'
        WHEN TotalSteps - prev_day_steps BETWEEN -2999 AND -1
            THEN 'Modest Decline'
        ELSE
            'Sharp Decline'
    END                                                 AS movement_trend
FROM daily_with_lag
ORDER BY Id, activity_date;

/*
  KEY FINDINGS:
  - Day-over-day step change reveals behavioural volatility
    that averages mask entirely. A user averaging 8,000
    steps may swing between 1,500 and 15,000 daily.
  - Sharp declines on consecutive days are the earliest
    detectable disengagement signal available in this dataset.
  - In a production Bellabeat model, the CASE thresholds
    would be calibrated against each user's personal baseline
    rather than fixed population-level values.
  - The CASE classification is intentionally directional
    rather than symmetric -- a 3,000 step drop and a 3,000
    step gain are not behaviourally equivalent events.
*/
