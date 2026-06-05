% Main runner for the hospital emergency department queue simulation.
% Run this file in Octave or FreeMat from the project root.

addpath('src');

if exist('results', 'dir') ~= 7
    mkdir('results');
endif

scenarios = {'baseline', 'improved', 'fifo'};
num_scenarios = length(scenarios);
scenario_doctors = zeros(1, num_scenarios);
scenario_priority_queue = zeros(1, num_scenarios);
sample_results = cell(1, num_scenarios);

summary_rows = zeros(num_scenarios, 12);

for s = 1:num_scenarios
    cfg = config(scenarios{s});
    scenario_doctors(s) = cfg.num_doctors;
    scenario_priority_queue(s) = cfg.use_priority_queue;

    replication_metrics = zeros(cfg.num_replications, 12);
    first_result = [];

    for r = 1:cfg.num_replications
        rand('seed', cfg.random_seed + r);
        result = simulate_ed_queue(cfg);
        if r == 1
            first_result = result;
        endif

        replication_metrics(r, :) = [
            result.total_arrivals, ...
            result.total_patients, ...
            result.average_waiting_time, ...
            result.average_queue_length, ...
            result.average_time_in_system, ...
            result.probability_waiting, ...
            result.overall_doctor_utilization, ...
            result.total_simulation_time, ...
            result.last_departure_time, ...
            result.average_waiting_time_by_priority(1), ...
            result.average_waiting_time_by_priority(2), ...
            result.average_waiting_time_by_priority(3)
        ];
    endfor

    mean_metrics = mean(replication_metrics, 1);
    summary_rows(s, :) = mean_metrics;

    write_metrics_csv(['results/' scenarios{s} '_replications.csv'], replication_metrics);
    write_patient_csv(['results/' scenarios{s} '_patients_sample.csv'], first_result);
    sample_results{s} = first_result;
endfor

display_cfg = config('baseline');
print_probability_tables(display_cfg);
write_probability_tables('results/probability_tables.md', display_cfg);
print_simulation_tables(scenarios, sample_results, 8);
write_summary_csv('results/scenario_summary.csv', scenarios, summary_rows);
write_summary_markdown('results/scenario_summary.md', scenarios, scenario_doctors, scenario_priority_queue, summary_rows);
print_summary_table(scenarios, scenario_doctors, scenario_priority_queue, summary_rows);

fprintf('\nSummary saved to results/scenario_summary.csv\n');
fprintf('Markdown summary saved to results/scenario_summary.md\n');
fprintf('Probability tables saved to results/probability_tables.md\n');
