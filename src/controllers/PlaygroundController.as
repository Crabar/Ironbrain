/**
 * Created by Crabar on 1/17/15.
 */
package controllers {
import com.reyco1.multiuser.data.UserObject;

import events.CommandEvent;
import events.ModelEvent;

import models.CommandsDeck;
import models.PlaygroundModel;
import models.commands.ICommand;
import models.commands.MoveForwardBy1Command;
import models.commands.TurnLeftCommand;
import models.commands.TurnRightCommand;
import models.objects.Robot;
import models.playground.Cell;
import models.playground.CellObject;
import models.playground.cellobjects.ExitCO;

import starling.events.Event;

public class PlaygroundController {
    public function PlaygroundController(model:PlaygroundModel) {
        _model = model;
        _multiplayerController = new MultiplayerController(_model);
        _multiplayerController.addEventListener(MultiplayerController.USER_CONNECTED, onUserConnected);
        _multiplayerController.addEventListener(MultiplayerController.DATA_RECEIVED, onDataReceived);
        _multiplayerController.addEventListener(MultiplayerController.ALL_PLAYERS_CONNECTED, onAllPlayersConnected);
    }

    private var _curUser:UserObject;

    private function onUserConnected(event:Event):void {
        _curUser = event.data as UserObject;
    }

    private function onAllPlayersConnected(event:Event):void {
        var users:Array = event.data as Array;

        for (var i:int = 0; i < users.length; i++) {
            var object:UserObject = users[i] as UserObject;
            _model.createRobot(i);
            _model.createCommandsContainer(i);
            if (_curUser.id == object.id)
                _model.currentUserId = i;
        }
    }

    private var _model:PlaygroundModel;
    private var _multiplayerController:MultiplayerController;

    public function generateField(width:Number, height:Number, rowCount:uint, colCount:uint):void {
        _model.field = new Vector.<Vector.<Cell>>();
        var cellWidth:Number = width / colCount;
        var cellHeight:Number = height / rowCount;

        for (var i:int = 0; i < rowCount; i++) {
            _model.field.push(new Vector.<Cell>());
            for (var j:int = 0; j < colCount; j++) {
                _model.field[i].push(new Cell(cellWidth * j, cellHeight * i, cellWidth, cellHeight, i, j));
            }
        }

        _model.field[5][5].addChild(new ExitCO());
    }

    public function generateDeck(count:uint):void {
        _model.deck = new CommandsDeck();

        for (var i:uint = 0; i < count; i++) {
            var randomCommandIndex:uint = int(Math.random() * 3);
            switch (randomCommandIndex) {
                case 0:
                    _model.deck.addCommand(new MoveForwardBy1Command());
                    break;
                case 1:
                    _model.deck.addCommand(new TurnLeftCommand());
                    break;
                case 2:
                    _model.deck.addCommand(new TurnRightCommand());
                    break;
            }
        }

        _model.deck.shuffle();
    }

    public function generateAvailableCommands(count:uint):void {
        _model.availableCommands = new <ICommand>[];
        var oneCommand:ICommand;

        for (var i:int = 0; i < count; i++) {
            oneCommand = _model.deck.getNextCommand();
            _model.availableCommands.push(oneCommand);
        }
    }

    public function clearActiveCommands():void {
        if (!_model.allActiveCommands) {
            _model.allActiveCommands = [];
            return;
        }

        for (var i:int = 0; i < _model.allActiveCommands.length; i++) {
            _model.createCommandsContainer(i);
        }
    }

    public function finishRound():void {
        var isCommandsExists:Boolean = _model.activeCommands.every(function (element:ICommand, index:int, array:Vector.<ICommand>):Boolean {
            return element
        });

        if (isCommandsExists) {
            _multiplayerController.sendActiveCommands(_model.activeCommands);
            _model.isPlayerFinishRound = true;
        }

        tryPlayRound();
    }

    private function isAllPlayersReady():Boolean {
        var isAllCommandsExists:Boolean = _model.allActiveCommands.every(function (element:Vector.<ICommand>, index:int, array:Array):Boolean {
            return element.every(function (element:ICommand, index:int, array:Vector.<ICommand>):Boolean {
                return element
            })
        });

        return isAllCommandsExists && _model.isPlayerFinishRound;
    }

    public function playRound():void {
        _model.dispatchEventWith(PlaygroundModel.PLAYING_STARTED);
        for (var i:int = 0; i < _model.allRobots.length; i++) {
            executeActiveCommandsRecursive(0, i);
        }
    }

    public function startNewRound():void {
        _model.isPlayerFinishRound = false;
        returnUnusedCommandsToDeck();
        clearActiveCommands();
        _model.deck.shuffle();
        generateAvailableCommands(8);
        _model.dispatchEventWith(ModelEvent.DATA_CHANGED);
    }

    public function addActiveCommand(order:uint, command:ICommand):void {
        _model.addActiveCommand(order, command, _model.currentUserId);
    }

    public function removeActiveCommand(order:uint):void {
        _model.removeActiveCommand(order, _model.currentUserId);
    }

    public function addAvailableCommand(command:ICommand):void {
        if (!_model.availableCommands) {
            _model.availableCommands = new <ICommand>[];
        }
        _model.availableCommands.push(command);
    }

    public function preparePlayground():void {
        generateField(Game.WIDTH - 1, Game.WIDTH - 1, 11, 11);
        initRobots();
        generateDeck(60); // temporary
        startNewRound();
        _multiplayerController.closeSession();
        _multiplayerController.connect(2);
    }

    private function tryPlayRound():void {
        if (isAllPlayersReady())
            playRound();
    }

    private function initRobots():void {
        _model.allRobots = new <Robot>[];
        _model.allActiveCommands = [];
    }

    private function executeActiveCommandsRecursive(commandIndex:uint, userId:uint):void {
        if (commandIndex >= _model.allActiveCommands[userId].length) {
            executeCellActions(_model.allRobots[userId], false);
            endRound();
            startNewRound();
            return;
        }

        var curCommand:ICommand = _model.allActiveCommands[userId][commandIndex];
        curCommand.addEventListener(CommandEvent.COMMAND_ENDED, function (event:Event):void {
            executeCellActions(_model.allRobots[userId], true);
            if (_model.activeCommands.length > 0)
                executeActiveCommandsRecursive(event.data + 1, userId);
        });
        curCommand.execute(_model.allRobots[userId], _model, commandIndex);
    }

    private function endRound():void {
        _model.dispatchEventWith(PlaygroundModel.PLAYING_ENDED);
    }

    private function executeCellActions(robot:Robot, immediate:Boolean):void {
        var curCell:Cell = robot.currentPosition;

        for (var i:int = 0; i < curCell.children.length; i++) {
            var cellObject:CellObject = curCell.children[i];
            if (immediate)
                cellObject.executeImmediate(robot, _model);
            else
                cellObject.execute(robot, _model);
        }
    }

    private function returnUnusedCommandsToDeck():void {
        if (_model.availableCommands) {
            for (var i:int = 0; i < _model.availableCommands.length; i++) {
                var command:ICommand = _model.availableCommands[i];
                _model.deck.addCommand(command);
            }
        }
    }

    private function onDataReceived(event:Event):void {
        tryPlayRound();
    }
}
}
