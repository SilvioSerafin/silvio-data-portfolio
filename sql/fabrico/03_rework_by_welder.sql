/* Business Question:
The production manager wants to know which welders are generating the most rework. 
Show each welder's name, how many scans they did, how many of those were rework, and their rework rate as a percentage. 
Order by highest rework rate first.*/



SELECT o.first_name,
       o.last_name,
       COUNT(js.scan_id) AS total_scans,
       SUM(CAST(js.rework AS INT)) AS total_rework,
       ROUND(CAST(SUM(CAST(js.rework AS INT)) AS FLOAT) / COUNT(js.scan_id) * 100.0 ,2) AS rework_rate
FROM operators o
INNER JOIN job_scans js
ON o.operator_id = js.operator_id
WHERE o.department_id = 4
GROUP BY o.first_name, o.last_name
ORDER BY rework_rate DESC;

/*
============================================================
Findings:
Lewis, Tyler, and Aiden are showing 100% rework rates across
all their scans. These are the newest welders on the team and
the data confirms what most experienced shop floor leads already
suspect: the onboarding curve in sheet metal fabrication is long,
especially on complex enclosures and panels.

The question now is what is driving it. Are they being assigned
jobs that are beyond their current level? Are parts arriving
unlabelled so they are assembling the wrong components? Are
drawings too vague to follow without experience to fill the gaps?
These questions need their own queries.

Mike Hargreaves stands out. Despite an 87.88% rework rate he is
handling 33 scans, more than anyone else. He is absorbing the
hardest jobs while still producing at volume. That is a senior
welder carrying the department.

Jack Black sits at 50% which for the complexity of panels being
built is worth monitoring but not critical yet.

Jordan, Ryan, and Danny showing near-zero rework warrants a
closer look. Are they being assigned simpler jobs? Are they
scanning correctly? The numbers seem unusually clean and should
be cross-referenced against job complexity before drawing
any conclusions.

Recommendation:
Run follow-up queries on the new welders to identify whether
rework is linked to drawing quality, parts identification, or
job complexity. Senior welders Mike, Jack, and Liam should be
involved in a structured mentoring approach for the newer team
members rather than informal on-the-job learning. If the root
cause is operational rather than skill-based, escalate to
engineering and the team leader with the data to back it up.
============================================================
*/