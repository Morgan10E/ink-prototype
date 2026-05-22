extends Node

@export var raycast: RayCast2D

var last_ink_entrypoint: String = ""

func update_ink_entrypoint():
    print("update ink entrypoint!")
    last_ink_entrypoint = ""
    var colliding_with = raycast.get_collider()
    if colliding_with != null:
        if colliding_with is TileMapLayer:
            var raycast_target = raycast.to_global(raycast.target_position)
            var cell = colliding_with.local_to_map(raycast_target)
            var tile_data: TileData = colliding_with.get_cell_tile_data(cell)
            if tile_data:
                var value = tile_data.get_custom_data("ink_entrypoint")
                last_ink_entrypoint = value

func unset_ink_entrypoint():
    set_ink_entrypoint("")

func set_ink_entrypoint(new_entrypoint: String):
    last_ink_entrypoint = new_entrypoint

func trigger_story():
    if last_ink_entrypoint != "":
        EventBus.emit_signal("OpenInkStory", last_ink_entrypoint)
    else:
        print("no-op: no story active")
