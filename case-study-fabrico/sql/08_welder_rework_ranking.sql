/*Business Question:
The manager wants to rank all welders by rework rate from worst to best. 
Show each welder's name, rework rate, and their rank. 
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
       RANK() OVER (ORDER BY rework_rate DESC) AS rework_rank
FROM operator_summary


/*
============================================================
Findings:
Lewis, Tyler, and Aiden share joint rank 1 with a 100% rework
rate. The ranking jumps straight to 4 for Mike at 87.88%
because RANK() skips numbers when there are ties. This is
expected behaviour and correctly reflects that three welders
are equally worst performing.

The ranking confirms the pattern seen in earlier queries.
The bottom three ranks belong to Jordan, Ryan, and Danny
with rework rates of 4.17%, 4.76%, and 0% respectively.
These welders are performing well and represent the standard
the rest of the department should be working toward.

The middle of the ranking, Connor at 40.91% and Jack at 50%,
represents welders who are capable but still generating
significant rework. These are not crisis cases but they
need monitoring and the root causes need investigating.

The spread from 0% to 100% across the same department doing
the same type of work is too wide. In a healthy team the
gap between best and worst should be much narrower. The
width of this spread points to inconsistent job allocation,
inconsistent drawing quality, and an absent onboarding
structure rather than individual capability differences.

Recommendation:
Use this ranking as a baseline. Re-run it quarterly to track
whether interventions such as better drawings, labelled parts,
and structured mentoring are closing the gap between the top
and bottom of the ranking over time.
============================================================
*/



       
