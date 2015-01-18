/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;

import views.objects.RobotViewObject;

public interface ICommand {
    function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void;
    function get title():String;
    function get textureName():String;
}
}
