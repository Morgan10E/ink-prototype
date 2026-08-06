=== skull ===
Wh- why is there a skull here?
Best to leave it alone...
-> END

=== suspicious_box ===
    ~ temp opened_suspicious_box = get_string("demo_chest") == "open"
    ~ temp times_looked_at_box = get_int("times_looked")
    ~ times_looked_at_box = times_looked_at_box + 1
    ~ set_state("times_looked", times_looked_at_box)
    { times_looked_at_box > 3:
        You're really into this box, huh?
    }
{
    - opened_suspicious_box:
        There's still nothing inside, but the ominous feeling hasn't left you.
        -> END
    - else:
        You can't put your finger on it, but something is up with this box... #timed_choice #time:10
        + [Open the box] You open the box.
        ~ set_state("demo_chest", "open")
        Strange... there's nothing inside.
        -> END
        + [Leave it, way too suspicious] You're right, that's the safer call.
        -> END
        + [timeout_target:Become overwhelmed by the creep factor] The unsettling feeling is too intense.
        You'll just come back later...
        -> END
}

=== wall ===
Nothing interesting to report. It's a featureless wall.
-> END
