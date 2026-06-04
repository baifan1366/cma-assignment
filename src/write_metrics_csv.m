function write_metrics_csv(file_path, rows)
%WRITE_METRICS_CSV Write metric rows with a simple CSV header.

fid = fopen(file_path, 'w');
if fid < 0
    error('Could not open output file.');
endif

fprintf(fid, 'total_arrivals,patients_served_within_shift,average_waiting_time,average_queue_length,average_time_in_system,probability_waiting,doctor_utilization,total_simulation_time,last_departure_time,avg_wait_priority_1,avg_wait_priority_2,avg_wait_priority_3\n');

for i = 1:size(rows, 1)
    fprintf(fid, '%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n', rows(i, :));
endfor

fclose(fid);

endfunction
