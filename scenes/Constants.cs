using Godot;
using System;

public partial class Constants : Node
{
    public static Constants Instance;
    public int TILE_SIZE = 16;
    
    public bool TIMER_ENABLED = true;
    public double STANDARD_TIME_SECONDS = 10;
    public double BASE_TIME_SECONDS = 10;
    public double[] TIME_OPTIONS = [5, 10, 20, 40];

    public string INK_STATE = "";
    
    public override void _Ready() {
        Instance = this;
    }
}
