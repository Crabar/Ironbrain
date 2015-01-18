/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import flash.events.IEventDispatcher;

import models.PlaygroundModel;

import views.objects.RobotViewObject;

public interface ICommand extends IEventDispatcher{
    function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void;
    function get title():String;
    function get textureName():String;
}
}
