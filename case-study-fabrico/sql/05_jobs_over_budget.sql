/*
Business Question:
The manager wants to know which jobs went over budget. Show the job reference, client name, quoted value,
actual cost, and the difference between the two as cost_variance. 
Only show jobs where actual cost was higher than quoted value. Order by highest overspend first.
*/

SELECT j.job_ref,
       c.client_name,
       j.quoted_value,
       j.actual_cost,
       j.actual_cost - j.quoted_value AS cost_variance
FROM jobs j
INNER JOIN clients c
ON j.client_id = c.client_id
WHERE j.actual_cost > j.quoted_value
ORDER BY cost_variance DESC;

SELECT 
    COUNT(*) AS total_jobs,
    SUM(actual_cost - quoted_value) AS total_overspend
FROM jobs
WHERE actual_cost > quoted_value;


/*
============================================================
Findings:
201 out of 240 jobs in 2025 ran over budget. That is 83.75%
of all jobs produced during the year. Total overspend across
those jobs was £322,720.

This is a critical finding. The business is consistently
underquoting or overrunning on costs, and the gap between
quoted value and actual cost is not small. £322k of unplanned
cost in a single year directly eats into margin.

The root causes are already visible in earlier queries. Rework
from new welders, cycle time overruns driven by basic layout
drawings, and bottlenecks in welding and fitting all contribute
to jobs taking longer and costing more than planned.

The quoting process is also part of the problem. If quotes are
built on estimated hours that assume experienced operators and
clean drawings, they will always fall short when reality hits
the shop floor.

Recommendation:
The quoting process needs to be rebuilt around actual cost data
rather than estimates. Every job now has a cost variance on
record. That data should feed directly into future quotes.
Jobs with similar descriptions, complexity, and client profiles
should be benchmarked against historical actuals before a
price is issued. Additionally, reducing rework and overrun
through better drawings and operator support will bring actual
costs closer to quoted values over time.
============================================================
*/