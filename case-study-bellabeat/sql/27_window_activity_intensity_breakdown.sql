/*
================================================================
  FILE    : 27_window_activity_intensity_breakdown.sql
  PURPOSE : Calculates the percentage share of each intensity
            level (very active, fairly active, lightly active)
            within each user's total active minutes using
            SUM OVER as the denominator.

  FUNCTION : SUM(avg_minutes) OVER (PARTITION BY Id)
             Used to calculate total active minutes per user
             without a subquery or self-join, then used as
             the denominator for percentage share.

  BUSINESS QUESTION:
  What proportion of each user's active time is spent at
  each intensity level? A user who is highly active in
  total minutes but mostly at low intensity has a different
  wellness profile to one achieving the same total through
  high-intensity exercise. This distinction matters for
  personalised product targeting.

  TECHNIQUE:
  UNION ALL unpivots the three intensity columns into a
  long format (one row per user per intensity level) before
  the window function calculates percentage share.
  This avoids a lateral join and keeps the logic readable.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH user_intensity AS (
    SELECT
        Id,
        ROUND(AVG(CAST(VeryActiveMinutes    AS FLOAT)), 1) AS avg_very_active,
        ROUND(AVG(CAST(FairlyActiveMinutes  AS FLOAT)), 1) AS avg_fairly_active,
        ROUND(AVG(CAST(LightlyActiveMinutes AS FLOAT)), 1) AS avg_lightly_active
    FROM dbo.v_daily_activity
    GROUP BY Id
),
unpivoted AS (
    SELECT Id, 'Very Active'    AS intensity_level, avg_very_active    AS avg_minutes FROM user_intensity
    UNION ALL
    SELECT Id, 'Fairly Active',                     avg_fairly_active             FROM user_intensity
    UNION ALL
    SELECT Id, 'Lightly Active',                    avg_lightly_active            FROM user_intensity
)
SELECT
    Id,
    intensity_level,
    avg_minutes,
    ROUND(
        100.0 * avg_minutes
        / NULLIF(SUM(avg_minutes) OVER (PARTITION BY Id), 0)
    , 1)                                                    AS pct_of_active_time,
    DENSE_RANK() OVER (
        PARTITION BY intensity_level
        ORDER BY avg_minutes DESC
    )                                                       AS rank_within_intensity_level
FROM unpivoted
ORDER BY
    Id,
    CASE intensity_level
        WHEN 'Very Active'    THEN 1
        WHEN 'Fairly Active'  THEN 2
        WHEN 'Lightly Active' THEN 3
    END;

/*
  KEY FINDINGS:
  - Most users spend the majority of active time in the
    lightly active category. Very active minutes represent
    a small fraction of total active time, consistent with
    the 21 min/day average in the main report.
  - Users who rank highly for very active minutes but show
    low step counts likely engage in cycling, swimming, or
    gym exercise that does not generate steps -- an important
    caveat when using steps as the primary activity metric.
  - SUM OVER (PARTITION BY Id) calculates total active minutes
    per user without a subquery, keeping the percentage
    calculation clean and transparent.
  - DENSE_RANK within each intensity level allows cross-user
    comparison within a single intensity tier.
*/
