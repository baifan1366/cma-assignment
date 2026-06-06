function print_doctor_simulation_tables(cfg, result)
%PRINT_DOCTOR_SIMULATION_TABLES Print one service table for each doctor.

fprintf('\n%s\n', repeat_char('=', 120));
fprintf(' Doctor Simulation Tables / Patients Served by Each Doctor\n');
fprintf('%s\n', repeat_char('=', 120));

for d = 1:cfg.num_doctors
    patients = find(result.assigned_doctors == d);

    fprintf('\nDoctor %d Simulation Table\n', d);
    fprintf('%s\n', repeat_char('-', 120));
    fprintf(' %-3s %7s %7s %3s %7s %7s %7s %7s %7s %7s\n', ...
        'n', 'Arrive', 'RN-Svc', 'Pri', 'Svc', 'Begin', 'End', 'Wait', 'Spend', 'Done');
    fprintf('%s\n', repeat_char('-', 120));

    if isempty(patients)
        fprintf(' No patients served by Doctor %d in this run.\n', d);
    else
        for k = 1:length(patients)
            i = patients(k);
            served_within_shift = result.service_end_times(i) <= result.simulation_horizon;
            fprintf(' %-3d %7.2f %7.4f %3d %7.2f %7.2f %7.2f %7.2f %7.2f %7d\n', ...
                i, ...
                result.arrival_times(i), ...
                result.rn_service(i), ...
                result.priorities(i), ...
                result.service_times(i), ...
                result.service_start_times(i), ...
                result.service_end_times(i), ...
                result.waiting_times(i), ...
                result.time_in_system(i), ...
                served_within_shift);
        endfor
    endif

    fprintf('%s\n', repeat_char('-', 120));
endfor

endfunction
