# Report Notes

## Rubric Alignment

The implemented model is designed to target the highest level of the assignment rubric:

- Multiple doctors are used in the baseline and improvement scenarios.
- A priority queue is implemented for emergency department triage.
- Patients with lower priority numbers are served first.
- Patients with the same priority follow FIFO order.
- Arrivals are modelled as a Poisson process using exponential inter-arrival times.
- Service periods are modelled using exponential service times.
- Patient priority is generated from a discrete probability distribution.
- The simulation compares baseline, improvement, and FIFO scenarios.

## Assumptions

The simulation uses minutes as the time unit and models an 8-hour emergency department shift.

Arrival process:

- Patient arrivals are assumed to follow a Poisson process.
- Therefore, inter-arrival times follow an exponential distribution.
- Non-peak mean inter-arrival time is 8 minutes.
- Peak mean inter-arrival time is 4 minutes.
- The peak period is from minute 120 to minute 360.

Service process:

- Service times are assumed to follow exponential distributions.
- Critical patients have a mean service time of 30 minutes.
- Urgent patients have a mean service time of 20 minutes.
- Non-urgent patients have a mean service time of 10 minutes.

Priority distribution:

- Priority 1 critical: 15%.
- Priority 2 urgent: 35%.
- Priority 3 non-urgent: 50%.

Queue discipline:

- Baseline and improvement scenarios use priority queue discipline.
- FIFO is used as a comparison scenario.
- For the same priority level, patients are served in arrival order.

## Interpretation Guidance

The FIFO scenario can sometimes have a lower overall average waiting time than a priority queue, but this does not mean FIFO is better for an emergency department. In FIFO, critical patients wait almost as long as non-urgent patients. In the priority queue, critical patients receive treatment much faster, while non-urgent patients may wait longer. This matches the clinical purpose of triage.

The improvement scenario adds one doctor. This usually lowers average waiting time, queue length, and waiting probability, and increases the number of patients served within the shift. The trade-off is that doctor utilization may decrease because capacity is higher.

## Recommended Result Discussion

The report should not recommend a scenario based only on overall average waiting time. It should consider:

- Waiting time for critical patients.
- Total patients served within the shift.
- Average queue length.
- Doctor utilization.
- Resource trade-off from adding doctors.

The most defensible recommendation is usually the improved priority scenario because it keeps critical-patient waiting time low and reduces overall congestion.
