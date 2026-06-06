function cfg = config()
%CONFIG Central settings for the emergency department queue simulation.
%   cfg = config() returns the default 4-doctor priority model settings.

cfg.scenario_name = '4-doctor-priority';

% General simulation settings.
cfg.simulation_horizon = 480;   % minutes, 8-hour shift
cfg.num_replications = 1;
cfg.random_seed = 6134;
cfg.time_unit = 'minutes';
cfg.num_doctors = 4;

% Random number generator selection.
% 1 = built-in rand(), 2 = LCG, 3 = ERVG, 4 = URVG.
cfg.rng_method = 1;
cfg.rng_method_labels = {'Built-in rand()', 'Linear Congruential Generator (LCG)', ...
    'Exponential Random Variate Generator (ERVG)', 'Uniform Random Variate Generator (URVG)'};

% LCG parameters, used when rng_method = 2.
cfg.lcg_seed = 46;
cfg.lcg_a = 13;
cfg.lcg_c = 53;
cfg.lcg_m = 10000;

% Patient count control.
% Set use_fixed_patients = true to simulate a fixed number of patients.
% Set use_fixed_patients = false to use time-based Poisson arrivals.
cfg.use_fixed_patients = true;
cfg.fixed_patient_count = 20;

% Arrival process.
% Poisson arrivals are simulated using exponential inter-arrival times.
% lambda is measured in patients per minute.
cfg.use_peak_arrivals = true;
cfg.mean_interarrival_time = 8;        % non-peak average, minutes
cfg.peak_mean_interarrival_time = 4;   % peak average, minutes
cfg.peak_start_time = 120;             % minute 120 to 360 is peak period
cfg.peak_end_time = 360;
cfg.arrival_lambda = 1 / cfg.mean_interarrival_time;
cfg.peak_arrival_lambda = 1 / cfg.peak_mean_interarrival_time;

% Priority distribution.
% Priority 1 = critical, Priority 2 = urgent, Priority 3 = non-urgent.
cfg.priority_labels = {'Critical', 'Urgent', 'Non-urgent'};
cfg.priority_values = [1, 2, 3];
cfg.priority_probabilities = [0.15, 0.35, 0.50];
cfg.priority_cdf = cumsum(cfg.priority_probabilities);

% Service process.
% Service times are exponential. The mean can depend on patient priority.
cfg.mean_service_time_by_priority = [45, 30, 18];  % minutes
cfg.service_mu_by_priority = 1 ./ cfg.mean_service_time_by_priority;

% Queue discipline.
% Higher urgency is represented by a lower priority number.
% Patients with the same priority are served FIFO.
cfg.use_priority_queue = true;

endfunction
