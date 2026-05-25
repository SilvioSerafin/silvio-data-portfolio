/*
================================================================
  FILE    : 25_window_consecutive_low_activity_days.sql
  PURPOSE : Identifies consecutive streaks of low-activity
            days per user using the ROW_NUMBER islands technique.

  FUNCTION : ROW_NUMBER() OVER (PARTITION BY Id ORDER BY date)
             ROW_NUMBER() OVER (PARTITION BY Id, flag ORDER BY date)
             Difference of the two creates a constant group ID
             for each consecutive streak.

  BUSINESS QUESTION:
  Which users experienced the longest streaks of low-activity
  days? A single rest day is normal. Three or more consecutive
  low-activity days signals genuine disengagement and is the
  most actionable trigger for Bellabeat intervention features.

  LOW-MOVEMENT DEFINITION:
  TotalSteps < 5,000 AND SedentaryMinutes > 900

  THE ISLANDS TECHNIQUE EXPLAINED:
  rn_all    = row number across all rows for the user
  rn_within = row number across low-activity rows only
  rn_all - rn_within = a constant value for each consecutive
  streak. When a non-low-activity day breaks the sequence,
  rn_all increments but rn_within does not, changing the
  difference and starting a new group.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH flagged AS (
    SELECT
        Id,
        activity_date,
        TotalSteps,
        SedentaryMinutes,
        CASE
            WHEN TotalSteps < 5000
             AND SedentaryMinutes > 900
            THEN 1
            ELSE 0
        END                                             AS low_activity_flag
    FROM dbo.v_daily_activity
),
low_only AS (
    SELECT
        Id,
        activity_date,
        TotalSteps,
        SedentaryMinutes,
        ROW_NUMBER() OVER (
            PARTITION BY Id
            ORDER BY activity_date
        )
        -
        ROW_NUMBER() OVER (
            PARTITION BY Id, low_activity_flag
            ORDER BY activity_date
        )                                               AS island_group
    FROM flagged
    WHERE low_activity_flag = 1
),
streaks AS (
    SELECT
        Id,
        MIN(activity_date)                              AS streak_start,
        MAX(activity_date)                              AS streak_end,
        COUNT(*)                                        AS streak_length_days,
        ROUND(AVG(CAST(TotalSteps       AS FLOAT)), 0) AS avg_steps_in_streak,
        ROUND(AVG(CAST(SedentaryMinutes AS FLOAT)), 0) AS avg_sedentary_in_streak
    FROM low_only
    GROUP BY Id, island_group
)
SELECT
    Id,
    streak_start,
    streak_end,
    streak_length_days,
    avg_steps_in_streak,
    avg_sedentary_in_streak,
    DENSE_RANK() OVER (
        ORDER BY streak_length_days DESC
    )                                                   AS streak_rank
FROM streaks
ORDER BY streak_length_days DESC, Id;

/*
  KEY FINDINGS:
  - Users with streaks of 3 or more consecutive low-activity
    days are a priority re-engagement segment. A single
    rest day is expected; multi-day streaks are not.
  - avg_steps_in_streak and avg_sedentary_in_streak confirm
    streak severity -- not all low-activity streaks are equal.
  - streak_rank using DENSE_RANK surfaces the longest streaks
    without filtering out shorter ones that may still be
    significant for individual users.
  - The islands technique is one of the most reusable and
    interview-relevant SQL patterns in analytical work.
    Understanding and explaining it clearly is a strong
    technical differentiator.
*/
