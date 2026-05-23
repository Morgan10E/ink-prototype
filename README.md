# Ink-prototype

There are two primary goals to this project:

1. Learn Godot! I have not made games in a while, and the last time I did I was working in Unity. I want to challenge myself here to try to "think in Godot."
2. Lay a foundation for a fun game! Some recent inspiration from things like [In Stars and Time](https://store.steampowered.com/app/1677310/In_Stars_And_Time/) and [Perfect Tides](https://store.steampowered.com/app/1172800/Perfect_Tides/) had me thinking about how I might make a top-down RPG-like game. So these are the building blocks.



https://github.com/user-attachments/assets/86ad01bc-8f75-418f-9e03-ec7762cb2eba



## Our story thus far

### High-level long-term goals:

- Story moments can be triggered by the player intentionally interacting with the world, crossing thresholds, time, or more that I haven't thought of yet. The story system needs to remain decoupled from any one trigger mechanism
- (Not implemented at all yet) Story moments might freeze time in the game world, or the game world might keep moving.
- State changes in the world and choices in the narrative system should be linked - each can affect the other.
- Some choices have to be made within a time window. This time window should be configurable by folks writing story elements, and should be adjustable via game settings (for instance, someone could slow down or turn off timed choices if it was too stressful)


### Where we are now


#### Conversations

We initially explored renpy as an option ([prototype here](https://github.com/Morgan10E/renpy_prototype)). We did quickly get a nice prototype for timed choices (plus configurability of time in settings) but there was no good solution to support integrating it with a top-down RPG-style experience, so it was ultimately a non-starter.

Ink seemed a reasonable next choice. For now we're powering timed choices with tags:

```
You can't put your finger on it, but something is up with this box... #timed_choice #time:5
+ [Open the box] You open the box.
~ opened_suspicious_box = true
Strange... there's nothing inside.
-> END
+ [Leave it, way too suspicious] You're right, that's the safer call.
-> END
+ [timeout_target] The unsettling feeling is too intense.
You'll just come back later...
-> END
```

And we have not yet implemented configurability via settings for players. We travel back and forth between top-down and "story" mode using label entrypoints.

```
(Some story trigger) -- EventBus.EmitSignal("OpenInkStory", "skull") --> EventBus --> StoryManager; opens the conversation view and loads the story at the path
```

So something like `EventBus.EmitSignal("OpenInkStory", "skull")` with `skull` as a label in Ink:

```
=== skull ===
Wh- why is there a skull here?
Best to leave it alone...
-> END
```

will open on the screen.

#### Top-down

Movement is grid-based, and right now the logic is best explored in the Player (we don't have NPCs yet).

1. The GridMover component, which uses an InteractRaycast. The raycast is used to determine if there is something blocking the player. It fires:
  a. facing_direction: connected to the AnimationMock
  b. moving: connected to the AnimationMock, StoryConnector unset ink entrypoint
  c. move_done: connected to the AnimationMock, StoryConnector update ink entrypoint
2. WASD controller, a super basic keyboard controller for the player. It fires off "direction pressed" events (connected to the GridMover) and "interact triggered" events (connected to the StoryConnector).
3. The StoryConnector keeps track of the most recent ink entrypoint, and if "interact triggered" comes its way it in turn sends "OpenInkStory" via the EventBus (singleton that is auto-attached to every scene - simplest way to get an event out of the Player scene). It shares the raycast with the GridMover - it uses it to read "ink_entrypoint" off the custom data on the TileMap.


The map is constructed using a TileMap, and we paint a non-interactive GroundLayer and an InteractiveLayer. The InteractiveLayer has collisions turned on, with physics and a custom ink_entrypoint painted on. The collisions are handled by the Player's GridMover.


### TODO

- [x] "Pause the world." Support freezing the game - the convos should pause the overworld, and the player opening a pause menu should pause convos and/or the overworld.
- [x] Configurable convo time. Apply a multiplier based on the user settings and in Ink we specify the "canonical time".
- [ ] NPC with:
  - [ ] Super basic random walk AI
  - [ ] An ink entrypoint to converse with the player
