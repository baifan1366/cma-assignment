function print_simulation_tables(scenarios, sample_results, max_rows)
%PRINT_SIMULATION_TABLES Print sample patient-level simulation tables.

fprintf('\n%s\n', repeat_char('=', 120));
fprintf(' Simulation Tables / Sample Patient Records\n');
fprintf('%s\n', repeat_char('=', 120));
fprintf(' Showing the first %d patients from the first replication of each scenario.\n', max_rows);

for s = 1:length(scenarios)
    result = sample_results{s};
    row_count = min(max_rows, result.total_arrivals);

    fprintf('\nScenario: %s\n', scenarios{s});
    fprintf('%s\n', repeat_char('-', 120));
    fprintf(' %-7s %9s %8s %10s %11s %10s %10s %11s %8s %8s\n', ...
        'Patient', 'Arrival', 'Priority', 'Service', 'Start', 'Waiting', 'End', 'In System', 'Doctor', 'Served');
    fprintf('%s\n', repeat_char('-', 120));

    for i = 1:row_count
        served_within_shift = result.service_end_times(i) <= result.simulation_horizon;
        fprintf(' %-7d %9.2f %8d %10.2f %11.2f %10.2f %10.2f %11.2f %8d %8d\n', ...
            i, ...
            result.arrival_times(i), ...
            result.priorities(i), ...
            result.service_times(i), ...
            result.service_start_times(i), ...
            result.waiting_times(i), ...
            result.service_end_times(i), ...
            result.time_in_system(i), ...
            result.assigned_doctors(i), ...
            served_within_shift);
    endfor

    fprintf('%s\n', repeat_char('-', 120));
    fprintf(' Full patient table saved to results/%s_patients_sample.csv\n', scenarios{s});
endfor

endfunction
