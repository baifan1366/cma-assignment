function result = simulate_ed_queue(cfg)
%SIMULATE_ED_QUEUE Event-based multi-doctor emergency queue simulation.

arrival_times = [];
priorities = [];
service_times = [];

clock = 0;
while clock < cfg.simulation_horizon
    inter_arrival_time = draw_exponential(cfg.arrival_lambda);
    clock = clock + inter_arrival_time;

    if clock <= cfg.simulation_horizon
        priority = draw_priority(cfg.priority_values, cfg.priority_cdf);
        mu = cfg.service_mu_by_priority(priority);
        service_time = draw_exponential(mu);

        arrival_times = [arrival_times, clock];
        priorities = [priorities, priority];
        service_times = [service_times, service_time];
    endif
endwhile

total_patients = length(arrival_times);

if total_patients == 0
    result.arrival_times = [];
    result.priorities = [];
    result.service_times = [];
    result.service_start_times = [];
    result.service_end_times = [];
    result.assigned_doctors = [];
    result.waiting_times = [];
    result.time_in_system = [];
    result.doctor_busy_time = zeros(1, cfg.num_doctors);
    result.doctor_utilization = zeros(1, cfg.num_doctors);
    result.total_arrivals = 0;
    result.total_patients = 0;
    result.patients_served_within_shift = 0;
    result.average_waiting_time = 0;
    result.average_waiting_time_by_priority = zeros(1, length(cfg.priority_values));
    result.average_queue_length = 0;
    result.average_time_in_system = 0;
    result.probability_waiting = 0;
    result.overall_doctor_utilization = 0;
    result.total_simulation_time = cfg.simulation_horizon;
    result.simulation_horizon = cfg.simulation_horizon;
    result.last_departure_time = 0;
    return;
endif

service_start_times = zeros(1, total_patients);
service_end_times = zeros(1, total_patients);
assigned_doctors = zeros(1, total_patients);

doctor_busy_until = zeros(1, cfg.num_doctors);
doctor_current_patient = zeros(1, cfg.num_doctors);
doctor_busy_time = zeros(1, cfg.num_doctors);

queue = [];
next_arrival_index = 1;
completed_patients = 0;
last_event_time = 0;
queue_area = 0;

while completed_patients < total_patients
    next_arrival_time = Inf;
    if next_arrival_index <= total_patients
        next_arrival_time = arrival_times(next_arrival_index);
    endif

    busy_doctors = find(doctor_current_patient > 0);
    next_departure_time = Inf;
    if ~isempty(busy_doctors)
        next_departure_time = min(doctor_busy_until(busy_doctors));
    endif

    next_event_time = min(next_arrival_time, next_departure_time);
    queue_area = queue_area + length(queue) * (next_event_time - last_event_time);
    last_event_time = next_event_time;

    clock = next_event_time;

    departing_doctors = find((doctor_current_patient > 0) & (abs(doctor_busy_until - clock) < 1e-9));
    for k = 1:length(departing_doctors)
        d = departing_doctors(k);
        doctor_current_patient(d) = 0;
        completed_patients = completed_patients + 1;
    endfor

    while (next_arrival_index <= total_patients) && (abs(arrival_times(next_arrival_index) - clock) < 1e-9)
        queue = [queue, next_arrival_index];
        next_arrival_index = next_arrival_index + 1;
    endwhile

    idle_doctors = find(doctor_current_patient == 0);
    while ~isempty(idle_doctors) && ~isempty(queue)
        d = idle_doctors(1);
        selected_position = select_next_patient(queue, priorities, cfg.use_priority_queue);
        patient = queue(selected_position);
        queue(selected_position) = [];

        service_start_times(patient) = clock;
        service_end_times(patient) = clock + service_times(patient);
        assigned_doctors(patient) = d;

        doctor_current_patient(d) = patient;
        doctor_busy_until(d) = service_end_times(patient);
        doctor_busy_time(d) = doctor_busy_time(d) + service_times(patient);

        idle_doctors = find(doctor_current_patient == 0);
    endwhile
endwhile

waiting_times = service_start_times - arrival_times;
time_in_system = service_end_times - arrival_times;
last_departure_time = max(service_end_times);
total_simulation_time = max(cfg.simulation_horizon, last_departure_time);
patients_served_within_shift = sum(service_end_times <= cfg.simulation_horizon);
average_waiting_time_by_priority = zeros(1, length(cfg.priority_values));

for p = 1:length(cfg.priority_values)
    priority_value = cfg.priority_values(p);
    priority_indexes = find(priorities == priority_value);
    if isempty(priority_indexes)
        average_waiting_time_by_priority(p) = 0;
    else
        average_waiting_time_by_priority(p) = mean(waiting_times(priority_indexes));
    endif
endfor

result.arrival_times = arrival_times;
result.priorities = priorities;
result.service_times = service_times;
result.service_start_times = service_start_times;
result.service_end_times = service_end_times;
result.assigned_doctors = assigned_doctors;
result.waiting_times = waiting_times;
result.time_in_system = time_in_system;
result.doctor_busy_time = doctor_busy_time;
result.doctor_utilization = doctor_busy_time ./ total_simulation_time;

result.total_arrivals = total_patients;
result.total_patients = patients_served_within_shift;
result.patients_served_within_shift = patients_served_within_shift;
result.average_waiting_time = mean(waiting_times);
result.average_waiting_time_by_priority = average_waiting_time_by_priority;
result.average_queue_length = queue_area / total_simulation_time;
result.average_time_in_system = mean(time_in_system);
result.probability_waiting = sum(waiting_times > 1e-9) / total_patients;
result.overall_doctor_utilization = sum(doctor_busy_time) / (cfg.num_doctors * total_simulation_time);
result.total_simulation_time = total_simulation_time;
result.simulation_horizon = cfg.simulation_horizon;
result.last_departure_time = last_departure_time;

endfunction
