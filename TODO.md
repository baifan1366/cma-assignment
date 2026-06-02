# CMA6134-T2610 Assignment Todo

Sources analysed with `pypdf`:

- `C:\Users\weixu\Downloads\CMA6134 T2610 Assignment-rev.pdf`
- `C:\Users\weixu\Downloads\Lab 04 T2.pdf`
- `C:\Users\weixu\Downloads\CHAPTER 4 MONTE CARLO METHODS AND SIMULATION vT2410.pdf`

Assignment title: Simulation of a Hospital Emergency Department Queuing System

Deadline: 22 June 2026, 23:59, Week 13

Group size: 3-4 members within the same tutorial class

Required tools: Octave or FreeMat

## Must Submit

- [ ] Report in PDF format, 5-10 pages.
- [ ] Simulation code as `.m` file.
- [ ] README file explaining how to run the simulation.
- [ ] Presentation slides in PDF format, maximum 10 slides.
- [ ] Prepare for physical presentation and Q&A.
- [ ] Submit before 22 June 2026, 23:59 to avoid late penalty.

Note: The PDF says "Presentation, Q&A: 15 minutes per group" on page 1, but the deliverables section says "Presentation 5 minutes & Q&A 5 minutes". Prepare a tight 5-minute presentation plus strong Q&A answers, and confirm exact timing with the lecturer if possible.

## Target Grade Strategy

To match the top rubric level, build a priority queue model with multiple doctors.

- [ ] Use multiple doctors, preferably 3 doctors for baseline.
- [ ] Assign each arriving patient a priority category, such as critical, urgent, and non-urgent.
- [ ] Serve higher-priority patients before lower-priority patients.
- [ ] Preserve FIFO order within the same priority level.
- [ ] Include a baseline scenario and at least one improvement scenario.
- [ ] Clearly justify all assumptions and parameter values.
- [ ] Compute and interpret every required metric.

Best target model:

- Baseline: multi-doctor emergency department with priority queue.
- Improvement: add one doctor during peak period, add one full-shift doctor, or introduce a fast-track process.
- Method: Monte Carlo / event-based queuing simulation using random numbers.
- Strong report angle: connect the assignment model to Lecture 04 queuing simulation concepts.

Avoid a low-ceiling model:

- Do not stop at only a single-server M/M/1 model unless the group cannot complete a stronger model.
- Do not only generate random numbers without queue logic.
- Do not only show code output; the rubric rewards interpretation and justification.

## Useful Lecture And Lab Concepts

Use these concepts from Lab 04 and Lecture 04 in the report and presentation.

- [ ] Monte Carlo simulation: repeated random experiments are used to estimate system performance.
- [ ] Random numbers: used to imitate real-life uncertainty in patient arrivals, service times, and patient priority.
- [ ] Pseudo-random numbers: the implementation can use Octave/FreeMat `rand()`.
- [ ] LCG: mention as theoretical background for pseudo-random number generation, but do not manually implement unless required.
- [ ] Uniform distribution: `rand()` generates uniform random numbers in `[0,1]`.
- [ ] Uniform transformation: for a range `[a,b]`, use `X = a + (b-a)*R` if a uniformly distributed time/range is needed.
- [ ] Exponential distribution: use inverse transform to generate inter-arrival and service times.
- [ ] Exponential formula: `X = -log(1-R)/lambda`; in code, `X = -log(rand())/lambda` is acceptable.
- [ ] Discrete distribution: use probability ranges to assign patient priority categories.
- [ ] Event list and simulation clock: queue simulation tracks arrivals and departures over time.
- [ ] Server status: each doctor should be tracked as busy or idle.
- [ ] Server utilization: busy time divided by available doctor time.

Suggested report sentence:

```text
This simulation follows the Monte Carlo approach introduced in Lecture 04, where pseudo-random numbers are used to represent uncertain patient arrivals, service durations, and patient priority levels. The queuing system is simulated using a clock/event-based method that tracks arrivals, departures, queue status, and doctor availability.
```

