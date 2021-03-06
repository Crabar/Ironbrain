/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {

import events.CommandEvent;

import models.PlaygroundModel;
import models.objects.Robot;

[Event(name="commandEnded", type="events.CommandEvent")]
public class MoveForwardBy1Command extends BaseCommand implements ICommand {
    public function MoveForwardBy1Command() {
    }

    override public function execute(curRobot:Robot, playgroundModel:PlaygroundModel, commandOrder:uint):void {
        super.execute(curRobot, playgroundModel, commandOrder);
        var targetPositionRowIndex:uint = curRobot.currentPosition.rowIndex;
        var targetPositionColumnIndex:uint = curRobot.currentPosition.colIndex;

        switch (curRobot.currentDirection) {
            case 0:
                targetPositionRowIndex--;
                break;
            case 90:
                targetPositionColumnIndex++;
                break;
            case 180:
                targetPositionRowIndex++;
                break;
            case 270:
                targetPositionColumnIndex--;
                break;
        }

        if (targetPositionRowIndex < 0 || targetPositionRowIndex >= playgroundModel.field.length) {
            trace("incorrect target row position");
            dispatchEventWith(CommandEvent.COMMAND_ENDED, false, _commandOrder);
            destroy();
            return;
        }

        if (targetPositionColumnIndex < 0 || targetPositionColumnIndex >= playgroundModel.field[targetPositionRowIndex].length) {
            trace("incorrect target column position");
            dispatchEventWith(CommandEvent.COMMAND_ENDED, false, _commandOrder);
            destroy();
            return;
        }

        curRobot.moveTo(playgroundModel.field[targetPositionRowIndex][targetPositionColumnIndex]);
    }


    override public function get title():String {
        return "Move forward on one cell";
    }

    override public function get textureName():String {
        return "move_forward_by_1_card";
    }
}
}
