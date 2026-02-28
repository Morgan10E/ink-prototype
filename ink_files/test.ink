VAR timed_seconds = 10

Once upon a time... #timed_choice
~ timed_seconds = 10
 * [There were two choices.] -> label_1
 * [There were four lines of content.] -> label_2
 * [timeout_target] -> oh_no
 
 === oh_no ===
 Oh no! You ran out of time :(
 -> end
 
 === label_1 ===
 You selected "two choices."
 -> end
 
 === label_2 ===
 You selected "four lines."
 -> end

=== end ===
- They lived happily ever after.
    -> END
