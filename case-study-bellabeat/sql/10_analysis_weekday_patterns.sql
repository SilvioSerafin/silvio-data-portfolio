/*
================================================================
  FILE    : 10_analysis_weekday_patterns.sql
  PURPOSE : Aggregates average steps, sedentary minutes, and
            calories by day of the week across all users.
            Ordered by weekday number (Sunday = 1) to produce
            a correctly sequenced chart in Power BI.

  BUSINESS QUESTION:
  Does activity vary meaningfully across the working week?
  Are users more active on weekdays or weekends, and on
  which specific day does sedentary time peak?

  KEY FINDING:
  Monday shows the highest sedentary peak (~1,028 minutes),
  likely linked to post-weekend workload adjustment.
  Saturday shows the highest average steps.

  DEPENDENCY: 05_view_v_daily_activity.sql, 08_view_v_dim_date.sql
================================================================
*/

USE BellaBeat;
GO

SELECT
    d.weekday_name,
    ROUND(AVG(CAST(a.TotalSteps       AS FLOAT)), 0)    AS avg_steps,
    ROUND(AVG(CAST(a.SedentaryMinutes AS FLOAT)), 0)    AS avg_sedentary_min,
    ROUND(AVG(CAST(a.Calories         AS FLOAT)), 0)    AS avg_calories
FROM dbo.v_daily_activity a
JOIN dbo.v_dim_date d
    ON a.activity_date = d.d
GROUP BY
    d.weekday_name,
    d.weekday_num
ORDER BY
    d.weekday_num;
