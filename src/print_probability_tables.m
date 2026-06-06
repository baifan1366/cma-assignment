function print_probability_tables(cfg)
%PRINT_PROBABILITY_TABLES Print model input probability tables.

fprintf('\n%s\n', repeat_char('=', 86));
fprintf(' Probability Tables / Input Distributions\n');
fprintf('%s\n', repeat_char('=', 86));

fprintf('\nRandom Number Generator\n');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-6s %-42s %-24s\n', 'No.', 'Generator', 'Status');
fprintf('%s\n', repeat_char('-', 86));
for i = 1:4
    status = '';
    if cfg.rng_method == i
        status = 'Selected';
    endif
    fprintf(' %-6d %-42s %-24s\n', i, cfg.rng_method_labels{i}, status);
endfor
fprintf('%s\n', repeat_char('-', 86));

if cfg.rng_method == 2
    fprintf(' LCG formula: X(i+1) = mod(a * X(i) + c, m), R = X / m\n');
    fprintf(' LCG parameters: X0=%d, a=%d, c=%d, m=%d\n', ...
        cfg.lcg_seed, cfg.lcg_a, cfg.lcg_c, cfg.lcg_m);
elseif cfg.rng_method == 3
    fprintf(' ERVG formula: X = -log(1 - R) / rate, using base R in [0,1]\n');
elseif cfg.rng_method == 4
    fprintf(' URVG formula: X = a + (b-a)R, using a=0 and b=1 for base R\n');
endif

fprintf('\nInput Parameters\n');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-32s %18s\n', 'Parameter', 'Value');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-32s %18d\n', 'Number of doctors', cfg.num_doctors);
fprintf(' %-32s %18d\n', 'Number of patients', cfg.fixed_patient_count);
fprintf(' %-32s %15.2f min\n', 'Simulation horizon', cfg.simulation_horizon);
fprintf(' %-32s %18d\n', 'Priority queue enabled', cfg.use_priority_queue);
fprintf('%s\n', repeat_char('-', 86));

fprintf('\nArrival Process: Exponential Inter-arrival Time\n');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-14s %12s %12s %18s %16s\n', 'Period', 'Start', 'End', 'Mean IAT', 'Lambda');
fprintf('%s\n', repeat_char('-', 86));
if cfg.use_peak_arrivals
    fprintf(' %-14s %12.0f %12.0f %15.2f min %16.4f\n', ...
        'Non-peak 1', 0, cfg.peak_start_time, cfg.mean_interarrival_time, cfg.arrival_lambda);
    fprintf(' %-14s %12.0f %12.0f %15.2f min %16.4f\n', ...
        'Peak', cfg.peak_start_time, cfg.peak_end_time, cfg.peak_mean_interarrival_time, cfg.peak_arrival_lambda);
    fprintf(' %-14s %12.0f %12.0f %15.2f min %16.4f\n', ...
        'Non-peak 2', cfg.peak_end_time, cfg.simulation_horizon, cfg.mean_interarrival_time, cfg.arrival_lambda);
else
    fprintf(' %-14s %12.0f %12.0f %15.2f min %16.4f\n', ...
        'Non-peak', 0, cfg.simulation_horizon, cfg.mean_interarrival_time, cfg.arrival_lambda);
endif
fprintf('%s\n', repeat_char('-', 86));
fprintf(' Generator: inter-arrival time = -log(1 - R) / lambda\n');

fprintf('\nPriority Distribution: Discrete Random Variable\n');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-10s %-14s %14s %14s %20s\n', 'Priority', 'Label', 'Probability', 'CDF', 'R range');
fprintf('%s\n', repeat_char('-', 86));

lower_bound = 0;
for i = 1:length(cfg.priority_values)
    upper_bound = cfg.priority_cdf(i);
    fprintf(' %-10d %-14s %14.2f %14.2f %9.2f <= R < %.2f\n', ...
        cfg.priority_values(i), cfg.priority_labels{i}, cfg.priority_probabilities(i), ...
        cfg.priority_cdf(i), lower_bound, upper_bound);
    lower_bound = upper_bound;
endfor
fprintf('%s\n', repeat_char('-', 86));

fprintf('\nService Time Distribution: Exponential by Priority\n');
fprintf('%s\n', repeat_char('-', 86));
fprintf(' %-10s %-14s %18s %16s\n', 'Priority', 'Label', 'Mean Service', 'Mu');
fprintf('%s\n', repeat_char('-', 86));
for i = 1:length(cfg.priority_values)
    fprintf(' %-10d %-14s %15.2f min %16.4f\n', ...
        cfg.priority_values(i), cfg.priority_labels{i}, ...
        cfg.mean_service_time_by_priority(i), cfg.service_mu_by_priority(i));
endfor
fprintf('%s\n', repeat_char('-', 86));
fprintf(' Generator: service time = -log(1 - R) / mu\n');

endfunction
