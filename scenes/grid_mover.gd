extends Node2D

@export var move_object: Node2D
@export var speed = 0.25
@export var raycast: RayCast2D

var grid_position: Vector2 = Vector2.ZERO
var moving_direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN

signal facing_ink_entrypoint(entrypoint: String)

func move(direction: Vector2):
    if not is_moving() and direction.length() > 0:
        var new_facing_direction = normalize_direction(direction)
        if facing_direction != new_facing_direction:
            # rotate in place if facing a new direction
            facing_direction = new_facing_direction
            update_direction()
            emit_signal("facing_ink_entrypoint", get_ink_entrypoint())
        else:
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
    emit_signal("facing_ink_entrypoint", get_ink_entrypoint())

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

func get_ink_entrypoint():
    var colliding_with = raycast.get_collider()
    if colliding_with != null:
        if colliding_with is TileMapLayer:
            var raycast_target = raycast.to_global(raycast.target_position)
            var cell = colliding_with.local_to_map(raycast_target)
            var tile_data: TileData = colliding_with.get_cell_tile_data(cell)
            if tile_data:
                var value = tile_data.get_custom_data("ink_entrypoint")
                return value
    return ""
