/*
================================================================
  FILE    : 09_analysis_daily_trends.sql
  PURPOSE : Calculates average daily steps and calories across
            all users for each date in the study period.
            Provides the time-series foundation for the
            Steps vs Calories trend visual in Power BI.

  BUSINESS QUESTION:
  How do population-level activity and calorie output trend
  across the study period? Are there visible peaks or drops
  that could indicate external events or seasonal patterns?

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

SELECT
    a.activity_date,
    ROUND(AVG(CAST(a.TotalSteps AS FLOAT)), 0)      AS avg_steps,
    ROUND(AVG(CAST(a.Calories   AS FLOAT)), 0)      AS avg_calories
FROM dbo.v_daily_activity a
GROUP BY a.activity_date
ORDER BY a.activity_date;
