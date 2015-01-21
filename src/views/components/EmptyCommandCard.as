/**
 * Created by Crabar on 1/18/15.
 */
package views.components {
import controllers.PlaygroundController;

import events.ModelEvent;

import feathers.dragDrop.DragData;
import feathers.dragDrop.DragDropManager;
import feathers.dragDrop.IDragSource;
import feathers.dragDrop.IDropTarget;
import feathers.events.DragDropEvent;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import models.PlaygroundModel;
import models.commands.ICommand;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.ResourcesManager;

public class EmptyCommandCard extends Sprite implements IDragSource, IDropTarget {
    public function EmptyCommandCard(controller:PlaygroundController, model:PlaygroundModel) {
        super();
        _controller = controller;
        _model = model;
        _model.addEventListener(ModelEvent.DATA_CHANGED, onDataChanged);
        addEventListener(DragDropEvent.DRAG_ENTER, onDragEnter);
        addEventListener(DragDropEvent.DRAG_DROP, onDragDrop);
        addEventListener(DragDropEvent.DRAG_COMPLETE, onDragComplete);
        addEventListener(TouchEvent.TOUCH, onTouch);
        redrawCard();
        addTextField();
    }

    private var _controller:PlaygroundController;
    private var _model:PlaygroundModel;
    private var _textField:TextField;
    private var _image:Image;
    private var _order:uint;

    public function get order():uint {
        return _order;
    }

    public function get activeCommand():ICommand {
        return _model.activeCommands[_order];
    }

    public function setOrder(orderIndex:uint):void {
        _order = orderIndex;
        _textField.text = (orderIndex + 1).toString();
    }

    private function addTextField():void {
        _textField = new TextField(width, 40, "", "Verdana", 24, 0, true);
        addChild(_textField);
    }

    private function redrawCard():void {
        var texture:Texture;
        if (!activeCommand) {
            if (_textField)
                _textField.visible = true;
            //
            var card:flash.display.Sprite = new flash.display.Sprite();
            card.graphics.lineStyle(2, 0x3333ff);
            card.graphics.drawRoundRect(0, 0, 60, 60, 10, 10);
            var bounds:Rectangle = card.getBounds(card);
            var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0xffffff);
            bitmapData.draw(card, new Matrix(1, 0, 0, 1, -bounds.left, -bounds.top));
            texture = Texture.fromBitmapData(bitmapData);
        } else {
            texture = ResourcesManager.getTexture(activeCommand.textureName);
            if (_textField)
                _textField.visible = false;
        }

        if (!_image) {
            _image = new Image(texture);
            addChildAt(_image, 0);
        } else {
            _image.texture = texture;
        }
    }

    private function onDataChanged(event:ModelEvent):void {
        redrawCard();
    }

    private function onDragComplete(event:DragDropEvent):void {
        if (event.isDropped) {
            if (!event.dragData.getDataForFormat("removeCard").hasOwnProperty("noNeedToClearSource")) {
                _controller.removeActiveCommand(_order);
            }

            redrawCard();
        }
    }

    private function onDragDrop(event:DragDropEvent):void {
        if (event.dragData.hasDataForFormat("addCard")) {
            if (activeCommand) {
                _controller.addAvailableCommand(activeCommand);
            }

            _controller.addActiveCommand(_order, event.dragData.getDataForFormat("addCard") as ICommand);
        } else if (event.dragData.hasDataForFormat("removeCard")) {
            var sourceCard:EmptyCommandCard = EmptyCommandCard(event.dragData.getDataForFormat("removeCard").source);
            var newCard:ICommand = event.dragData.getDataForFormat("removeCard").data;

            if (activeCommand) {
                _controller.addActiveCommand(sourceCard.order, activeCommand);
                event.dragData.setDataForFormat("removeCard", {noNeedToClearSource: true});
            }

            _controller.addActiveCommand(order, newCard);

        }

        redrawCard();
    }

    private function onDragEnter(event:DragDropEvent):void {
        if (event.dragData.hasDataForFormat("addCard") ||
                (event.dragData.hasDataForFormat("removeCard") && event.dragData.getDataForFormat("removeCard").source != this)) {
            DragDropManager.acceptDrag(this);
        }
    }

    private function onTouch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);

        if (touch && !DragDropManager.isDragging && activeCommand) {
            var dragData:DragData = new DragData();
            dragData.setDataForFormat("removeCard", {source: this, data: _model.activeCommands[_order]});
            var dragImage:Image = new Image(ResourcesManager.getTexture(activeCommand.textureName));
            dragImage.width = 40;
            dragImage.height = 40;
            dragImage.alignPivot();
            DragDropManager.startDrag(this, touch, dragData, dragImage);
        }
    }
}
}
