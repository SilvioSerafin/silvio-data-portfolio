/*
Business Question:
The manager wants to know if there is a link between operator experience and rework rate. 
Show each welder's name, start date, years of experience, rework rate, and order by least experienced first.
*/

SELECT o.first_name,
       o.last_name,
       o.start_date,
       DATEDIFF(YEAR, o.start_date, GETDATE()) AS years_of_experience,
       ROUND(CAST(SUM(CAST(js.rework AS INT)) AS FLOAT) / COUNT(js.scan_id) * 100.0, 2) AS rework_rate
FROM operators o
INNER JOIN job_scans js
ON o.operator_id = js.operator_id
WHERE o.department_id = 4 
GROUP BY o.first_name, o.last_name, o.start_date
ORDER BY years_of_experience ASC ; 


/*
============================================================
Findings:
The data shows a clear and direct link between operator
experience and rework rate.

Aiden, Lewis, and Tyler all have 2 to 3 years of experience
and all show a 100% rework rate. Every job they touched
required rework. Nathan at 4 years drops sharply to 8.33%
and Ryan at 5 years sits at 4.76%. The pattern is consistent:
below 4 years of experience, rework rates are critically high.
Above 4 years they fall to near zero.

This is not a people problem. It is a system problem. New
welders are being assigned complex jobs without adequate
support: drawings are basic layouts with no fabrication
detail, parts arrive unlabelled, and there is no structured
onboarding process to bridge the gap between joining and
being productive independently.

Jack at 13 years shows 50% and Mike at 15 years shows 87.88%.
Both are senior welders with the most experience in the team
yet their rework rates are higher than mid-experience welders
like Ryan and Jordan. This is unexpected and warrants a
follow-up query to understand what type of jobs they are
being assigned compared to the rest of the team.

Danny at 8 years showing 0% rework and Jordan at 6 years
at 4.17% suggest that mid-experience welders on standard
jobs perform well when the work is within their capability.

Recommendation:
New welders under 4 years experience should not be assigned
complex panel jobs independently until they have completed
a structured supervised period. Internal fabrication drawings
and labelled parts would reduce the rework rate for all
experience levels. A mentoring programme pairing new welders
with Jack or Liam on complex jobs would accelerate the
learning curve and reduce the cost of rework significantly.
============================================================
*/