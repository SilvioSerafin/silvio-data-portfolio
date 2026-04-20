/*
================================================================
  FILE    : 02_profiling_counts.sql
  PURPOSE : Validates row counts and distinct user coverage
            across all five source tables before any cleaning
            or transformation is applied.
  RESULT  : Confirms 33 users in activity tables, 24 in sleep,
            8 in weight. Any deviation from expected counts
            should be investigated before proceeding.
================================================================
*/

USE BellaBeat;
GO

SELECT
    'dailyActivity_merged2'    AS tbl,
    COUNT(*)                   AS rows,
    COUNT(DISTINCT Id)         AS users
FROM dbo.dailyActivity_merged2

UNION ALL

SELECT
    'dailySteps_merged2',
    COUNT(*),
    COUNT(DISTINCT Id)
FROM dbo.dailySteps_merged2

UNION ALL

SELECT
    'dailyIntensities_merged2',
    COUNT(*),
    COUNT(DISTINCT Id)
FROM dbo.dailyIntensities_merged2

UNION ALL

SELECT
    'sleepDay_merged2',
    COUNT(*),
    COUNT(DISTINCT Id)
FROM dbo.sleepDay_merged2

UNION ALL

SELECT
    'weightLogInfo_merged2',
    COUNT(*),
    COUNT(DISTINCT Id)
FROM dbo.weightLogInfo_merged2;
