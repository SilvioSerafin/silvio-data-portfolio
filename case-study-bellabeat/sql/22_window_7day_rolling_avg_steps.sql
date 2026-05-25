/*
================================================================
  FILE    : 22_window_7day_rolling_avg_steps.sql
  PURPOSE : Calculates a 7-day rolling average of daily steps
            per user alongside the cumulative average to date.

  FUNCTION : AVG() OVER (PARTITION BY Id ORDER BY activity_date
                         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)

  BUSINESS QUESTION:
  What does each user's true activity trend look like when
  daily noise is removed? Smoothing over 7 days reveals
  genuine decline or improvement that a single-day reading
  cannot confirm.

  FRAME CLAUSE:
  ROWS BETWEEN 6 PRECEDING AND CURRENT ROW = a 7-row window
  (current row + 6 prior rows). This is a physical row frame,
  not a calendar frame. If a user has a missing date, the
  window looks back 6 rows, not 6 calendar days. For
  production use, a date spine join would fill gaps first.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

SELECT
    Id,
    activity_date,
    TotalSteps                                                      AS daily_steps,
    ROUND(
        AVG(CAST(TotalSteps AS FLOAT)) OVER (
            PARTITION BY Id
            ORDER BY activity_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )
    , 0)                                                            AS rolling_7day_avg,
    ROUND(
        AVG(CAST(TotalSteps AS FLOAT)) OVER (
            PARTITION BY Id
            ORDER BY activity_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
    , 0)                                                            AS cumulative_avg_to_date
FROM dbo.v_daily_activity
ORDER BY Id, activity_date;

/*
  KEY FINDINGS:
  - The 7-day rolling average smooths weekend dips and
    single rest days, giving a reliable picture of trend
    direction that raw daily data cannot provide.
  - For the first 6 days of each user's record, the rolling
    average uses fewer than 7 rows. This is correct and
    expected -- not a data quality issue.
  - Where rolling_7day_avg drops consistently below
    cumulative_avg_to_date, the user is in decline relative
    to their own baseline -- a stronger re-engagement signal
    than comparing against population averages.
  - Users whose 7-day rolling avg falls below 5,000 steps
    persistently are the highest priority for intervention.
*/
