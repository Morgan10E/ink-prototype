using Godot;
using System;

public partial class AnimationMock : ColorRect
{
    [Export]
    public Godot.Color[] directionColors;
    public Godot.Vector2I facingDirection;
    public int animationStep = 0;
    public bool moving = false;
    
    public void updateDirection(Godot.Vector2I newDirection) {
        facingDirection = newDirection;
        _UpdateAnimation();
    }
    
    public void MovingStart() {
        moving = true;
        _UpdateAnimation();
    }
    
    public void MovingStop() {
        moving = false;
        _UpdateAnimation();
    }
    
    private void _UpdateAnimation() {
        if (moving) {
            this.Color = new Godot.Color(0,0,0);
            return;
        }
        var colorIndex = 0;
        if (facingDirection[0] < 0) {
            colorIndex = 1;
        }
        if (facingDirection[0] > 0) {
            colorIndex = 2;
        }
        if (facingDirection[1] > 0) {
            colorIndex = 3;
        }
        this.Color = directionColors[colorIndex];
    }
}
