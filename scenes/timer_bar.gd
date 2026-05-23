extends ColorRect
class_name TimerBar

@export var timer_bar_fill: ColorRect
@export var timer_buffer = 0.5

var total_time: float
var remaining_time: float
var timer_running: bool = false

signal timer_expired

func _process(delta: float) -> void:
    if timer_running:
        if remaining_time + timer_buffer < 0:
            emit_signal("timer_expired")
            timer_running = false
        else:
            remaining_time -= delta * Constants.CURRENT_TIME_MULTIPLIER
    
    if visible:
        timer_bar_fill.scale.x = remaining_time / total_time

func set_timer_visible(to_visible: bool):
    if to_visible:
        show()
    else:
        timer_running = false
        hide()

func start_timer(seconds: float):
    total_time = seconds
    remaining_time = total_time
    timer_bar_fill.scale.x = 1.0
    set_timer_visible(true)
    timer_running = true
