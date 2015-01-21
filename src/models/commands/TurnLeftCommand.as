/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;
import models.commands.BaseCommand;

import models.objects.Robot;

public class TurnLeftCommand extends BaseCommand implements ICommand {
    public function TurnLeftCommand() {
    }

    override public function execute(curRobot:Robot, playgroundModel:PlaygroundModel, commandOrder:uint):void {
        super.execute(curRobot, playgroundModel, commandOrder);
        curRobot.rotate(-90);
    }

    override public function get title():String {
        return "Turn left on 90 degrees";
    }

    override public function get textureName():String {
        return "turn_left_card";
    }
}
}
