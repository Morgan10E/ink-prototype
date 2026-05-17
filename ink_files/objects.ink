VAR opened_suspicious_box = false

=== skull ===
Wh- why is there a skull here?
Best to leave it alone...
-> END

=== suspicious_box ===

You can't put your finger on it, but something is up with this box...
* [Open the box] You open the box.
~ opened_suspicious_box = true
Strange... there's nothing inside.
* [Leave it, way too suspicious] You're right, that's the safer call.
- -> END


=== wall ===
Nothing interesting to report. It's a featureless wall.
-> END
