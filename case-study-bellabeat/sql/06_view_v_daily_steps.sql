/*
================================================================
  FILE    : 06_view_v_daily_steps.sql
  PURPOSE : Base cleaning view for the daily steps table.
            Removes duplicates and casts ActivityDay to DATE.
            StepTotal is aliased to Steps for clarity.

  NOTE:
  v_daily_steps is a supplementary view. TotalSteps in
  v_daily_activity already provides step data at the same
  granularity. This view is retained for cases where steps
  need to be joined or validated independently of the full
  activity table.

  FIX NOTE:
  ORDER BY (SELECT NULL) replaces ORDER BY ActivityDay for
  the same reason as in 05_view_v_daily_activity.sql --
  ordering by the partition key itself is meaningless.
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_daily_steps AS
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Id, ActivityDay
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM dbo.dailySteps_merged2
)
SELECT
    Id,
    CAST(ActivityDay AS DATE)   AS activity_date,
    StepTotal                   AS Steps
FROM ranked
WHERE rn = 1;
GO
