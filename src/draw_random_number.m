function [R, rng_state] = draw_random_number(cfg, rng_state)
%DRAW_RANDOM_NUMBER Generate a U(0,1) random number using the selected method.

if cfg.rng_method == 2
    rng_state = mod(cfg.lcg_a * rng_state + cfg.lcg_c, cfg.lcg_m);
    R = rng_state / cfg.lcg_m;
    if R <= 0
        R = 1 / cfg.lcg_m;
    endif
elseif cfg.rng_method == 3
    % ERVG uses a base uniform R and transforms it with the exponential formula.
    R = rand();
elseif cfg.rng_method == 4
    % URVG on [0,1]: X = a + (b-a)R with a=0 and b=1.
    R = 0 + (1 - 0) * rand();
else
    R = rand();
endif

if R >= 1
    R = 0.999999;
endif

endfunction
