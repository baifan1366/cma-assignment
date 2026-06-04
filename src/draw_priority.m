function priority = draw_priority(priority_values, priority_cdf)
%DRAW_PRIORITY Generate a discrete patient priority from a CDF.

R = rand();
position = find(R <= priority_cdf, 1);
priority = priority_values(position);

endfunction
