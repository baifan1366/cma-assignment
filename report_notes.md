# Report Notes

## Rubric Alignment

The implemented model is designed to target the priority queue requirement in the assignment rubric:

- The model uses four doctors, so it is a multi-server queue.
- A priority queue is implemented for emergency department triage.
- Patients with lower priority numbers are served first.
- Patients with the same priority follow FIFO order.
- Arrivals are modelled as a Poisson process using exponential inter-arrival times.
- Service periods are modelled using exponential service times.
- Patient priority is generated from a discrete probability distribution.
- The program prints probability tables, a simulation table, and performance metrics.

## User Inputs

The program asks the user to enter:

- Number of patients to simulate.
- Simulation horizon in minutes.
- Non-peak arrival rate in patients per minute.
- Whether a peak period is used.
- Peak period start and end time.
- Peak arrival rate in patients per minute.

## Assumptions

The simulation uses minutes as the time unit.

Arrival process:

- Patient arrivals are assumed to follow a Poisson process.
- Therefore, inter-arrival times follow an exponential distribution.
- The user can define non-peak and peak arrival rates.

Service process:

- Service times are assumed to follow exponential distributions.
- Critical patients have a mean service time of 45 minutes.
- Urgent patients have a mean service time of 30 minutes.
- Non-urgent patients have a mean service time of 18 minutes.

Priority distribution:

- Priority 1 critical: 15%.
- Priority 2 urgent: 35%.
- Priority 3 non-urgent: 50%.

Queue discipline:

- Four doctors serve patients.
- Priority 1 patients are selected before Priority 2 and Priority 3.
- For patients with the same priority, FIFO order is used.
- If more than one doctor is idle, the next patient is assigned to the idle doctor with the lowest accumulated busy time. This reduces doctor assignment bias.

## Interpretation Guidance

The main purpose of priority queueing in an emergency department is not only to reduce the overall average waiting time. It is also to reduce waiting time for critical patients. Therefore, the report should discuss average waiting time by priority, especially Priority 1 critical patients.

## Recommended Discussion

The output should be discussed using:

- Probability tables for arrival, priority, and service assumptions.
- Simulation table showing patient-level arrival, service, waiting, and departure times.
- Performance metrics such as average waiting time, average queue length, doctor utilization, and probability of waiting.