## Simulation Model Todo

- [ ] Define simulation time horizon, for example 8 or 12 hours of emergency department operation.
- [ ] Define patient arrival process.
- [ ] Recommended: Poisson arrivals, implemented through exponential inter-arrival times.
- [ ] Define peak and non-peak arrival rates if aiming for stronger justification.
- [ ] Define service-time process.
- [ ] Recommended: exponential service times, with different mean service times by priority category if justified.
- [ ] Define patient priority probabilities.
- [ ] Example structure: critical, urgent, non-urgent.
- [ ] Define number of doctors for each scenario.
- [ ] Implement an event-based simulation loop in Octave or FreeMat.
- [ ] Track each patient's arrival time, priority, service start time, service end time, waiting time, and assigned doctor.
- [ ] Implement queue logic that selects the highest-priority waiting patient.
- [ ] If priorities tie, select the patient who arrived first.
- [ ] Track doctor availability times.
- [ ] Ensure the model handles idle doctors, busy periods, and empty queues correctly.
- [ ] Run enough replications to reduce randomness, such as 30 or more runs per scenario.
- [ ] Set or document the random seed approach.

Recommended implementation design:

- [ ] Use minutes as the time unit throughout the simulation.
- [ ] Generate all patient arrival times first by accumulating inter-arrival times until the simulation horizon is reached.
- [ ] For each patient, generate priority using a discrete distribution.
- [ ] For each patient, generate service time, optionally with different means by priority.
- [ ] Maintain arrays for doctor next-available time and doctor total busy time.
- [ ] When a doctor is free and the queue is non-empty, select the waiting patient with the highest priority.
- [ ] If multiple patients have the same priority, select the earliest arrival first.
- [ ] Record queue length over time or at event times so average queue length can be estimated.
- [ ] After each run, store all metrics in a result table.
- [ ] After repeated runs, report the mean value for each metric.

Recommended distributions:

- [ ] Arrival process: exponential inter-arrival time, representing Poisson arrivals.
- [ ] Service process: exponential service time, representing variable consultation/treatment duration.
- [ ] Patient priority: discrete distribution, for example 20% critical, 40% urgent, 40% non-urgent.
- [ ] Optional stronger design: critical patients have longer average service time but higher service priority.

Example parameter set to refine:

- [ ] Simulation horizon: 480 minutes, representing an 8-hour shift.
- [ ] Baseline doctors: 3.
- [ ] Improvement doctors: 4, or 4 only during peak period.
- [ ] Mean inter-arrival time: 6 minutes during normal period, 3-4 minutes during peak period.
- [ ] Mean service time: critical 20 minutes, urgent 15 minutes, non-urgent 10 minutes.

These numbers must be described as assumptions if no real hospital data is used.

## Scenario Comparison Todo

- [ ] Baseline scenario: current assumed system, for example 3 doctors with priority queue.
- [ ] Improvement scenario 1: add one doctor during peak hours or for the full shift.
- [ ] Improvement scenario 2: faster triage or separate fast-track handling for non-urgent patients.
- [ ] Optional stronger scenario: compare FIFO multi-server queue against priority multi-server queue.
- [ ] Use the same performance metrics for every scenario.
- [ ] Explain which scenario is best and why.
- [ ] Discuss trade-offs, such as lower waiting time versus higher doctor utilization/cost.

Best practice for scenario comparison:

- [ ] Keep the same random seed or same generated input structure when comparing scenarios if possible, so the comparison is fair.
- [ ] Compare baseline and improvement using the same arrival rate, priority mix, and service assumptions unless the scenario intentionally changes them.
- [ ] Do not claim the improvement is best only because waiting time is lower; also discuss doctor utilization and resource cost.
- [ ] Include at least one table with all metrics side by side.
- [ ] Include one graph comparing average waiting time and/or doctor utilization across scenarios.

## Required Metrics Todo

