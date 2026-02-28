extends Node

@export var story: InkStory

const CONTINUE = -1

func _ready() -> void:
    continue_story()
    
func continue_story() -> void:
    for child_node in get_children():
        child_node.queue_free()

    story.Continue()
    
    var label = Label.new()
    label.text = story.GetCurrentText()
    add_child(label)
    
    var choices = story.GetCurrentChoices()
    if len(choices) == 0:
        if story.GetCanContinue():
            _add_choice("continue")
    else:
        for choice in choices:
            _add_choice(choice.Text, choice.Index)

func _add_choice(text: String, id: int = CONTINUE) -> void:
    var button = Button.new()
    button.text = text
    button.pressed.connect(_on_choice_selected.bind(id))
    add_child(button)

func _on_choice_selected(index: int):
    if index != CONTINUE:
        story.ChooseChoiceIndex(index)
    continue_story()
