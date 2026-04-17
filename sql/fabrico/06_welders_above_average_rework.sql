/* Business Question:
The manager wants to know which operators are performing worse than the average rework rate across all welders.
Show their name, their rework rate, and the overall average rework rate alongside it for comparison.
*/



WITH operator_summary AS (

SELECT o.first_name,
       o.last_name,
       ROUND(CAST(SUM(CAST(js.rework AS INT)) AS FLOAT) / COUNT(js.scan_id) * 100.0, 2) AS rework_rate
FROM operators o
INNER JOIN job_scans js
ON o.operator_id = js.operator_id
WHERE o.department_id = 4
GROUP BY o.first_name, o.last_name
                           )

SELECT *,
       ROUND((SELECT AVG(rework_rate) FROM operator_summary), 2) AS average_rate
FROM operator_summary
WHERE rework_rate > (SELECT AVG(rework_rate) FROM operator_summary)

/*
============================================================
Findings:
The average rework rate across all welders is 51.91%. Five
welders are performing above this threshold: Lewis, Tyler,
and Aiden at 100%, Mike at 87.88%, and Liam at 75%.

Lewis, Tyler, and Aiden have the highest rework rates in
the department at 100%. Every single job they touched
required rework. This points to a combination of drawing
quality, parts identification issues, and job complexity
being beyond their current capability.

Mike at 87.88% and Liam at 75% are also above the average.
Whether their rework is driven by job complexity, drawing
quality, or other factors requires a deeper query cross
referencing job type and operator experience before drawing
any conclusions.

The 51.91% average itself is a concern. In a well-run
fabrication shop a rework rate above 20-25% would trigger
a formal review. At 51.91% across the department it points
to a systemic problem, not individual performance issues.

Recommendation:
A follow-up query linking operator start date to rework rate
would confirm whether newer operators consistently produce
more rework than experienced ones. New welders need structured
support: labelled parts, internal fabrication drawings, and
supervised builds on complex jobs before being assigned
independently.
============================================================
*/