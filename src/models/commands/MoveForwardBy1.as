/**
 * Created by Crabar on 1/18/15.
 */
package models.commands {
import models.PlaygroundModel;
import models.playground.Cell;

import views.objects.RobotViewObject;

public class MoveForwardBy1 implements ICommand {
    public function MoveForwardBy1() {
    }

    public function execute(curRobot:RobotViewObject, playgroundModel:PlaygroundModel):void {
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
            return;
        }

        if (targetPositionColumnIndex < 0 || targetPositionColumnIndex >= playgroundModel.field[targetPositionRowIndex].length) {
            trace("incorrect target column position");
            return;
        }

        curRobot.moveTo(playgroundModel.field[targetPositionRowIndex][targetPositionColumnIndex]);
    }

    public function get title():String {
        return "Move forward on one cell";
    }

    public function get textureName():String {
        return "move_forward_by_1_card";
    }
}
}
