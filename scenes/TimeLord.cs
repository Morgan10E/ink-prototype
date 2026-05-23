using Godot;
using System;

public partial class TimeLord : Node
{
    [Export]
    public CanvasLayer pauseMenu;
    
    [Export]
    public StoryManager storyManager;
    
    [Export]
    public Node worldManager;
    
    private bool isPaused;
    private enum GameState {
        WORLD,
        CONVO,
    }
    
    private GameState activeGameState;
    
    public override void _Ready() {
        isPaused = false;
        activeGameState = GameState.WORLD;
        EventBus.Instance.OpenInkStory += PlayStory;
        EventBus.Instance.CloseStory += CloseStory;
    }
    
    private void PlayStory(string entrypoint) {
        // The world is paused when a story is active
        GetTree().Paused = true;
        storyManager.EnterInkStory(entrypoint);
        activeGameState = GameState.CONVO;
    }
    
    private void CloseStory() {
        GetTree().Paused = false;
        activeGameState = GameState.WORLD;
    }
    
    public override void _Input(InputEvent @event) {
        if (@event.IsActionPressed("ui_cancel")) {
            TogglePause();
        }
    }
    
    private void TogglePause() {
        if (isPaused) {
            ResumeGame();
        } else {
            PauseEntireGame();
        }
    }
    
    private void PauseEntireGame() {
        GD.Print("Pause game");
        isPaused = true;
    
        // Pause menu takes over
        pauseMenu.ProcessMode = Node.ProcessModeEnum.WhenPaused;
        pauseMenu.Show();

        // Everything goes to sleep
        storyManager.ProcessMode = Node.ProcessModeEnum.Pausable;
        GetTree().Paused = true;
    }
    
    private void ResumeGame() {
        GD.Print("Resume");
        isPaused = false;
    
        // Shut down the pause menu
        pauseMenu.ProcessMode = Node.ProcessModeEnum.Disabled;
        pauseMenu.Hide();
    
        // Story manager is back in business
        storyManager.ProcessMode = Node.ProcessModeEnum.WhenPaused;
        
        // Only resume the world if we weren't paused mid-convo
        if (activeGameState == GameState.WORLD) {
            GetTree().Paused = false;
        }
    }
}
