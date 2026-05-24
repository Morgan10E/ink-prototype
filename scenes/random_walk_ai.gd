extends Node

signal move_direction(direction: Vector2i)

var directions: Array[Vector2i] = [
    Vector2i.UP,
    Vector2i.DOWN,
    Vector2i.LEFT,
    Vector2i.RIGHT,
]

func move_random_direction() -> void:
    var random_index = randi() % directions.size()
    var direction = directions[random_index]
    emit_signal("move_direction", direction)
