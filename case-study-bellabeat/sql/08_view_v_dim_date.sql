/*
================================================================
  FILE    : 08_view_v_dim_date.sql
  PURPOSE : Builds a date dimension view spanning the full
            study period derived dynamically from v_daily_activity.
            Provides weekday name, weekday number, and month
            number for all time-based aggregations.

  TECHNIQUE:
  Recursive CTE generates one row per calendar day between
  the minimum and maximum dates in v_daily_activity.
  MAXRECURSION 0 removes the default 100-iteration limit,
  which would otherwise error on date ranges longer than
  100 days.

  DEPENDENCY: Requires 05_view_v_daily_activity.sql to exist.
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_dim_date AS
WITH bounds AS (
    SELECT
        MIN(activity_date)  AS dmin,
        MAX(activity_date)  AS dmax
    FROM dbo.v_daily_activity
),
cal AS (
    SELECT dmin AS d FROM bounds
    UNION ALL
    SELECT DATEADD(DAY, 1, c.d)
    FROM cal c
    CROSS JOIN bounds b
    WHERE c.d < b.dmax
)
SELECT
    d,
    DATENAME(WEEKDAY, d)    AS weekday_name,
    DATEPART(WEEKDAY, d)    AS weekday_num,
    DATEPART(MONTH,  d)     AS month_num
FROM cal
OPTION (MAXRECURSION 0);
GO
