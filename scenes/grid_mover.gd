extends Node2D

@export var move_object: Node2D
@export var speed = 0.25
@export var time_til_stopped: float = 1
@export var time_til_momentum: float = 1
@export var raycast: RayCast2D

var grid_position: Vector2 = Vector2.ZERO
var moving_direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN

var has_momentum: bool = false
var movement_attempted: bool = false
var slowdown_timer: float = 0
var speedup_timer: float = 0

signal move_done

func _process(delta: float) -> void:
    slowdown_timer += delta
    speedup_timer += delta
    if movement_attempted:
        slowdown_timer = 0
    elif slowdown_timer > time_til_stopped:
        has_momentum = false
    
    if not movement_attempted:
        speedup_timer = 0
    elif speedup_timer > time_til_momentum:
        has_momentum = true
    
    movement_attempted = false

func move(direction: Vector2):
    movement_attempted = true
    if not is_moving() and direction.length() > 0:
        var new_facing_direction = normalize_direction(direction)
        if facing_direction != new_facing_direction:
            # rotate in place if facing a new direction
            facing_direction = new_facing_direction
            update_direction()
        elif has_momentum:
            # if already facing this direction, move
            move_forward()

func move_forward() -> void:
    var colliding_with = raycast.get_collider()
    if colliding_with != null:
        return

    moving_direction = facing_direction
    grid_position = grid_position + moving_direction
    var new_position = get_coordinates_from_vector2(grid_position)

    var tween = create_tween()
    tween.tween_property(move_object, "position", new_position, speed).set_trans(Tween.TRANS_LINEAR)
    tween.tween_callback(finish_move)

func finish_move() -> void:
    moving_direction = Vector2.ZERO
    emit_signal("move_done")

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

func get_coordinates(x, y):
    return Vector2(x * Constants.TILE_SIZE - Constants.TILE_SIZE / 2, y * Constants.TILE_SIZE - Constants.TILE_SIZE / 2)
    
func get_coordinates_from_vector2(int_coords: Vector2):
    return get_coordinates(int_coords.x, int_coords.y)

func update_direction():
    raycast.target_position = facing_direction * Constants.TILE_SIZE
    raycast.force_raycast_update()
    emit_signal("move_done")
