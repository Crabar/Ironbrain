/**
 * Created by Crabar on 1/17/15.
 */
package views {
import controllers.PlaygroundController;

import events.ModelEvent;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.Scroller;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.text.BitmapFontTextFormat;

import flash.display.BitmapData;


import flash.events.EventDispatcher;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import models.PlaygroundModel;
import models.playground.Cell;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import views.components.CommandCardItemRenderer;
import views.components.DraggableList;

import views.components.EmptyCommandCard;

import views.objects.RobotViewObject;

public class PlaygroundView extends BaseView {
    public function PlaygroundView() {
        super();
    }

    private var _controller:PlaygroundController;
    private var _fieldLayer:Sprite;
    private var _robotsLayer:Sprite;
    private var _availableCardsList:List;

    override public function set model(value:EventDispatcher):void {
        super.model = value;
        curModel.addEventListener(ModelEvent.DATA_CHANGED, onDataChanged);
        _controller = new PlaygroundController(curModel);
        drawField();
        initPlayer();
        drawAvailableCards();
        createActiveCardsList();
    }

    private function onDataChanged(event:ModelEvent):void {
        if (_availableCardsList) {
            drawAvailableCards();
        }
    }

    private function drawAvailableCards():void {
        _availableCardsList.dataProvider = new ListCollection(curModel.availableCommands);
    }

    private function initPlayer():void {
        _controller.createRobot();
        _robotsLayer.addChild(curModel.mainRobot);
        _controller.generateDeck();
        _controller.generateAvailableCards();
    }

    override protected function createChildren():void {
        drawBackground();
        createFieldLayer();
        createRobotsLayer();
        createAvailableCardsList();
        createPlayButton();
    }

    private function createPlayButton():void {
        var button:Button = new Button();
        button.height = 20;
        button.width = 100;
        button.horizontalAlign = "center";
        button.y = Game.HEIGHT - 20;
        button.addEventListener(Event.TRIGGERED, onButtonClick);
        addChild(button);
    }

    private function onButtonClick(event:Event):void {
        _controller.playRound();
    }

    private function createAvailableCardsList():void {
        _availableCardsList = new DraggableList();
        var layout:HorizontalLayout = new HorizontalLayout();
        _availableCardsList.layout = layout;
        _availableCardsList.interactionMode = Scroller.INTERACTION_MODE_TOUCH;
        _availableCardsList.isSelectable = false;
        _availableCardsList.itemRendererFactory = function():IListItemRenderer {
            var renderer:CommandCardItemRenderer = new CommandCardItemRenderer();
            renderer.width = 40;
            renderer.height = 40;
            renderer.labelFunction = function(data:Object):String { return ""; };
            return renderer;
        };

        _availableCardsList.y = 410;
        _availableCardsList.width = Game.WIDTH;
        addChild(_availableCardsList);
    }

    private function createActiveCardsList():void {
        _controller.clearActiveCommands();
        for (var i:int = 0; i < 4; i++) {
            var newEmptyCard:EmptyCommandCard = new EmptyCommandCard(_controller, curModel);
            newEmptyCard.setOrder(i);
            newEmptyCard.x = 10 + 10 * (i + 1) + i * newEmptyCard.width;
            newEmptyCard.y = Game.WIDTH + 10;
            addChild(newEmptyCard);
        }
    }

    private function createFieldLayer():void {
        _fieldLayer = new Sprite();
        _fieldLayer.name = "fieldLayer";
        addChild(_fieldLayer);
    }

    private function createRobotsLayer():void {
        _robotsLayer = new Sprite();
        _robotsLayer.name = "robotsLayer";
        addChild(_robotsLayer);
    }

    private function drawCells():void {
        var field:flash.display.Sprite = new flash.display.Sprite();
        field.graphics.lineStyle(1, 0x000000);

        for each (var columns:Vector.<Cell> in PlaygroundModel(model).field) {
            for each (var cell:Cell in columns) {
                field.graphics.drawRect(cell.x, cell.y, cell.width, cell.height);
            }
        }
        var bounds:Rectangle = field.getBounds(field);
        var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0xffffff);
        bitmapData.draw(field, new Matrix(1, 0, 0, 1, -bounds.left, -bounds.top));
        var texture:Texture = Texture.fromBitmapData(bitmapData);
        var image:Image = new Image(texture);
        image.touchable = false;
        _fieldLayer.addChild(image);
    }

    private function drawField():void {
        _controller.generateField(Game.WIDTH - 1, Game.WIDTH - 1, 10, 10);
        drawCells();
    }

    private function drawBackground():void {
        _background = new Image(Texture.fromColor(1, 1, 0xfffdfdff));
        _background.width = Game.WIDTH;
        _background.height = Game.HEIGHT;
        addChild(_background);
    }

    private function get curModel():PlaygroundModel {
        return model as PlaygroundModel;
    }
}
}
