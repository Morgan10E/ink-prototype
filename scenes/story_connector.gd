extends Node

var last_ink_entrypoint: String = ""

func update_ink_entrypoint(new_entrypoint: String):
    last_ink_entrypoint = new_entrypoint

func trigger_story():
    if last_ink_entrypoint != "":
        EventBus.emit_signal("OpenInkStory", last_ink_entrypoint)
    else:
        print("no-op: no story active")
