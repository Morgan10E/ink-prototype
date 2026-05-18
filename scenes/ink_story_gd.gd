extends Node

@export var story: InkStory

@export var text_label: RichTextLabel
@export var choice_container: VBoxContainer
@export var timer: TimerBar

signal thread_ended(save_state: String)

const CONTINUE = -1

func _ready() -> void:
    continue_story()
    
func goto_story_entrypoint(entrypoint: String, state: String) -> void:
    print("Enter story:", entrypoint)
    if state != "":
        story.LoadState(state)
    story.ChoosePathString(entrypoint)
    continue_story()

func continue_story() -> void:
    timer.set_timer_visible(false)
    for child_node in choice_container.get_children():
        child_node.queue_free()

    if not story.GetCanContinue():
        _save_and_close()
    else:
        story.Continue()

        text_label.text = story.GetCurrentText()
        
        var timed_choice = story.GetCurrentTags().find("timed_choice") != -1
        if timed_choice:
            var time = story.FetchVariable("timed_seconds")
            timer.start_timer(time)
        
        var choices = story.GetCurrentChoices()
        if len(choices) == 0:
            _add_choice("continue")
        else:
            for choice in choices:
                if timed_choice and choice.Text == "timeout_target":
                    timer.connect_timer(_on_choice_selected.bind(choice.Index))
                else:
                    _add_choice(choice.Text, choice.Index)

func _add_choice(text: String, id: int = CONTINUE) -> void:
    var button = Button.new()
    button.text = text
    button.pressed.connect(_on_choice_selected.bind(id))
    choice_container.add_child(button)

func _on_choice_selected(index: int):
    if index != CONTINUE:
        story.ChooseChoiceIndex(index)
    continue_story()

func _save_and_close() -> void:
    var current_state = story.SaveState()
    emit_signal("thread_ended", current_state)
