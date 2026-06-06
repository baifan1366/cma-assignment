function print_evaluation_details(cfg, result)
%PRINT_EVALUATION_DETAILS Print detailed performance metrics.

fprintf('\n%s\n', repeat_char('=', 76));
fprintf(' Result Evaluation Details\n');
fprintf('%s\n', repeat_char('=', 76));
fprintf('Total patients generated              : %d\n', result.total_arrivals);
fprintf('Patients served within shift          : %d\n', result.patients_served_within_shift);
fprintf('Average inter-arrival time            : %.2f minutes\n', result.average_interarrival_time);
fprintf('Average service time                  : %.2f minutes\n', result.average_service_time);
fprintf('Average waiting time                  : %.2f minutes\n', result.average_waiting_time);
fprintf('Average queue length                  : %.2f patients\n', result.average_queue_length);
fprintf('Average time spent in system          : %.2f minutes\n', result.average_time_in_system);
fprintf('Probability patient waits             : %.2f\n', result.probability_waiting);
fprintf('Overall doctor utilization            : %.2f%%\n', result.overall_doctor_utilization * 100);

fprintf('\nDoctor Utilization\n');
fprintf('%s\n', repeat_char('-', 76));
for d = 1:cfg.num_doctors
    fprintf('Doctor %d utilization                  : %.2f%%\n', d, result.doctor_utilization(d) * 100);
endfor

fprintf('\nAverage Waiting Time by Priority\n');
fprintf('%s\n', repeat_char('-', 76));
for p = 1:length(cfg.priority_values)
    fprintf('Priority %d %-12s waiting time     : %.2f minutes\n', ...
        cfg.priority_values(p), cfg.priority_labels{p}, result.average_waiting_time_by_priority(p));
endfor
fprintf('%s\n', repeat_char('=', 76));

endfunction
