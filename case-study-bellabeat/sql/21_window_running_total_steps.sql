/*
================================================================
  FILE    : 21_window_running_total_steps.sql
  PURPOSE : Calculates a cumulative running total of steps
            per user ordered by date across the study period.

  FUNCTION : SUM() OVER (PARTITION BY Id ORDER BY activity_date
                         ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW)

  BUSINESS QUESTION:
  How do individual users accumulate steps over the study
  period? Running totals reveal momentum -- users who
  accelerate vs users who plateau or drop off. This pattern
  informs streak and goal-tracking features in the app.

  FRAME CLAUSE NOTE:
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW is written
  explicitly. Without it, SQL Server defaults to RANGE BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW, which can produce
  unexpected results when tied dates exist. Being explicit
  is best practice and demonstrates awareness of the default.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

SELECT
    Id,
    activity_date,
    TotalSteps,
    SUM(TotalSteps) OVER (
        PARTITION BY Id
        ORDER BY activity_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                                   AS running_total_steps,
    ROW_NUMBER() OVER (
        PARTITION BY Id
        ORDER BY activity_date
    )                                                   AS day_number
FROM dbo.v_daily_activity
ORDER BY Id, activity_date;

/*
  KEY FINDINGS:
  - Running totals expose momentum patterns that daily
    averages completely hide. A user averaging 8,000 steps
    may have achieved that through consistent effort or
    through a few very high days offsetting many low ones.
  - day_number normalises the x-axis across users who have
    different start dates, enabling fair visual comparison
    in Power BI.
  - Users whose running total flattens sharply indicate
    a period of disengagement -- a trigger point for
    re-engagement campaigns.
  - PARTITION BY Id ensures each user's total resets
    independently. Without it, the SUM would run across
    all users combined -- a common and costly mistake.
*/
