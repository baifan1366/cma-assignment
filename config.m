function cfg = config(scenario)
%CONFIG Central settings for the emergency department queue simulation.
%   cfg = config() returns the baseline scenario.
%   cfg = config('improved') returns an example improvement scenario.

if nargin < 1
    scenario = 'baseline';
endif

cfg.scenario_name = scenario;

% General simulation settings.
cfg.simulation_horizon = 480;   % minutes, 8-hour shift
cfg.num_replications = 30;
cfg.random_seed = 6134;
cfg.time_unit = 'minutes';

% Arrival process.
% Poisson arrivals are simulated using exponential inter-arrival times.
% lambda is measured in patients per minute.
<<<<<<< HEAD
% To reflect busy emergency department periods, the model uses a higher
% arrival rate during the middle part of the shift.
cfg.use_peak_arrivals = true;
cfg.mean_interarrival_time = 8;        % non-peak average, minutes
cfg.peak_mean_interarrival_time = 4;   % peak average, minutes
cfg.peak_start_time = 120;             % minute 120 to 360 is peak period
cfg.peak_end_time = 360;
cfg.arrival_lambda = 1 / cfg.mean_interarrival_time;
cfg.peak_arrival_lambda = 1 / cfg.peak_mean_interarrival_time;
=======
cfg.mean_interarrival_time = 6;
cfg.arrival_lambda = 1 / cfg.mean_interarrival_time;
>>>>>>> 98a47cf510c2ed0828206d25de21103eaff1de40

% Priority distribution.
% Priority 1 = critical, Priority 2 = urgent, Priority 3 = non-urgent.
cfg.priority_labels = {'Critical', 'Urgent', 'Non-urgent'};
cfg.priority_values = [1, 2, 3];
cfg.priority_probabilities = [0.15, 0.35, 0.50];
cfg.priority_cdf = cumsum(cfg.priority_probabilities);

% Service process.
% Service times are exponential. The mean can depend on patient priority.
cfg.mean_service_time_by_priority = [30, 20, 10];  % minutes
cfg.service_mu_by_priority = 1 ./ cfg.mean_service_time_by_priority;

% Queue discipline.
% Higher urgency is represented by a lower priority number.
% Patients with the same priority are served FIFO.
cfg.use_priority_queue = true;

if strcmpi(scenario, 'baseline')
    cfg.num_doctors = 3;
elseif strcmpi(scenario, 'improved')
    cfg.num_doctors = 4;
elseif strcmpi(scenario, 'fifo')
    cfg.num_doctors = 3;
    cfg.use_priority_queue = false;
else
    error('Unknown scenario. Use baseline, improved, or fifo.');
endif

endfunction
