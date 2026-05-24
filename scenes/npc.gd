extends CharacterBody2D
class_name CollisionStoryEntrypoint

@export var ink_entrypoint: String
var entrypoint_hidden: bool = false

func hide_entrypoint() -> void:
    entrypoint_hidden = true
    
func reveal_entrypoint() -> void:
    entrypoint_hidden = false
    
func get_entrypoint() -> String:
    if entrypoint_hidden:
        return ""
    return ink_entrypoint
