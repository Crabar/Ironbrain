/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import events.AnimationEvent;
import events.CommandEvent;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import models.PlaygroundModel;

import starling.events.Event;

import views.objects.RobotViewObject;

public class BaseCommand extends EventDispatcher implements ICommand {
    public function BaseCommand() {
        super(null);
    }

    public function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void {
        curRobot.addEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
    }

    private function onAnimationEnded(event:Event):void {
        event.currentTarget.removeEventListener(AnimationEvent.ANIMATION_ENDED, onAnimationEnded);
        dispatchEvent(new CommandEvent(CommandEvent.COMMAND_ENDED));
    }

    public function get title():String {
        return "";
    }

    public function get textureName():String {
        return "";
    }
}
}
