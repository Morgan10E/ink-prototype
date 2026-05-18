using Godot;
using System;

public partial class Constants : Node
{
    public static Constants Instance;
    public int TILE_SIZE = 16;
    public double DEFAULT_TIME_SECONDS = 10;
    public string INK_STATE = "";
    
    public override void _Ready() {
        Instance = this;
    }
}
