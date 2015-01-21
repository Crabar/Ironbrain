/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import flash.events.IEventDispatcher;

import models.PlaygroundModel;

import starling.events.Event;

import models.objects.Robot;

public interface ICommand {
    function execute(curRobot:Robot, playgroundModel:PlaygroundModel, commandIndex:uint):void;
    function get title():String;
    function get textureName():String;
    function addEventListener(eventType:String, listener:Function):void;
}
}
