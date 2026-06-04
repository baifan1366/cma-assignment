function print_summary_table(scenarios, doctors, priority_queue, rows)
%PRINT_SUMMARY_TABLE Print a presentation-friendly result summary.

line = repeat_char('-', 119);

fprintf('\n%s\n', line);
fprintf(' Hospital Emergency Department Queue Simulation - Scenario Comparison\n');
fprintf('%s\n', line);
fprintf(' Replications: averaged result | Time unit: minutes | arrivals stop at the configured shift end\n');
fprintf('%s\n', line);
fprintf(' %-10s %7s %9s %9s %9s %10s %9s %10s %8s\n', ...
    'Scenario', 'Doctors', 'Priority', 'Arrivals', 'Served', 'Avg Wait', 'Avg Q', 'Wait Prob', 'Util');
fprintf('%s\n', line);

for i = 1:length(scenarios)
    priority_text = 'No';
    if priority_queue(i)
        priority_text = 'Yes';
    endif

    fprintf(' %-10s %7d %9s %9.2f %9.2f %10.2f %9.2f %10.2f %7.1f%%\n', ...
        scenarios{i}, ...
        doctors(i), ...
        priority_text, ...
        rows(i, 1), ...
        rows(i, 2), ...
        rows(i, 3), ...
        rows(i, 4), ...
        rows(i, 6), ...
        rows(i, 7) * 100);
endfor

fprintf('%s\n', line);
fprintf('\nPriority Waiting Time Breakdown\n');
fprintf('%s\n', repeat_char('-', 68));
fprintf(' %-10s %14s %14s %14s\n', 'Scenario', 'P1 Critical', 'P2 Urgent', 'P3 Non-urgent');
fprintf('%s\n', repeat_char('-', 68));

for i = 1:length(scenarios)
    fprintf(' %-10s %14.2f %14.2f %14.2f\n', ...
        scenarios{i}, rows(i, 10), rows(i, 11), rows(i, 12));
endfor

fprintf('%s\n', repeat_char('-', 68));

[best_wait, best_wait_index] = min(rows(:, 3));
[best_served, best_served_index] = max(rows(:, 2));
[best_critical_wait, best_critical_index] = min(rows(:, 10));

fprintf('\nKey Insights\n');
fprintf('- Lowest average waiting time: %s (%.2f minutes)\n', scenarios{best_wait_index}, best_wait);
fprintf('- Highest patients served within shift: %s (%.2f patients)\n', scenarios{best_served_index}, best_served);
fprintf('- Lowest critical-patient waiting time: %s (%.2f minutes)\n', scenarios{best_critical_index}, best_critical_wait);

fprintf('\nRecommended scenario: %s\n', scenarios{best_wait_index});
fprintf('Reason: it gives the lowest overall waiting time while keeping critical-patient waiting time low.\n');

endfunction
