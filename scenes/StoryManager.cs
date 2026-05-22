using Godot;
using System;

public partial class StoryManager : CanvasLayer
{
    [Export]
    public InkStoryController convo { get; set; }
    
    private void PrintInkStory(string entrypoint) {
        GD.Print($"Open ink story now! {entrypoint}");
    }
    
    public void EnterInkStory(string entrypoint) {
        convo.GotoStoryEntrypoint(entrypoint, Constants.Instance.INK_STATE);
        convo.Show();
    }
    
    public void CloseStory(string saveState) {
        convo.Hide();
        Constants.Instance.INK_STATE = saveState;
        GD.Print(Constants.Instance.INK_STATE);
    }
}
