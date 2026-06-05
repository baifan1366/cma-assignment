function write_probability_tables(file_path, cfg)
%WRITE_PROBABILITY_TABLES Write model input probability tables to Markdown.

fid = fopen(file_path, 'w');
if fid < 0
    error('Could not open probability table output file.');
endif

fprintf(fid, '# Probability Tables / Input Distributions\n\n');

fprintf(fid, '## Arrival Process\n\n');
fprintf(fid, '| Period | Start | End | Mean Inter-arrival Time | Lambda |\n');
fprintf(fid, '|---|---:|---:|---:|---:|\n');
if cfg.use_peak_arrivals
    fprintf(fid, '| Non-peak 1 | 0 | %.0f | %.2f min | %.4f |\n', ...
        cfg.peak_start_time, cfg.mean_interarrival_time, cfg.arrival_lambda);
    fprintf(fid, '| Peak | %.0f | %.0f | %.2f min | %.4f |\n', ...
        cfg.peak_start_time, cfg.peak_end_time, cfg.peak_mean_interarrival_time, cfg.peak_arrival_lambda);
    fprintf(fid, '| Non-peak 2 | %.0f | %.0f | %.2f min | %.4f |\n', ...
        cfg.peak_end_time, cfg.simulation_horizon, cfg.mean_interarrival_time, cfg.arrival_lambda);
else
    fprintf(fid, '| Non-peak | 0 | %.0f | %.2f min | %.4f |\n', ...
        cfg.simulation_horizon, cfg.mean_interarrival_time, cfg.arrival_lambda);
endif
fprintf(fid, '\nFormula: `inter-arrival time = -log(1 - R) / lambda`\n\n');

fprintf(fid, '## Priority Distribution\n\n');
fprintf(fid, '| Priority | Label | Probability | CDF | R range |\n');
fprintf(fid, '|---:|---|---:|---:|---|\n');
lower_bound = 0;
for i = 1:length(cfg.priority_values)
    upper_bound = cfg.priority_cdf(i);
    fprintf(fid, '| %d | %s | %.2f | %.2f | %.2f <= R < %.2f |\n', ...
        cfg.priority_values(i), cfg.priority_labels{i}, cfg.priority_probabilities(i), ...
        cfg.priority_cdf(i), lower_bound, upper_bound);
    lower_bound = upper_bound;
endfor

fprintf(fid, '\n## Service Time Distribution\n\n');
fprintf(fid, '| Priority | Label | Mean Service Time | Mu |\n');
fprintf(fid, '|---:|---|---:|---:|\n');
for i = 1:length(cfg.priority_values)
    fprintf(fid, '| %d | %s | %.2f min | %.4f |\n', ...
        cfg.priority_values(i), cfg.priority_labels{i}, ...
        cfg.mean_service_time_by_priority(i), cfg.service_mu_by_priority(i));
endfor
fprintf(fid, '\nFormula: `service time = -log(1 - R) / mu`\n');

fclose(fid);

endfunction
