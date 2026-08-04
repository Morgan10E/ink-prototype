extends CollisionShape2D

# realistically only the player should use momentum
@export var use_momentum: bool
@export var move_object: Node2D
@export var speed = 0.25
@export var raycast: RayCast2D

var moving_direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2i = Vector2.DOWN

signal face_direction(direction: Vector2i)
signal moving
signal move_done

func move(direction: Vector2):
    if direction.length() > 0:
        var new_facing_direction = normalize_direction(direction)
        if facing_direction != new_facing_direction:
            facing_direction = new_facing_direction
            update_direction()
        move_forward(direction)
    elif moving_direction.length() > 0:
        moving_direction = Vector2.ZERO
        emit_signal("move_done")

func move_forward(direction: Vector2) -> void:
    emit_signal("moving")
    moving_direction = direction
    move_object.move_and_collide(moving_direction)

func finish_move() -> void:
    moving_direction = Vector2.ZERO
    emit_signal("move_done")

func is_moving() -> bool:
    return moving_direction.length() > 0

# Only relevant for animation
# Set to a cardinal direction; if the new direction includes
# the current direction, keep that direction. Then try whichever
# direction has the most magnitude.
# Fallback to priority order in case of tie: NESW
func normalize_direction(direction: Vector2) -> Vector2i:
    if direction.y * facing_direction.y > 0 || direction.x * facing_direction.x > 0:
        return facing_direction

    if abs(direction.x) > abs(direction.y):
        return Vector2(direction.x / abs(direction.x), 0)
    if abs(direction.y) > abs(direction.x):
        return Vector2(0, direction.y / abs(direction.y))

    if direction.y > 0:
        return Vector2.UP
    if direction.x > 0:
        return Vector2.RIGHT
    if direction.y < 0:
        return Vector2.DOWN
    if direction.x < 0:
        return Vector2.LEFT
    return Vector2.ZERO

func update_direction():
    raycast.target_position = facing_direction * Constants.TILE_SIZE
    raycast.force_raycast_update()
    emit_signal("face_direction", facing_direction)
