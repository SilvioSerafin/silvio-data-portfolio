/*
================================================================
  FILE    : 20_window_rank_users_by_sleep_quality.sql
  PURPOSE : Ranks the 24 users who logged sleep data by
            average sleep efficiency across the study period.

  FUNCTION : RANK() OVER (ORDER BY avg_sleep_efficiency DESC)

  BUSINESS QUESTION:
  Among users who tracked sleep, who sleeps most efficiently?
  Poor sleepers spending 40+ minutes awake in bed each night
  are the primary target for Bellabeat wind-down features
  and the BlueShield product concept.

  WHY RANK AND NOT DENSE_RANK:
  RANK is used deliberately here to contrast with file 19.
  If two users share the same efficiency score, RANK skips
  the next position (1, 2, 2, 4). DENSE_RANK would not skip.
  Both are valid -- the choice depends on whether tied
  positions should consume a rank slot. Knowing the
  difference and choosing deliberately is what matters.

  SLEEP EFFICIENCY THRESHOLDS:
  >= 0.90  Good Sleeper      (clinical benchmark)
  >= 0.80  Moderate Sleeper
  <  0.80  Poor Sleeper      (may indicate insomnia)

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

WITH user_sleep AS (
    SELECT
        Id,
        COUNT(*)                                                        AS nights_tracked,
        ROUND(AVG(CAST(TotalMinutesAsleep AS FLOAT)), 1)               AS avg_minutes_asleep,
        ROUND(AVG(CAST(TotalTimeInBed     AS FLOAT)), 1)               AS avg_time_in_bed,
        ROUND(
            AVG(CAST(TotalTimeInBed     AS FLOAT))
          - AVG(CAST(TotalMinutesAsleep AS FLOAT))
        , 1)                                                            AS avg_min_awake_in_bed,
        ROUND(
            AVG(1.0 * TotalMinutesAsleep / NULLIF(TotalTimeInBed, 0))
        , 3)                                                            AS avg_sleep_efficiency
    FROM dbo.v_sleep
    GROUP BY Id
)
SELECT
    Id,
    nights_tracked,
    avg_minutes_asleep,
    avg_time_in_bed,
    avg_min_awake_in_bed,
    avg_sleep_efficiency,
    RANK() OVER (
        ORDER BY avg_sleep_efficiency DESC
    )                                                                   AS sleep_rank,
    CASE
        WHEN avg_sleep_efficiency >= 0.90   THEN 'Good Sleeper'
        WHEN avg_sleep_efficiency >= 0.80   THEN 'Moderate Sleeper'
        ELSE                                     'Poor Sleeper'
    END                                                                 AS sleep_tier
FROM user_sleep
ORDER BY sleep_rank;

/*
  KEY FINDINGS:
  - Only 24 of 33 users have sleep records. 9 users never
    logged sleep during the study period.
  - Poor sleepers spending 40+ minutes awake in bed are the
    clearest use case for Bellabeat wind-down features and
    the BlueShield blue-light glasses concept.
  - avg_min_awake_in_bed is a more actionable metric than
    efficiency alone -- it quantifies the nightly time cost
    of poor sleep onset in minutes stakeholders can grasp.
*/
