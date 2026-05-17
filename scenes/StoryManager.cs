using Godot;
using System;

public partial class StoryManager : CanvasLayer
{
    public override void _Ready() {
        EventBus.Instance.OpenInkStory += PrintInkStory;
    }
    
    
    private void PrintInkStory(string entrypoint) {
        GD.Print($"Open ink story now! {entrypoint}");
    }
}
