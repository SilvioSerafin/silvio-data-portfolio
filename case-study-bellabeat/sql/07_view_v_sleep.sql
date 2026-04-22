/*
================================================================
  FILE    : 07_view_v_sleep.sql
  PURPOSE : Base cleaning view for the sleep table.
            Removes 3 confirmed duplicate records and casts
            SleepDay (stored as datetime with timestamp) to
            DATE for consistent joining with activity views.

  CONFIRMED DUPLICATES RESOLVED BY THIS VIEW:
    - Id 4388161847, date 2016-05-05
    - Id 4702921684, date 2016-05-07
    - Id 8378563200, date 2016-04-25

  BUG FIX:
  Original query used ORDER BY SleepDay inside a partition
  that is already grouped BY (Id, SleepDay). All SleepDay
  values within each partition are identical, making the
  ordering meaningless and misleading.
  Corrected to ORDER BY (SELECT NULL) -- making the arbitrary
  nature of duplicate row selection explicit and intentional.
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_sleep AS
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Id, SleepDay
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM dbo.sleepDay_merged2
)
SELECT
    Id,
    CAST(SleepDay AS DATE)  AS sleep_date,
    TotalSleepRecords,
    TotalMinutesAsleep,
    TotalTimeInBed
FROM ranked
WHERE rn = 1;
GO
