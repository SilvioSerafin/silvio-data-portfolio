/* Business Question:
The manager wants to investigate what is causing rework for Connor and Jack specifically.
Show each rework reason and how many times it appears for each of those two welders. 
Order by highest count first. */

SELECT o.first_name,
       o.last_name,
       js.rework_reason,
       COUNT(*) AS total_rework
FROM operators o
INNER JOIN job_scans js
ON o.operator_id = js.operator_id
WHERE o.department_id = 4
AND js.rework = 1
AND o.first_name IN ('Connor', 'Jack')
GROUP BY o.first_name, o.last_name, js.rework_reason
ORDER BY total_rework DESC;

/*
============================================================
Findings:
The investigation into Connor and Jack confirms that drawing
quality is the primary driver of their rework.

Jack has 15 rework events, all caused by drawing_unclear.
Not a single one is linked to parts identification or any
other reason. His rework is entirely a documentation problem,
not a skill problem.

Connor has 9 rework events total. 8 are caused by
drawing_unclear and 1 by parts_unidentified. The same
pattern applies. Connor is not struggling with the work
itself, he is struggling with the information he is given
to do it.

This is a significant finding. Two experienced welders with
combined rework of 24 events are being let down by drawings
that do not contain enough detail to build from confidently.
Every one of those rework events costs time, materials, and
money that would not have been spent with better documentation.

This also reframes the earlier ranking query. Jack sitting
at rank 6 with 50% rework is not a reflection of his
capability. It is a reflection of the quality of information
he receives before starting a job.

Recommendation:
Engineering must produce internal fabrication drawings before
jobs are released to the shop floor. Client layouts are not
sufficient for production. If drawing quality was resolved
for Jack and Connor alone, their combined 24 rework events
would drop significantly, saving time and cost across the
year.
============================================================
*/
