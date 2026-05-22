extends ColorRect
class_name TimerBar

@export var timer_bar_fill: ColorRect
@export var timer: Timer
@export var timer_buffer = 0.5

var total_time

func connect_timer(_callback):
    var connections = timer.get_signal_connection_list("timeout")
    for connection in connections:
        if connection.has("target_method"):
            timer.disconnect("timeout", connection.target_method)
        if connection.has("callable"):
            timer.disconnect("timeout", connection.callable)
        #print("removing connection")
        #print(connection)
        #timer.disconnect("timeout", connection.target_method)
    timer.timeout.connect(_callback)

func set_timer_visible(visible: bool):
    if visible:
        show()
    else:
        timer.stop()
        hide()

func start_timer(seconds: float):
    total_time = seconds
    timer_bar_fill.scale.x = 1.0
    set_timer_visible(true)
    timer.start(seconds + timer_buffer)
    
func _process(_delta: float) -> void:
    if visible:
        timer_bar_fill.scale.x = (timer.time_left - timer_buffer) / total_time
