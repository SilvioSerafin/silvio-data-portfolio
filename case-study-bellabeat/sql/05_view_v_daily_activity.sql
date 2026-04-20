/*
================================================================
  FILE    : 05_view_v_daily_activity.sql
  PURPOSE : Base cleaning view for the daily activity table.
            Removes duplicates using ROW_NUMBER and casts the
            date column from VARCHAR to DATE for consistent
            joins across all downstream views and queries.

  FIX NOTE:
  ORDER BY (SELECT NULL) is used as the ROW_NUMBER tiebreaker.
  Ordering BY ActivityDate inside a partition that is already
  grouped BY ActivityDate is meaningless -- all values within
  the partition are identical. (SELECT NULL) makes the intent
  explicit: row selection among duplicates is arbitrary since
  no meaningful tiebreaker column exists in this table.
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_daily_activity AS
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Id, ActivityDate
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM dbo.dailyActivity_merged2
)
SELECT
    Id,
    CAST(ActivityDate       AS DATE)    AS activity_date,
    TotalSteps,
    TotalDistance,
    VeryActiveMinutes,
    FairlyActiveMinutes,
    LightlyActiveMinutes,
    SedentaryMinutes,
    Calories
FROM ranked
WHERE rn = 1;
GO
