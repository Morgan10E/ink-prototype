using Godot;
using System;

public partial class EventBus : Node
{
    public static EventBus Instance;

    [Signal]
    public delegate void OpenInkStoryEventHandler(string entrypoint);

    public override void _Ready() {
        Instance = this;
    }
}
