/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;

import views.objects.RobotViewObject;

public class TurnLeftCommand implements ICommand {
    public function TurnLeftCommand() {
    }

    public function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void {
        curRobot.rotate(-90);
    }

    public function get title():String {
        return "Turn left on 90 degrees";
    }

    public function get textureName():String {
        return "turn_left_card";
    }
}
}
