function write_summary_markdown(file_path, scenarios, doctors, priority_queue, rows)
%WRITE_SUMMARY_MARKDOWN Write a report-friendly Markdown summary table.

fid = fopen(file_path, 'w');
if fid < 0
    error('Could not open markdown output file.');
endif

fprintf(fid, '# Scenario Comparison Summary\n\n');
fprintf(fid, '| Scenario | Doctors | Priority Queue | Arrivals | Served Within Shift | Avg Wait (min) | Avg Queue | Wait Prob. | Utilization |\n');
fprintf(fid, '|---|---:|---|---:|---:|---:|---:|---:|---:|\n');

for i = 1:length(scenarios)
    priority_text = 'No';
    if priority_queue(i)
        priority_text = 'Yes';
    endif

    fprintf(fid, '| %s | %d | %s | %.2f | %.2f | %.2f | %.2f | %.2f | %.1f%% |\n', ...
        scenarios{i}, doctors(i), priority_text, rows(i, 1), rows(i, 2), ...
        rows(i, 3), rows(i, 4), rows(i, 6), rows(i, 7) * 100);
endfor

fprintf(fid, '\n## Priority Waiting Time Breakdown\n\n');
fprintf(fid, '| Scenario | P1 Critical (min) | P2 Urgent (min) | P3 Non-urgent (min) |\n');
fprintf(fid, '|---|---:|---:|---:|\n');

for i = 1:length(scenarios)
    fprintf(fid, '| %s | %.2f | %.2f | %.2f |\n', ...
        scenarios{i}, rows(i, 10), rows(i, 11), rows(i, 12));
endfor

[best_wait, best_wait_index] = min(rows(:, 3));
[best_served, best_served_index] = max(rows(:, 2));
[best_critical_wait, best_critical_index] = min(rows(:, 10));

fprintf(fid, '\n## Key Insights\n\n');
fprintf(fid, '- Lowest average waiting time: **%s** (%.2f minutes).\n', scenarios{best_wait_index}, best_wait);
fprintf(fid, '- Highest patients served within shift: **%s** (%.2f patients).\n', scenarios{best_served_index}, best_served);
fprintf(fid, '- Lowest critical-patient waiting time: **%s** (%.2f minutes).\n', scenarios{best_critical_index}, best_critical_wait);

fclose(fid);

endfunction
