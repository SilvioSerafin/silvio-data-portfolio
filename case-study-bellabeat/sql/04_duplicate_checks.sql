/*
================================================================
  FILE    : 04_duplicate_checks.sql
  PURPOSE : Detects duplicate (Id, Date) pairs in the three
            core tables before cleaning views are built.
            Duplicates bias averages and must be handled.

  KNOWN RESULT:
  sleepDay_merged2 contains 3 confirmed duplicate records:
    - Id 4388161847 on 5/5/2016
    - Id 4702921684 on 5/7/2016
    - Id 8378563200 on 4/25/2016
  These are resolved by ROW_NUMBER deduplication in
  07_view_v_sleep.sql.
================================================================
*/

USE BellaBeat;
GO

-- Activity duplicates
SELECT
    Id,
    ActivityDate,
    COUNT(*)    AS dupes
FROM dbo.dailyActivity_merged2
GROUP BY Id, ActivityDate
HAVING COUNT(*) > 1;

-- Steps duplicates
SELECT
    Id,
    ActivityDay,
    COUNT(*)    AS dupes
FROM dbo.dailySteps_merged2
GROUP BY Id, ActivityDay
HAVING COUNT(*) > 1;

-- Sleep duplicates
SELECT
    Id,
    SleepDay,
    COUNT(*)    AS dupes
FROM dbo.sleepDay_merged2
GROUP BY Id, SleepDay
HAVING COUNT(*) > 1;
