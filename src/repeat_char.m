function text = repeat_char(ch, count)
%REPEAT_CHAR Build a repeated-character string for console tables.

text = '';
for i = 1:count
    text = [text ch];
endfor

endfunction
