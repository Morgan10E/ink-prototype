extends OptionButton

var timer_off_option_index: int

func _ready() -> void:
    timer_off_option_index = item_count - 1

func _on_item_selected(index: int) -> void:
    if index == timer_off_option_index:
        Constants.TIMER_ENABLED = false
    else:
        Constants.TIMER_ENABLED = true
        Constants.BASE_TIME_SECONDS = Constants.SPEED_OPTIONS[index]
