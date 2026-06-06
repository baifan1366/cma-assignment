# Hospital Emergency Department Queue Simulation

This project simulates a hospital emergency department queuing system for the CMA6134 assignment.

## Model

- Multiple doctors serve arriving patients.
- Patient arrivals follow a Poisson process, implemented using exponential inter-arrival times.
- The model uses different non-peak and peak arrival rates to represent busy emergency department periods.
- Service periods follow exponential distributions.
- Patient priority is generated using a discrete distribution.
- The model uses a 4-doctor priority queue with FIFO order inside the same priority level.

## Files

- `config.m` stores the scenario settings and random-variable parameters.
- `run_simulation.m` runs the 4-doctor priority model and writes result CSV files.
- `src/simulate_ed_queue.m` contains the event-based queue simulation.
- `src/draw_exponential.m` generates exponential random variables.
- `src/draw_priority.m` generates discrete patient priorities.
- `src/get_arrival_lambda.m` selects the non-peak or peak arrival rate.
- `src/print_probability_tables.m` prints lecture-style probability tables.
- `src/write_probability_tables.m` writes probability tables to Markdown.
- `src/print_doctor_simulation_tables.m` prints separate simulation tables for each doctor.
- `src/print_simulation_tables.m` prints sample patient-level simulation tables.
- `src/select_next_patient.m` implements priority queue selection with FIFO tie-breaking.
- `src/write_metrics_csv.m` writes metric tables to CSV files.
- `src/write_patient_csv.m` writes a patient-level simulation table for one sample run.
- `src/write_summary_csv.m` writes the performance summary results.
- `results/` stores generated output files.

## How To Run

Open Octave or FreeMat in this folder and run:

```octave
run_simulation
```

The output CSV files will be saved in `results/`.
The run produces a performance summary and a patient-level simulation table.
The runner also prints a formatted comparison table and writes `results/scenario_summary.md`.
The runner also writes `results/probability_tables.md`.

## Model

- `4-doctor-priority`: 4 doctors with priority queue.
- Patients with higher urgency are served first.
- Patients with the same priority are served using FIFO order.
- User inputs control patient count, peak/non-peak period, and arrival rates.
- User input also controls the random number generator: built-in `rand()`, LCG, ERVG, or URVG.

## Key Parameters

The main settings are in `config.m`:

- `cfg.num_doctors`
- `cfg.simulation_horizon`
- `cfg.num_replications`
- `cfg.mean_interarrival_time`
- `cfg.peak_mean_interarrival_time`
- `cfg.peak_start_time`
- `cfg.peak_end_time`
- `cfg.priority_probabilities`
- `cfg.mean_service_time_by_priority`

## Metrics

The simulation reports:

- Total patients served.
- Total patient arrivals.
- Patients served within the shift.
- Average waiting time.
- Average queue length.
- Average time in system.
- Probability that a patient waits.
- Doctor utilization.

## Metric Definitions

- Total patient arrivals: number of patients who arrive before the end of the shift.
- Patients served within the shift: number of patients whose service ends before the shift horizon.
- Average waiting time: mean of `service_start_time - arrival_time`.
- Average queue length: time-weighted queue length divided by the total simulated time.
- Average time in system: mean of `service_end_time - arrival_time`.
- Probability that a patient waits: proportion of patients with waiting time greater than zero.
- Doctor utilization: total doctor busy time divided by total available doctor time.
