/**
 * Created by Crabar on 1/17/15.
 */
package models {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import models.commands.ICommand;

import models.playground.Cell;

import views.objects.RobotViewObject;

public class PlaygroundModel extends BaseModel {
    public function PlaygroundModel() {
        super();
    }

    public var field:Vector.<Vector.<Cell>>;
    public var mainRobot:RobotViewObject;
    public var deck:CommandsDeck;
    public var availableCommands:Vector.<ICommand>;
    public var activeCommands:Vector.<ICommand>;
}
}
