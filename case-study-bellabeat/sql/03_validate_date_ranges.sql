/*
================================================================
  FILE    : 03_validate_date_ranges.sql
  PURPOSE : Confirms consistent date coverage across the three
            key tables used in analysis. All three should span
            the same study period (April - May 2016).
            Gaps or mismatches indicate import issues that must
            be resolved before building cleaning views.
================================================================
*/

USE BellaBeat;
GO

SELECT
    'dailyActivity_merged2'  AS tbl,
    MIN(ActivityDate)        AS min_date,
    MAX(ActivityDate)        AS max_date
FROM dbo.dailyActivity_merged2

UNION ALL

SELECT
    'dailySteps_merged2',
    MIN(ActivityDay),
    MAX(ActivityDay)
FROM dbo.dailySteps_merged2

UNION ALL

SELECT
    'sleepDay_merged2',
    MIN(SleepDay),
    MAX(SleepDay)
FROM dbo.sleepDay_merged2;
