=== npc1 ===
Oh, hello! # name:npc1
Didn't expect to see you around. # name:npc1
What's up? # name:npc1
+ [Nothing] Nothing much. # name:pc
-> brief_bye
+ Uh, the sky? # name:pc
-> brief_bye
+ [I'm running for mayor, have you heard?] I really think I can make a difference! # name:pc
-> running

=== brief_bye ===
'kay... # name:npc1
-> END

=== running ===
Oh yeah, I think I heard that... # name:npc1
What's your platform? # name:npc1
+ [Universal healthcare.] Those bills were killer after my accident. # name:pc
-> healthcare
+ [What do you think they should be?] # name:pc
-> they_pick
+ [I just want people to do what I say.] And monarchy isn't a thing here, so... # name:pc
-> ruler

=== healthcare ===
Oh, yeah, that sounds tough. # name:npc1
Don't know much about that though. # name:npc1
Sounds expensive? # name:npc1
Also, does that mean my taxes would pay for EVERYONE's healthcare? # name:npc1
What if they got injured for stupid reasons? # name:npc1
Shouldn't I get to decide if I pay for that? # name:npc1
I dunno. # name:npc1
It just seems so complicated. # name:npc1
-> END

=== they_pick ===
Me? # name:npc1
Huh. # name:npc1
I guess... getting the potholes fixed on Main Street would be nice. # name:npc1
I'm pretty sure one of them has an echo at this point! # name:npc1
-> END

=== ruler ===
Ha, that's pretty funny... # name:npc1
... oh, you're serious? # name:npc1
I don't know about that. # name:npc1
-> END
