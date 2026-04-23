/*
================================================================
  FILE    : 11_analysis_user_segments.sql
  PURPOSE : Classifies all 33 users into movement segments
            based on their average daily step count across
            the full study period.

  BUSINESS QUESTION:
  What proportion of users fall into each activity tier?
  Which segment is most prevalent and therefore most
  actionable for Bellabeat product and marketing strategy?

  SEGMENTS:
    High movers    >= 10,000 steps/day
    Moderate movers  5,000 - 9,999 steps/day
    Low movers     < 5,000 steps/day

  KEY FINDING:
  The majority of users fall in the moderate mover range,
  representing Bellabeat's most consistent and influenceable
  group for engagement features and nudge campaigns.

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

WITH user_avg AS (
    SELECT
        Id,
        AVG(CAST(TotalSteps AS FLOAT))  AS avg_steps
    FROM dbo.v_daily_activity
    GROUP BY Id
)
SELECT
    CASE
        WHEN avg_steps >= 10000                     THEN 'High movers (10k+)'
        WHEN avg_steps BETWEEN 5000 AND 9999        THEN 'Moderate movers (5k-10k)'
        ELSE                                             'Low movers (<5k)'
    END             AS segment,
    COUNT(*)        AS users
FROM user_avg
GROUP BY
    CASE
        WHEN avg_steps >= 10000                     THEN 'High movers (10k+)'
        WHEN avg_steps BETWEEN 5000 AND 9999        THEN 'Moderate movers (5k-10k)'
        ELSE                                             'Low movers (<5k)'
    END
ORDER BY users DESC;
