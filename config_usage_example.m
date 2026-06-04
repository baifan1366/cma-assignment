% Example only: shows how the main simulation can use config.m.

cfg = config('baseline');

rand("seed", cfg.random_seed);

% Inter-arrival time from exponential distribution:
% X = -log(1 - R) / lambda
inter_arrival_time = -log(1 - rand()) / cfg.arrival_lambda;

% Priority from discrete distribution.
R = rand();
priority = cfg.priority_values(find(R <= cfg.priority_cdf, 1));

% Service period from exponential distribution.
mu = cfg.service_mu_by_priority(priority);
service_time = -log(1 - rand()) / mu;

fprintf("Scenario: %s\n", cfg.scenario_name);
fprintf("Doctors: %d\n", cfg.num_doctors);
fprintf("Inter-arrival time: %.2f minutes\n", inter_arrival_time);
fprintf("Priority: %d (%s)\n", priority, cfg.priority_labels{priority});
fprintf("Service time: %.2f minutes\n", service_time);
