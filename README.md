# Hospital Emergency Department Queue Simulation

This project simulates a hospital emergency department queuing system for the CMA6134 assignment.

## Model

- Multiple doctors serve arriving patients.
- Patient arrivals follow a Poisson process, implemented using exponential inter-arrival times.
- Service periods follow exponential distributions.
- Patient priority is generated using a discrete distribution.
- The baseline model uses a priority queue with FIFO order inside the same priority level.

## Files

- `config.m` stores the scenario settings and random-variable parameters.
- `run_simulation.m` runs all scenarios and writes result CSV files.
- `src/simulate_ed_queue.m` contains the event-based queue simulation.
- `src/draw_exponential.m` generates exponential random variables.
- `src/draw_priority.m` generates discrete patient priorities.
- `src/select_next_patient.m` implements FIFO or priority queue selection.
- `src/write_metrics_csv.m` writes metric tables to CSV files.
- `src/write_patient_csv.m` writes a patient-level simulation table for one sample run.
- `src/write_summary_csv.m` writes scenario comparison results.
- `results/` stores generated output files.

## How To Run

Open Octave or FreeMat in this folder and run:

```octave
run_simulation
```

The output CSV files will be saved in `results/`.
Each scenario produces a replication summary and a sample patient-level table.
The runner also prints a formatted comparison table and writes `results/scenario_summary.md`.

## Scenarios

- `baseline`: 3 doctors with priority queue.
- `improved`: 4 doctors with priority queue.
- `fifo`: 3 doctors with FIFO queue.

## Key Parameters

The main settings are in `config.m`:

- `cfg.num_doctors`
- `cfg.simulation_horizon`
- `cfg.num_replications`
- `cfg.mean_interarrival_time`
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
