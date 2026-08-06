extends Node

# stored in pairs, e.g. [key1, value1, key2, value2]
var keyvalue_pairs: Array[String]

signal state_updated(key: String, value: String)

func _ready() -> void:
    # TODO: load a save file?
    
    EventBus.connect("WorldStateChanged", set_state_value)

func get_state() -> Dictionary[String, String]:
    var state_dict = {}
    for i in range(0, len(keyvalue_pairs), 2):
        var key = keyvalue_pairs[i]
        var value = keyvalue_pairs[i+1]
        state_dict[key] = value
    return state_dict

func get_state_value(key: String) -> String:
    for i in range(len(keyvalue_pairs), 0, -2):
        if keyvalue_pairs[i-2] == key:
            return keyvalue_pairs[i-1]
    return ""

func get_state_int(key: String) -> int:
    return int(get_state_value(key))

func set_state_value(key: String, value: String) -> void:
    keyvalue_pairs.append_array([key, value])
    # We could send to only the targets for this particular key...
    state_updated.emit(key, value)
