
/* Business Question:
The production manager wants to know which department is causing the most delays. 
Show each department's total planned minutes vs total actual minutes, and calculate the overrun in minutes. 
Order by highest overrun first. */


SELECT d.department_name,
       ROUND(SUM(js.planned_duration_mins), 2)  AS planned_minutes,
       ROUND(SUM(js.actual_duration_mins) ,2) AS actual_minutes,
       ROUND(SUM(js.actual_duration_mins) - SUM(js.planned_duration_mins), 2) AS overrun_minutes
FROM departments d
INNER JOIN job_scans js
ON d.department_id = js.department_id
GROUP BY d.department_name
ORDER BY overrun_minutes DESC;

/*
============================================================
Findings:
Welding is the worst performing department by a significant
margin. 31,330 minutes of overrun, nearly double Fitting
in second place at 19,110 minutes. Across the year that
represents roughly 65 working days of unplanned time, which
directly translates to overtime costs and delayed dispatches.

Fitting shop is also concerning at 62% over planned time.
Both Welding and Fitting are where the most complex work
happens: large panels, structural assemblies. Rework,
drawing issues, and parts problems hit these departments hardest.

Folding appearing in the top 3 is worth investigating. Folding
should be a controlled, repeatable process with fewer variables
than welding or fitting. Overrun here suggests drawing issues
upstream are causing the press brake operators to stop and
seek clarification mid-job.

Punching, Labour, and Painting are performing closer to plan.
Still room for improvement but not critical.

Recommendation:
Drill into Welding, Fitting, and Folding with dedicated queries
to identify the root causes. Rework rates, drawing quality
impact, operator experience gaps, and wait reasons. Build an
action plan around the findings. For Punching, Labour, and
Painting, monitor trends rather than intervene immediately.
============================================================
*/