using Godot;
using System;

public partial class EventBus : Node
{
    public static EventBus Instance;

    [Signal]
    public delegate void OpenInkStoryEventHandler(string entrypoint);
    [Signal]
    public delegate void CloseStoryEventHandler();

    public override void _Ready() {
        Instance = this;
    }
}
