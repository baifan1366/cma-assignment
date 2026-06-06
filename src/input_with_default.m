function value = input_with_default(label, default_value)
%INPUT_WITH_DEFAULT Read a numeric input, using a default for empty input.

prompt = sprintf('%s [%.4f]: ', label, default_value);
value = input(prompt);

if isempty(value)
    value = default_value;
endif

endfunction
