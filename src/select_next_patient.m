function selected_position = select_next_patient(queue, priorities)
%SELECT_NEXT_PATIENT Choose the next patient from the waiting queue.
%   Lowest priority number is served first. FIFO is used for ties.

queue_priorities = priorities(queue);
best_priority = min(queue_priorities);
selected_position = find(queue_priorities == best_priority, 1);

endfunction
