/**
 * Created by Crabar on 1/17/15.
 */
package models {

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
    public var mainRobot:Robot;
    public var deck:CommandsDeck;
    public var availableCommands:Vector.<ICommand>;
    public var activeCommands:Vector.<ICommand>;

    public function winGame(robot:Robot):void {
        dispatchEvent(new Event(WIN_GAME, false, robot));
    }
}
}
