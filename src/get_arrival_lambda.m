function lambda = get_arrival_lambda(cfg, clock)
%GET_ARRIVAL_LAMBDA Return the arrival rate at the current simulation time.

lambda = cfg.arrival_lambda;

if cfg.use_peak_arrivals
    if (clock >= cfg.peak_start_time) && (clock < cfg.peak_end_time)
        lambda = cfg.peak_arrival_lambda;
    endif
endif

endfunction
