extends Button

func _ready() -> void:
    button_down.connect(_close_pause)
    
func _close_pause():
    EventBus.emit_signal("TogglePause")
