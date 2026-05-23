extends ColorRect
class_name TimerBar

@export var timer_bar_fill: ColorRect
@export var timer_buffer = 0.5

var total_time: float
var remaining_time: float
var timer_running: bool

signal timer_expired

func _process(delta: float) -> void:
    if timer_running:
        if remaining_time + timer_buffer < 0:
            emit_signal("timer_expired")
            timer_running = false
        else:
            var step_multiplier = _get_step_multiplier()
            remaining_time -= delta * step_multiplier
    
    if visible:
        timer_bar_fill.scale.x = remaining_time / total_time

func set_timer_visible(visible: bool):
    if visible:
        show()
    else:
        timer_running = false
        hide()

func start_timer(seconds: float):
    total_time = seconds * Constants.BASE_TIME_SECONDS
    remaining_time = total_time
    timer_bar_fill.scale.x = 1.0
    set_timer_visible(true)
    timer_running = true

func _get_step_multiplier() -> float:
    var standard_time = Constants.STANDARD_TIME_SECONDS
    var current_base_time = Constants.BASE_TIME_SECONDS
    return standard_time / current_base_time
