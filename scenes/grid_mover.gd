extends Node2D

@export var TILE_SIZE = 16

@export var move_object: Node2D
@export var speed = 0.25
@export var raycast: RayCast2D

var grid_position: Vector2 = Vector2.ZERO
var moving_direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN

func move(direction: Vector2):
    if not is_moving() and direction.length() > 0:
        facing_direction = normalize_direction(direction)
        
        var colliding_with = movement_blocked()
        if colliding_with != null:
            print(colliding_with)
            return
        
        moving_direction = facing_direction
        grid_position = grid_position + moving_direction
        var new_position = get_coordinates_from_vector2(grid_position)
        
        var tween = create_tween()
        tween.tween_property(move_object, "position", new_position, speed).set_trans(Tween.TRANS_LINEAR)
        tween.tween_callback(func(): moving_direction = Vector2.ZERO)

func movement_blocked():
    raycast.target_position = facing_direction * TILE_SIZE
    raycast.force_raycast_update()
    return raycast.get_collider()

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
    return Vector2(x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE - TILE_SIZE / 2)
    
func get_coordinates_from_vector2(int_coords: Vector2):
    return get_coordinates(int_coords.x, int_coords.y)
