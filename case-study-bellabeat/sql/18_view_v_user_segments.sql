/*
================================================================
  FILE    : 18_view_v_user_segments.sql
  PURPOSE : Classifies each user into a movement segment based
            on their average daily steps across the study period.
            Used as a dimension table in Power BI for filtering
            and colouring visuals by user activity tier.

  SEGMENTS:
    High movers      >= 10,000 avg steps/day
    Moderate movers    5,000 - 9,999 avg steps/day
    Low movers       < 5,000 avg steps/day

  DEPENDENCY: 05_view_v_daily_activity.sql
================================================================
*/

USE BellaBeat;
GO

CREATE OR ALTER VIEW dbo.v_user_segments AS
SELECT
    u.Id,
    CASE
        WHEN u.avg_steps >= 10000                   THEN 'High movers (10k+)'
        WHEN u.avg_steps BETWEEN 5000 AND 9999      THEN 'Moderate movers (5k-10k)'
        ELSE                                              'Low movers (<5k)'
    END     AS movement_segment
FROM (
    SELECT
        Id,
        AVG(CAST(TotalSteps AS FLOAT))  AS avg_steps
    FROM dbo.v_daily_activity
    GROUP BY Id
) AS u;
GO
