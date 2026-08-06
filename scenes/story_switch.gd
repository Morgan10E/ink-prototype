extends Node2D

@export var switch_key: String
@export var default_case: Node

var cases: Array[StoryCase]

func _ready() -> void:
    for child in get_children():
        cases.append(child)
        child.set_visible(false)
    if default_case:
        default_case.set_visible(true)
    else:
        cases[0].set_visible(true)

    WorldState.connect("state_updated", _update)

    # for a future where we narrow down which
    # switches get triggered on state change by key
    add_to_group("story_switch")
    add_to_group(switch_key)

func _update(key: String, value: String) -> void:
    if key == switch_key:
        update(value)

func update(value: String) -> void:
    for child in get_children():
        child.set_visible(false)
    for case in cases:
        if case.key_value == value:
            case.set_visible(true)