- [ ] Average waiting time.
- [ ] Average queue length.
- [ ] Doctor utilization.
- [ ] Total patients served.
- [ ] Add optional supporting metrics if useful: maximum waiting time, average waiting time by priority, percentage served within target time.
- [ ] Present results in tables.
- [ ] Present at least one graph, such as waiting time by scenario or utilization by scenario.
- [ ] Interpret the results in words, not only numbers.

Metric calculation notes:

- Average waiting time: mean of `service_start_time - arrival_time`.
- Total patients served: number of patients with completed service before or within the simulation horizon, depending on the chosen rule.
- Doctor utilization: `sum(doctor_busy_time) / (num_doctors * simulation_horizon)`.
- Individual doctor utilization: `doctor_busy_time(i) / simulation_horizon`.
- Average queue length: best estimated by time-weighted queue length over the simulation clock.
- Simpler acceptable queue length estimate: average recorded queue length at event times, but explain this approximation.
- Probability of waiting is optional but useful: number of patients with waiting time greater than 0 divided by total patients.

## Report Structure Todo

- [ ] Title page with course code, assignment title, group members, tutorial class, and date.
- [ ] Problem description and objectives.
- [ ] Background of emergency department queuing.
- [ ] Assumptions for arrivals, services, priorities, doctors, and simulation horizon.
- [ ] Queuing model description.
- [ ] Explain why the model is multi-server and priority-based.
- [ ] Simulation methodology.
- [ ] Explain algorithm/event flow clearly enough that the code can be understood.
- [ ] Results section with tables and graphs.
- [ ] Analysis and discussion.
- [ ] Compare baseline and improvement scenarios.
- [ ] Recommendations.
- [ ] Conclusion.
- [ ] References for any external sources or assumptions.
- [ ] Keep final report between 5 and 10 pages.
- [ ] Export report as PDF.

Report best practice:

- [ ] In the assumptions section, explicitly state there is no real hospital dataset and the model uses justified assumed parameters.
- [ ] In the methodology section, mention Lecture 04 concepts: Monte Carlo simulation, pseudo-random numbers, event list, simulation clock, arrival/departure events, and server busy/idle status.
- [ ] In the model section, map the queuing system elements: calling population, arrivals, services, system capacity, and queuing discipline.
- [ ] In the results section, separate raw results from interpretation.
- [ ] In the discussion section, explain why high utilization can be good for efficiency but bad if it causes long waiting times.
- [ ] In the recommendation section, recommend the improvement scenario only after comparing metrics.
- [ ] Include enough formulas to show understanding, but keep the report readable.

Useful formulas to include:

```text
Inter-arrival time = -ln(R) / lambda
Service time = -ln(R) / mu
Waiting time = service start time - arrival time
Doctor utilization = doctor busy time / total available doctor time
Average waiting time = total waiting time / total patients served
```

## Presentation Todo

- [ ] Maximum 10 slides.
- [ ] Slide 1: title, group members, problem.
- [ ] Slide 2: objectives and model overview.
- [ ] Slide 3: assumptions and input parameters.
- [ ] Slide 4: queue structure and priority logic.
- [ ] Slide 5: simulation method or flowchart.
- [ ] Slide 6: baseline results.
- [ ] Slide 7: improvement scenario results.
- [ ] Slide 8: comparison and key insights.
- [ ] Slide 9: recommendation and conclusion.
- [ ] Slide 10: Q&A backup or references if needed.
- [ ] Keep speaking content to about 5 minutes.
- [ ] Prepare answers for why Poisson arrivals, why exponential service times, why chosen parameters, and why the improvement is justified.
- [ ] Export slides as PDF.

Q&A preparation:

- [ ] Why random numbers? To model real-life uncertainty.
- [ ] Why exponential inter-arrival time? It is commonly used for Poisson arrival processes.
- [ ] Why priority queue? Emergency departments treat more serious patients first.
- [ ] Why multiple doctors? The assignment rubric gives the highest level for multiple doctors with priority queue.
- [ ] Did you use LCG? Answer: we use Octave/FreeMat `rand()` as the pseudo-random generator; LCG is discussed as theoretical background from Lecture 04.
- [ ] How do you know the improvement works? Answer using metric comparison, not opinion.

