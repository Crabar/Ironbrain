/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;

import views.objects.RobotViewObject;

public class TurnRightCommand implements ICommand {
    public function TurnRightCommand() {
    }

    public function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void {
        curRobot.rotate(90);
    }

    public function get title():String {
        return "Turn right on 90 degrees";
    }

    public function get textureName():String {
        return "turn_right_card";
    }
}
}
