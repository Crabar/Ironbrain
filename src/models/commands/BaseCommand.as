/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import events.AnimationEvent;
import events.CommandEvent;


import models.PlaygroundModel;

import starling.events.Event;
import starling.events.EventDispatcher;

import models.objects.Robot;

public class BaseCommand extends EventDispatcher implements ICommand {
    public function BaseCommand() {
        super();
    }

    public function execute(curRobot:Robot, playgroundModel:PlaygroundModel, commandOrder:uint):void {
        curRobot.addEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
        _curRobot = curRobot;
        _commandOrder = commandOrder;
    }

    protected var _commandOrder:uint;
    protected var _curRobot:Robot;

    private function onAnimationEnded(event:Event):void {
        _curRobot.removeEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
        dispatchEventWith(CommandEvent.COMMAND_ENDED, false, _commandOrder);
    }

    public function destroy():void {
        _curRobot.removeEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
    }

    public function get title():String {
        return "";
    }

    public function get textureName():String {
        return "";
    }
}
}
