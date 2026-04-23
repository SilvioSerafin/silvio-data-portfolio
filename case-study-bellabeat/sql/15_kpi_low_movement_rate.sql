/*
================================================================
  FILE    : 15_kpi_low_movement_rate.sql
  PURPOSE : Calculates the percentage of all activity days
            that meet the low-movement threshold definition.
            Feeds directly into the executive summary KPI table.

  BUSINESS QUESTION:
  What proportion of days across the entire dataset are
  classified as low-movement? This figure quantifies the
  scale of the sedentary behaviour problem and supports
  the case for targeted Bellabeat intervention features.

  LOW-MOVEMENT DEFINITION:
  A day is flagged as low-movement when:
    - TotalSteps < 5,000 AND
    - SedentaryMinutes > 900 (15+ hours sedentary)
  Both conditions must be met to exclude rest days where
  a user is genuinely recovering (e.g. high sleep, low steps).

  KEY FINDING:
  22.9% of all activity days across the study period meet
  the low-movement threshold -- more than 1 in 5 days.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH flags AS (
    SELECT
        a.activity_date,
        CASE
            WHEN a.TotalSteps < 5000
             AND a.SedentaryMinutes > 900
            THEN 1
            ELSE 0
        END     AS low_move_flag
    FROM dbo.v_daily_activity a
)
SELECT
    CONVERT(DECIMAL(5,1),
        100.0 * SUM(low_move_flag) / NULLIF(COUNT(*), 0)
    )           AS pct_low_movement_days
FROM flags;
