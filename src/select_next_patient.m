function selected_position = select_next_patient(queue, priorities, use_priority_queue)
%SELECT_NEXT_PATIENT Choose the next patient from the waiting queue.
%   Priority queue: lowest priority number first, FIFO for ties.
%   FIFO queue: first patient in the queue.

if use_priority_queue
    queue_priorities = priorities(queue);
    best_priority = min(queue_priorities);
    selected_position = find(queue_priorities == best_priority, 1);
else
    selected_position = 1;
endif

endfunction
