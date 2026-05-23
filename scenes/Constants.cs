using Godot;
using System;

public partial class Constants : Node
{
    public static Constants Instance;
    public int TILE_SIZE = 16;
    
    public bool TIMER_ENABLED = true;
    public double CURRENT_TIME_MULTIPLIER = 1.0;
    public double[] TIME_OPTIONS = [2.0, 1.0, 0.5, 0.25];
    public double DEFAULT_TIME_SECONDS = 10.0;

    public string INK_STATE = "";
    
    public override void _Ready() {
        Instance = this;
    }
}
