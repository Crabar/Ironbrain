/**
 * Created by Crabar on 1/17/15.
 */
package models {

import models.commands.ICommand;

import models.playground.Cell;

import models.objects.Robot;

public class PlaygroundModel extends BaseModel {
    public function PlaygroundModel() {
        super();
    }

    public var field:Vector.<Vector.<Cell>>;
    public var mainRobot:Robot;
    public var deck:CommandsDeck;
    public var availableCommands:Vector.<ICommand>;
    public var activeCommands:Vector.<ICommand>;
}
}
