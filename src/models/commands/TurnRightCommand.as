/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;
import models.commands.BaseCommand;

import views.objects.RobotViewObject;

public class TurnRightCommand extends BaseCommand implements ICommand {
    public function TurnRightCommand() {
    }

    override public function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void {
        super.execute(curRobot, playgroundModel);
        curRobot.rotate(90);
    }

    override public function get title():String {
        return "Turn right on 90 degrees";
    }

    override public function get textureName():String {
        return "turn_right_card";
    }
}
}
