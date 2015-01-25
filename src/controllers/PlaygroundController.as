/**
 * Created by Crabar on 1/17/15.
 */
package controllers {
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
    }

    private var _model:PlaygroundModel;

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

    public function createRobot():void {
        _model.mainRobot = new Robot();
        _model.mainRobot.moveTo(_model.field[10][3]);
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
        _model.activeCommands = new Vector.<ICommand>(4);
    }

    public function playRound():void {
        var isAllCommandsExists:Boolean = _model.activeCommands.every(function (element:ICommand, index:int, array:Vector.<ICommand>):Boolean {
            return element
        });
        if (isAllCommandsExists) {
            _model.dispatchEventWith(PlaygroundModel.PLAYING_STARTED);
            executeActiveCommandsRecursive(0);
        }
    }

    public function startNewRound():void {
        returnUnusedCommandsToDeck();
        clearActiveCommands();
        _model.deck.shuffle();
        generateAvailableCommands(8);
        _model.dispatchEventWith(ModelEvent.DATA_CHANGED);
    }

    public function addActiveCommand(order:uint, command:ICommand):void {
        if (!_model.activeCommands) {
            clearActiveCommands();
        }

        _model.activeCommands[order] = command;
    }

    public function removeActiveCommand(order:uint):void {
        if (!_model.activeCommands) {
            clearActiveCommands();
        }

        _model.activeCommands[order] = null;
    }

    public function addAvailableCommand(command:ICommand):void {
        if (!_model.availableCommands) {
            _model.availableCommands = new <ICommand>[];
        }
        _model.availableCommands.push(command);
    }

    public function preparePlayground():void {
        generateField(Game.WIDTH - 1, Game.WIDTH - 1, 11, 11);
        createRobot();
        generateDeck(60); // temporary
        startNewRound();
    }

    private function executeActiveCommandsRecursive(commandIndex:uint):void {
        if (commandIndex >= _model.activeCommands.length) {
            executeCellActions(_model.mainRobot, false);
            endRound();
            startNewRound();
            return;
        }

        var curCommand:ICommand = _model.activeCommands[commandIndex];
        curCommand.addEventListener(CommandEvent.COMMAND_ENDED, function (event:Event):void {
            trace(event.data);
            executeCellActions(_model.mainRobot, true);
            if (_model.activeCommands.length > 0)
                executeActiveCommandsRecursive(event.data + 1);
        });
        curCommand.execute(_model.mainRobot, _model, commandIndex);
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
}
}
