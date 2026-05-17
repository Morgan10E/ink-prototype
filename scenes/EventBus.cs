using Godot;
using System;

public partial class EventBus : Node
{
    [Signal]
    public delegate void OpenInkStoryEventHandler(string entrypoint);

    public override void _Ready() {
        OpenInkStory += PrintInkStory;
    }
    
    private void PrintInkStory(string entrypoint) {
        GD.Print($"Open ink story now! {entrypoint}");
    }
}
