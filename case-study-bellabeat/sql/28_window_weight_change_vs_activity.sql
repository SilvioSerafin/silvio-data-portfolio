/*
================================================================
  FILE    : 28_window_weight_change_vs_activity.sql
  PURPOSE : Uses LAG on sparse weight log data to calculate
            weight change between entries per user, joined
            to average activity output for the same period.

  FUNCTION : LAG(WeightKg, 1) OVER (PARTITION BY Id ORDER BY date)
             LAG(log_date, 1) OVER (PARTITION BY Id ORDER BY date)

  BUSINESS QUESTION:
  Among the 8 users who logged weight data, is there a
  relationship between activity output and weight change?
  This analysis forms the analytical foundation for
  Bellabeat's Smart Scale product concept.

  IMPORTANT LIMITATION:
  Only 8 of 33 users logged weight. Logging frequency is
  irregular -- some users have daily entries, others have
  gaps of weeks. Results are exploratory, not conclusive.

  KEY TECHNIQUE:
  The activity JOIN uses a date-bounded range between the
  previous and current weight log dates to capture average
  steps and calories specifically for that period.
  ISNULL(prev_log_date, '1900-01-01') handles the first
  weight entry where prev_log_date is NULL -- without it,
  the first entry would pull all prior activity records
  regardless of date.

  DEPENDENCY: 05_view_v_daily_activity.sql,
              dbo.weightLogInfo_merged2 (raw table)
================================================================
*/

USE BellaBeat;
GO

WITH weight_clean AS (
    SELECT
        Id,
        CAST(Date AS DATE)              AS log_date,
        ROUND(CAST(WeightKg AS FLOAT), 2) AS weight_kg,
        ROUND(CAST(BMI      AS FLOAT), 2) AS bmi,
        IsManualReport
    FROM dbo.weightLogInfo_merged2
),
weight_with_lag AS (
    SELECT
        Id,
        log_date,
        weight_kg,
        bmi,
        IsManualReport,
        LAG(weight_kg, 1) OVER (
            PARTITION BY Id
            ORDER BY log_date
        )                               AS prev_weight_kg,
        LAG(log_date, 1) OVER (
            PARTITION BY Id
            ORDER BY log_date
        )                               AS prev_log_date
    FROM weight_clean
),
weight_with_activity AS (
    SELECT
        w.Id,
        w.log_date,
        w.weight_kg,
        w.bmi,
        w.prev_weight_kg,
        w.prev_log_date,
        ROUND(w.weight_kg - w.prev_weight_kg, 2)        AS weight_change_kg,
        DATEDIFF(DAY, w.prev_log_date, w.log_date)      AS days_since_prev_log,
        ROUND(AVG(CAST(a.TotalSteps AS FLOAT)), 0)      AS avg_steps_in_period,
        ROUND(AVG(CAST(a.Calories   AS FLOAT)), 0)      AS avg_calories_in_period
    FROM weight_with_lag w
    LEFT JOIN dbo.v_daily_activity a
        ON  a.Id            = w.Id
        AND a.activity_date >  ISNULL(w.prev_log_date, '1900-01-01')
        AND a.activity_date <= w.log_date
    GROUP BY
        w.Id, w.log_date, w.weight_kg, w.bmi,
        w.prev_weight_kg, w.prev_log_date
)
SELECT
    Id,
    log_date,
    weight_kg,
    bmi,
    prev_weight_kg,
    weight_change_kg,
    days_since_prev_log,
    avg_steps_in_period,
    avg_calories_in_period,
    CASE
        WHEN weight_change_kg IS NULL   THEN 'First Entry'
        WHEN weight_change_kg < -0.5    THEN 'Weight Loss'
        WHEN weight_change_kg >  0.5    THEN 'Weight Gain'
        ELSE                                 'Stable'
    END                                                 AS weight_trend
FROM weight_with_activity
ORDER BY Id, log_date;

/*
  KEY FINDINGS:
  - Only 8 users logged weight. Logging frequency is
    irregular -- days_since_prev_log exposes this directly.
    A 0.5kg drop over 2 days is very different from the
    same drop over 21 days.
  - The date-bounded activity JOIN captures only the steps
    and calories accumulated between two weight measurements,
    making the comparison specific and meaningful.
  - Users classified as Weight Loss with high avg_steps_in_
    period support the activity-weight relationship, but
    with only 8 users this cannot be treated as statistically
    significant.
  - This is the most complex query in the pipeline. It chains
    two LAG calls, a date-bounded aggregation JOIN, and a
    CASE classification. The ISNULL guard on prev_log_date
    is the critical detail -- without it the first entry
    row would JOIN to all activity records in the table.
*/
