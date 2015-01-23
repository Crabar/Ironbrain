/**
 * Created by Crabar on 1/23/15.
 */
package models.commands {
import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import models.PlaygroundModel;

import models.objects.Robot;
import models.playground.Cell;

import org.hamcrest.assertThat;

public class MoveForwardBy1Test {

    private var _moveForwardBy1Command:MoveForwardBy1Command;
    private var _model:PlaygroundModel;

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var robot1:Robot;

    [Mock]
    public var robot2:Robot;


    [Before]
    public function setUp():void {
        _moveForwardBy1Command = new MoveForwardBy1Command();
        _model = new PlaygroundModel();
    }

    private var _topLeftCell:Cell;
    private var _topRightCell:Cell;
    private var _bottomLeftCell:Cell;
    private var _bottomRightCell:Cell;

    private function prepareField():void {
        _model.field = new Vector.<Vector.<Cell>>();
        _bottomLeftCell = new Cell(0, 0, 50, 50, 1, 0);
        _bottomRightCell = new Cell(50, 0, 50, 50, 1, 1);
        _topLeftCell = new Cell(0, 50, 50, 50, 0, 0);
        _topRightCell = new Cell(50, 50, 50, 50, 0, 1);
        _model.field.push(Vector.<Cell>([_topLeftCell, _topRightCell]));
        _model.field.push(Vector.<Cell>([_bottomLeftCell, _bottomRightCell]));
    }

    [Test]
    public function testExecute():void {
        prepareField();
        stub(robot1).getter("currentPosition").returns(_topLeftCell);
        stub(robot1).getter("currentDirection").returns(180);
        _moveForwardBy1Command.execute(robot1, _model, 0);
        assertThat(robot1, received().method("moveTo").args(_bottomLeftCell));
        stub(robot2).getter("currentPosition").returns(_topLeftCell);
        stub(robot2).getter("currentDirection").returns(90);
        _moveForwardBy1Command.execute(robot2, _model, 0);
        assertThat(robot2, received().method("moveTo").args(_topRightCell));
    }
}
}
