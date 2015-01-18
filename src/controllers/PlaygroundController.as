/**
 * Created by Crabar on 1/17/15.
 */
package controllers {
import flash.utils.setTimeout;

import models.CommandsDeck;
import models.PlaygroundModel;
import models.commands.ICommand;
import models.commands.MoveForwardBy1;
import models.commands.TurnLeftCommand;
import models.commands.TurnRightCommand;
import models.playground.Cell;

import views.objects.RobotViewObject;

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
    }

    public function createRobot():void {
        _model.mainRobot = new RobotViewObject();
        _model.mainRobot.moveTo(_model.field[9][3]);
    }

    public function generateDeck():void {
        _model.deck = new CommandsDeck();

        for (var i:uint = 0; i < 60; i++) {
            var randomCommandIndex:uint = int(Math.random() * 3);
            switch (randomCommandIndex) {
                case 0:
                    _model.deck.addCommand(new MoveForwardBy1());
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

    public function generateAvailableCards():void {
        _model.availableCommands = new <ICommand>[];
        var oneCommand:ICommand;

        for (var i:int = 0; i < 8; i++) {
            oneCommand = _model.deck.getNextCommand();
            _model.availableCommands.push(oneCommand);
        }
    }

    public function clearActiveCommands():void {
        _model.activeCommands = new Vector.<ICommand>(4);
    }

    public function playRound():void {
        for (var i:int = 0; i < _model.activeCommands.length; i++) {
            var command:ICommand = _model.activeCommands[i];
            command.execute(_model.mainRobot, _model);
        }

        clearActiveCommands();
        generateAvailableCards();
    }

    public function addActiveCommand(order:uint, command:ICommand):void {
        _model.activeCommands[order] = command;
    }

    public function removeActiveCommand(order:uint):void {
        _model.activeCommands[order] = null;
    }

    public function addAvailableCommand(command:ICommand):void {
        _model.availableCommands.push(command);
    }
}
}
