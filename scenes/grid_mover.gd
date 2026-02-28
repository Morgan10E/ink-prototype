extends Node2D

@export var move_object: Node2D
@export var speed = 0.25

# TODO: move this to some global constants file?
const TILE_SIZE = 40

var moving_direction: Vector2 = Vector2.ZERO

func move(direction: Vector2):
    if not is_moving() and direction.length() > 0:
        moving_direction = normalize_direction(direction)

        var new_position = move_object.global_position + (moving_direction * TILE_SIZE)
        
        var tween = create_tween()
        tween.tween_property(move_object, "position", new_position, speed).set_trans(Tween.TRANS_LINEAR)
        tween.tween_callback(func(): moving_direction = Vector2.ZERO)

func is_moving() -> bool:
    return moving_direction.length() > 0

# Set to a cardinal direction in priority order: NESW
func normalize_direction(direction: Vector2) -> Vector2:
    if direction.y > 0:
        return Vector2.UP
    if direction.x > 0:
        return Vector2.RIGHT
    if direction.y < 0:
        return Vector2.DOWN
    if direction.x < 0:
        return Vector2.LEFT
    return Vector2.ZERO
