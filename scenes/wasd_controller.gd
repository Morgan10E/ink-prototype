extends Node

signal direction_pressed(direction: Vector2)
signal interact_triggered

func _process(delta: float) -> void:
    # TODO: controls should get further abstracted out
    # so we can handle controllers or keyboards or other
    # but for now we'll assume wasd keyboard
    var y = 0
    var x = 0
    if Input.is_action_pressed("ui_up"):
        y = 1
    elif Input.is_action_pressed("ui_down"):
        y = -1
    if Input.is_action_pressed("ui_right"):
        x = 1
    elif Input.is_action_pressed("ui_left"):
        x = -1
    
    var direction = Vector2(x, y)
    if direction.length() > 0:
        emit_signal("direction_pressed", direction)
    else:
        # actions the user can take while standing still
        if Input.is_action_just_pressed("ui_select"):
            emit_signal("interact_triggered")
