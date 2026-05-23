using Godot;
using System;
using GodotInk;

[GlobalClass]
public partial class InkStoryController : Control
{
    [Export]
    public InkStory story;
    
    [Export]
    public RichTextLabel textLabel;
    
    [Export]
    public VBoxContainer choiceContainer;
    
    [Export]
    public Node timer;
    
    [Signal]
    public delegate void ThreadEndedEventHandler(String currentSaveState);
    
    private const int CONTINUE = -1;
    private const string timeoutTarget = "timeout_target";
    private int timeoutStringLength = 15; // "timeout_target:<we want this>"
    
    public void GotoStoryEntrypoint(String entrypoint, String currentSaveState) {
        if (currentSaveState != "") {
            story.LoadState(currentSaveState);
        }
        story.ChoosePathString(entrypoint);
        _ContinueStory();
    }
    
    private void _ContinueStory() {
        timer.Call("set_timer_visible", false);
        foreach (Node childNode in choiceContainer.GetChildren()) {
            childNode.QueueFree();
        }

        if (!story.GetCanContinue()) {
            _Close();
        } else {
            story.Continue();

            ResetConvoDisplay();
        }
    }
    
    public void ResetConvoDisplay() {
        textLabel.Text = story.GetCurrentText();
        
        var (timedChoice, timeSeconds) = _GetTimer();
        if (Constants.Instance.TIMER_ENABLED) {
            if (timedChoice) {
                timer.Call("start_timer", timeSeconds);
            }
        }
            
        var choices = story.GetCurrentChoices();
        if (choices.Count == 0) {
            _AddChoice("continue");
        } else {
            foreach (InkChoice choice in choices) {
                if (timedChoice && choice.Text.StartsWith(timeoutTarget)) {
                    if (Constants.Instance.TIMER_ENABLED) {
                        var timeoutCallable = () => _OnChoiceSelected(choice.Index);
                        timer.Connect("timer_expired", Callable.From(timeoutCallable));
                    } else {
                        _AddChoice(choice.Text.Substring(timeoutStringLength), choice.Index);
                    }
                } else {
                    _AddChoice(choice.Text, choice.Index);
                }
            }
        }
    }
    
    private (bool, double) _GetTimer() {
        var tagList = story.GetCurrentTags();
        var timedChoice = tagList.IndexOf("timed_choice") != -1;
        if (!timedChoice) {
            return (false, 0);
        }
        foreach (string tag in tagList) {
            if (tag.StartsWith("time:")) {
                var timeParts = tag.Split(":");
                var timeString = timeParts[1];
                var timeSeconds = Convert.ToDouble(timeString);
                return (true, timeSeconds);
            }
        }
        return (true, Constants.Instance.DEFAULT_TIME_SECONDS);
    }
    
    private void _AddChoice(String text, int id = CONTINUE) {
        var button = new Button();
        button.Text = text;
        button.Pressed += () => _OnChoiceSelected(id);
        choiceContainer.AddChild(button);
    }

    private void _OnChoiceSelected(int index) {
        if (index != CONTINUE) {
            story.ChooseChoiceIndex(index);
        }
        _ContinueStory();
    }

    private void _Close() {
        var currentState = story.SaveState();
        EmitSignal(SignalName.ThreadEnded, currentState);
    }
}
