/**
 * Created by Crabar on 1/21/15.
 */
package models.playground.cellobjects {
import models.PlaygroundModel;
import models.objects.Robot;
import models.playground.CellObject;

public class ExitCO extends CellObject {
    public function ExitCO() {
        super();
    }

    override public function executeImmediate(robot:Robot, playground:PlaygroundModel):void {
        playground.winGame(robot);
    }
}
}
