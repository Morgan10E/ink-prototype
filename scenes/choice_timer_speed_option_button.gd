extends OptionButton

var timer_off_option_index: int

func _ready() -> void:
    timer_off_option_index = item_count - 1

func _on_item_selected(index: int) -> void:
    var enabled_changed = false
    if index == timer_off_option_index:
        enabled_changed = Constants.TIMER_ENABLED != false
        Constants.TIMER_ENABLED = false
    else:
        enabled_changed = Constants.TIMER_ENABLED != true
        Constants.TIMER_ENABLED = true
        Constants.CURRENT_TIME_MULTIPLIER = Constants.TIME_OPTIONS[index]
    if enabled_changed:
        EventBus.emit_signal("TimerEnabledChanged")
