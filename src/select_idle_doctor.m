function doctor = select_idle_doctor(idle_doctors, doctor_busy_time)
%SELECT_IDLE_DOCTOR Choose the idle doctor with the lowest accumulated busy time.

idle_busy_times = doctor_busy_time(idle_doctors);
[~, position] = min(idle_busy_times);
doctor = idle_doctors(position);

endfunction