## Rubric Checklist

### 6.1 Simulation Model, 12 Marks

Component A, Model Design and Implementation:

- [ ] Level 4 target: priority queue model with multiple doctors.
- [ ] Correct priority handling.
- [ ] Correct queue logic.
- [ ] Fully functional and stable code.
- [ ] Code handles arrivals, queue selection, service start, service completion, and doctor availability.
- [ ] Code produces repeatable output when a seed is set.

Component B, Arrival and Service Modelling:

- [ ] Clearly define arrival distribution.
- [ ] Clearly define service-time distribution.
- [ ] Use realistic and justified parameters.
- [ ] Explain peak versus non-peak rates if used.
- [ ] Explain how assumptions affect system behaviour.
- [ ] Show how uniform `rand()` is transformed into exponential and discrete random variables.

Component C, Results Interpretation and Functionality:

- [ ] Accurately compute all metrics.
- [ ] Clearly interpret the meaning of the metrics.
- [ ] Compare scenarios.
- [ ] Justify improvement recommendation based on results.
- [ ] Discuss the trade-off between waiting time and doctor utilization.

### 6.2 Documentation, 4 Marks

- [ ] Include all expected report components.
- [ ] Make the report well-structured.
- [ ] Explain methodology, application, and results clearly.
- [ ] Include meaningful insights and recommendations.

### 6.3 Presentation, 4 Marks

- [ ] Present model, assumptions, and results logically.
- [ ] Demonstrate understanding of queuing theory and simulation choices.
- [ ] Answer Q&A confidently with justification.
- [ ] Avoid vague claims; support answers with metrics.

## Academic Integrity Todo

- [ ] Make sure the group independently develops the work.
- [ ] Cite sources for hospital arrival/service assumptions, charts, or external references.
- [ ] Do not copy code or report text from online sources without citation.
- [ ] Keep similarity well below the 50% penalty warning threshold.

## Common Mistakes To Avoid

- [ ] Do not confuse average service time with average waiting time.
- [ ] Do not calculate utilization as only `busy doctors / total doctors` at one moment; use busy time over total simulation time.
- [ ] Do not ignore patients who wait past the simulation horizon without explaining the rule.
- [ ] Do not use a priority queue but accidentally serve FIFO only.
- [ ] Do not compare scenarios using different assumptions unless the changed assumption is the actual scenario.
- [ ] Do not present random output from only one run as final evidence; use repeated runs or explain the limitation.
- [ ] Do not forget README instructions for running the `.m` file.
- [ ] Do not exceed 10 presentation slides or 10 report pages.
- [ ] Do not submit code without graphs/tables and interpretation.

## Suggested Work Plan

- [ ] Day 1: finalize assumptions, parameters, and scenario design.
- [ ] Day 2: implement baseline priority multi-doctor simulation in Octave/FreeMat.
- [ ] Day 3: implement improvement scenarios and repeated runs.
- [ ] Day 4: generate metrics, tables, and graphs.
- [ ] Day 5: write report draft.
- [ ] Day 6: prepare presentation slides.
- [ ] Day 7: test code, proofread report, rehearse Q&A, and export PDFs.

Updated work order:

- [ ] Step 1: implement a working two-doctor or three-doctor FIFO model first.
- [ ] Step 2: add priority queue logic.
- [ ] Step 3: add repeated replications and averaged metrics.
- [ ] Step 4: add improvement scenario.
- [ ] Step 5: generate final tables and graphs.
- [ ] Step 6: write report around the rubric, not around the code only.
- [ ] Step 7: prepare slides from the report's strongest results.

## Files To Create Next

- [ ] `simulation_ed_queue.m`
- [ ] `README.md`
- [ ] `report_draft.md` or report document
- [ ] `slides_outline.md`
- [ ] `results/` folder for tables and graphs
