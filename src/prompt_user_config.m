function cfg = prompt_user_config(cfg)
%PROMPT_USER_CONFIG Collect simulation inputs from the user.

fprintf('\n%s\n', repeat_char('=', 76));
fprintf(' Hospital Emergency Department Priority Queue Input\n');
fprintf('%s\n', repeat_char('=', 76));
fprintf(' Model fixed by assignment design: 4 doctors + priority queue.\n');
fprintf(' Press Enter to accept the default value shown in brackets.\n');

fprintf('\nChoose Random Number Generator\n');
fprintf(' 1. Built-in rand()\n');
fprintf(' 2. Linear Congruential Generator (LCG)\n');
fprintf(' 3. Exponential Random Variate Generator (ERVG)\n');
fprintf(' 4. Uniform Random Variate Generator (URVG)\n');
cfg.rng_method = round(input_with_default('Select random number generator (1-4)', cfg.rng_method));
if (cfg.rng_method < 1) || (cfg.rng_method > 4)
    cfg.rng_method = 1;
endif

if cfg.rng_method == 2
    cfg.lcg_seed = round(input_with_default('LCG seed X0', cfg.lcg_seed));
    cfg.lcg_a = round(input_with_default('LCG multiplier a', cfg.lcg_a));
    cfg.lcg_c = round(input_with_default('LCG increment c', cfg.lcg_c));
    cfg.lcg_m = round(input_with_default('LCG modulus m', cfg.lcg_m));
    if cfg.lcg_m <= 0
        cfg.lcg_m = 10000;
    endif
endif

cfg.fixed_patient_count = round(input_with_default('Number of patients to simulate', cfg.fixed_patient_count));
if cfg.fixed_patient_count < 1
    cfg.fixed_patient_count = 1;
endif

cfg.simulation_horizon = input_with_default('Shift length / simulation horizon in minutes', cfg.simulation_horizon);
if cfg.simulation_horizon <= 0
    cfg.simulation_horizon = 480;
endif

cfg.arrival_lambda = input_with_default('Non-peak arrival rate lambda, patients per minute', cfg.arrival_lambda);
if cfg.arrival_lambda <= 0
    cfg.arrival_lambda = 1 / cfg.mean_interarrival_time;
endif
cfg.mean_interarrival_time = 1 / cfg.arrival_lambda;

cfg.use_peak_arrivals = input_with_default('Use peak period? 1 = yes, 0 = no', cfg.use_peak_arrivals);

if cfg.use_peak_arrivals
    cfg.peak_start_time = input_with_default('Peak period start time in minutes', cfg.peak_start_time);
    cfg.peak_end_time = input_with_default('Peak period end time in minutes', cfg.peak_end_time);
    if cfg.peak_start_time < 0
        cfg.peak_start_time = 0;
    endif
    if cfg.peak_end_time > cfg.simulation_horizon
        cfg.peak_end_time = cfg.simulation_horizon;
    endif
    if cfg.peak_end_time <= cfg.peak_start_time
        cfg.peak_start_time = 0;
        cfg.peak_end_time = cfg.simulation_horizon;
    endif
    cfg.peak_arrival_lambda = input_with_default('Peak arrival rate lambda, patients per minute', cfg.peak_arrival_lambda);
    if cfg.peak_arrival_lambda <= 0
        cfg.peak_arrival_lambda = 1 / cfg.peak_mean_interarrival_time;
    endif
    cfg.peak_mean_interarrival_time = 1 / cfg.peak_arrival_lambda;
endif

fprintf('%s\n', repeat_char('=', 76));

endfunction
