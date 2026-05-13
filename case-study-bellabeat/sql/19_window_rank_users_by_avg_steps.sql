/*
================================================================
  FILE    : 19_window_rank_users_by_avg_steps.sql
  PURPOSE : Ranks all 33 users by average daily steps across
            the study period using DENSE_RANK.

  FUNCTION : DENSE_RANK() OVER (ORDER BY avg_steps DESC)

  BUSINESS QUESTION:
  Which users are consistently the most and least active?
  Ranking users globally identifies the top and bottom
  performers and supports targeted engagement campaigns.

  WHY DENSE_RANK AND NOT RANK:
  If two users share the same average, RANK skips the next
  position (1, 2, 2, 4). DENSE_RANK does not skip (1, 2, 2, 3).
  For a leaderboard, DENSE_RANK is the cleaner presentation.
  See file 20 for a deliberate use of RANK to illustrate
  the contrast.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH user_avg AS (
    SELECT
        Id,
        ROUND(AVG(CAST(TotalSteps       AS FLOAT)), 0)  AS avg_daily_steps,
        ROUND(AVG(CAST(SedentaryMinutes AS FLOAT)), 0)  AS avg_sedentary_min,
        COUNT(*)                                         AS days_tracked
    FROM dbo.v_daily_activity
    GROUP BY Id
)
SELECT
    Id,
    avg_daily_steps,
    avg_sedentary_min,
    days_tracked,
    DENSE_RANK() OVER (
        ORDER BY avg_daily_steps DESC
    )                                                   AS steps_rank,
    CASE
        WHEN DENSE_RANK() OVER (ORDER BY avg_daily_steps DESC) <= 5
            THEN 'Top 5 Mover'
        WHEN DENSE_RANK() OVER (ORDER BY avg_daily_steps DESC) >= 29
            THEN 'Bottom 5 Mover'
        ELSE 'Mid Range'
    END                                                 AS mover_tier
FROM user_avg
ORDER BY steps_rank;

/*
  KEY FINDINGS:
  - Top movers average well above the NHS-recommended 10,000
    steps/day. Bottom tier falls well below 5,000.
  - High sedentary minutes do not always mirror a low step
    rank -- some users move in short bursts but sit for long
    periods overall.
  - days_tracked varies per user. A user tracked for 10 days
    cannot be compared equally to one tracked for 31 days.
    This limitation should be noted in any stakeholder report.
  - Bottom 5 users are the clearest target group for
    Bellabeat re-engagement nudges and recovery features.
*/
