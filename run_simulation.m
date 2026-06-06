% Main runner for the hospital emergency department priority queue simulation.
% Run this file in Octave or FreeMat from the project root.

addpath('src');

if exist('results', 'dir') ~= 7
    mkdir('results');
endif

cfg = config();
cfg = prompt_user_config(cfg);

rand('seed', cfg.random_seed);
result = simulate_ed_queue(cfg);

scenario_name = cfg.scenario_name;
scenarios = {scenario_name};
scenario_doctors = cfg.num_doctors;
scenario_priority_queue = cfg.use_priority_queue;

summary_rows = [
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

write_metrics_csv('results/priority_model_metrics.csv', summary_rows);
write_patient_csv('results/priority_model_simulation_table.csv', result);
write_summary_csv('results/scenario_summary.csv', scenarios, summary_rows);
write_summary_markdown('results/scenario_summary.md', scenarios, scenario_doctors, scenario_priority_queue, summary_rows);

print_probability_tables(cfg);
write_probability_tables('results/probability_tables.md', cfg);
print_doctor_simulation_tables(cfg, result);
print_simulation_tables(scenarios, {result}, result.total_arrivals);
print_evaluation_details(cfg, result);

fprintf('\nOutput files saved:\n');
fprintf('- results/probability_tables.md\n');
fprintf('- results/priority_model_simulation_table.csv\n');
fprintf('- results/priority_model_metrics.csv\n');
fprintf('- results/scenario_summary.csv\n');
fprintf('- results/scenario_summary.md\n');
