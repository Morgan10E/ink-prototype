VAR opened_suspicious_box = false

=== skull ===
Wh- why is there a skull here?
Best to leave it alone...
-> END

=== suspicious_box ===
{
    - opened_suspicious_box:
        There's still nothing inside, but the ominous feeling hasn't left you.
        -> END
    - else:
        You can't put your finger on it, but something is up with this box...
        * [Open the box] You open the box.
        ~ opened_suspicious_box = true
        Strange... there's nothing inside.
        -> END
        * [Leave it, way too suspicious] You're right, that's the safer call.
        -> END
}

=== wall ===
Nothing interesting to report. It's a featureless wall.
-> END
