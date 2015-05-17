/**
 * Created by Crabar on 1/17/15.
 */
package models {

import controllers.MultiplayerController;
import controllers.RobotsManager;
import controllers.supportClasses.RobotStartInfo;

import events.ModelEvent;

import models.commands.ICommand;

import models.playground.Cell;

import models.objects.Robot;

import starling.events.Event;


public class PlaygroundModel extends BaseModel {
    public function PlaygroundModel() {
        super();
    }

    public static const WIN_GAME:String = "winGame";
    public static const PLAYING_STARTED:String = "playingStarted";
    public static const PLAYING_ENDED:String = "platingEnded";

    public var field:Vector.<Vector.<Cell>>;
    public var allRobots:Vector.<Robot>;
    public var allActiveCommands:Array;
    public var deck:CommandsDeck;
    public var availableCommands:Vector.<ICommand>;
    private var _currentUserId:uint = 0;
    public var isPlayerFinishRound:Boolean = false;

    public function get mainRobot():Robot {
        return allRobots[_currentUserId];
    }

    public function get activeCommands():Vector.<ICommand> {
        return allActiveCommands[_currentUserId];
    }

    public function winGame(robot:Robot):void {
        dispatchEvent(new Event(WIN_GAME, false, robot));
    }

    public function createCommandsContainer(userId:uint):void {
        allActiveCommands[userId] = new Vector.<ICommand>(4);
    }

    public function createRobot(robotIndex:uint):void {
        var robotInfo:RobotStartInfo = RobotsManager.getStartRobotInfo(robotIndex);
        var robot:Robot = new Robot(robotInfo.skin);
        allRobots.push(robot);
        robot.moveTo(field[robotInfo.startRowPosition][robotInfo.startColumnPosition]);
        dispatchEventWith(ModelEvent.DATA_CHANGED);
    }

    public function addActiveCommand(order:uint, command:ICommand, userId:uint):void {
        if (!allActiveCommands[userId]) {
            allActiveCommands[userId] = new <ICommand>[]();
        }

        allActiveCommands[userId][order] = command;
    }

    public function removeActiveCommand(order:uint, userId:uint):void {
        if (!allActiveCommands[userId]) {
            allActiveCommands[userId] = new <ICommand>[]();
        }

        allActiveCommands[userId][order] = null;
    }

    public function get currentUserId():uint {
        return _currentUserId;
    }

    public function set currentUserId(value:uint):void {
        _currentUserId = value;
        dispatchEventWith(MultiplayerController.USER_CONNECTED);
    }
}
}
