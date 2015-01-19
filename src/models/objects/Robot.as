/**
 * Created by Crabar on 1/17/15.
 */
package models.objects {
import events.AnimationEvent;

import models.playground.Cell;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.events.EventDispatcher;

import views.objects.*;

[Event(name="animationEnded", type="events.AnimationEvent")]
public class Robot extends EventDispatcher {
    public function Robot() {
        super();
        _robotView = new RobotView();
    }

    private var _robotView:RobotView;

    public function get view():RobotView {
        return _robotView;
    }

    private var _currentPosition:Cell;

    public function get currentPosition():Cell {
        return _currentPosition;
    }

    public function get currentDirection():Number {
        var degrees:Number = (view.rotation / Math.PI) * 180;
        return degrees > 0 ? degrees % 360 : (360 + degrees) % 360;
    }

    public function moveTo(targetCell:Cell):void {
        var tween:Tween = new Tween(view, 1, Transitions.EASE_IN_OUT);
        tween.moveTo(targetCell.x + (targetCell.width) / 2, targetCell.y + (targetCell.height) / 2);
        tween.onComplete = function ():void {
            dispatchEventWith(AnimationEvent.ANIMATION_ENDED)
        };
        Starling.juggler.add(tween);
        _currentPosition = targetCell;
    }

    public function rotate(degrees:Number):void {
        var tween:Tween = new Tween(view, 1, Transitions.EASE_IN_OUT);
        tween.animate("rotation", (view.rotation + (degrees / 180) * Math.PI));
        tween.onComplete = function ():void {
            dispatchEventWith(AnimationEvent.ANIMATION_ENDED)
        };
        Starling.juggler.add(tween);
    }
}
}
