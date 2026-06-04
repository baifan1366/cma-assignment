function x = draw_exponential(rate)
%DRAW_EXPONENTIAL Generate an exponential random variable.
%   Formula: X = -log(1 - R) / rate, where R is uniform on [0, 1].

R = rand();
x = -log(1 - R) / rate;

endfunction
