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

    public function execute(curRobot:Robot, playgroundModel:PlaygroundModel):void {
        curRobot.addEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
    }

    private function onAnimationEnded(event:Event):void {
        event.currentTarget.removeEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
        dispatchEventWith(CommandEvent.COMMAND_ENDED);
    }

    public function get title():String {
        return "";
    }

    public function get textureName():String {
        return "";
    }
}
}
