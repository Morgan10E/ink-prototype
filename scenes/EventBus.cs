using Godot;
using System;

public partial class EventBus : Node
{
    public static EventBus Instance;

    [Signal]
    public delegate void OpenInkStoryEventHandler(string entrypoint);
    [Signal]
    public delegate void CloseStoryEventHandler();
    [Signal]
    public delegate void TogglePauseEventHandler();
    [Signal]
    public delegate void TimerEnabledChangedEventHandler();
    [Signal]
    public delegate void WorldStateChangedEventHandler(string keyname, string value);

    public override void _Ready() {
        Instance = this;
    }
}
