/**
 * Created by Crabar on 1/18/15.
 */
package views.components {
import feathers.controls.List;
import feathers.controls.renderers.IListItemRenderer;
import feathers.core.FeathersControl;
import feathers.dragDrop.DragData;
import feathers.dragDrop.DragDropManager;
import feathers.dragDrop.IDragSource;
import feathers.events.DragDropEvent;

import models.commands.ICommand;

import starling.display.Image;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.ResourcesManager;

public class CommandCardItemRenderer extends FeathersControl implements IListItemRenderer, IDragSource {
    public function CommandCardItemRenderer() {
        super();
        addEventListener(TouchEvent.TOUCH, onCommandCardTouch);
        addEventListener(DragDropEvent.DRAG_COMPLETE, onDragComplete);
    }

    protected var _isSelected:Boolean;

    public function get isSelected():Boolean {
        return this._isSelected;
    }

    public function set isSelected(value:Boolean):void {
        if (this._isSelected == value) {
            return;
        }
        this._isSelected = value;
        this.invalidate(INVALIDATION_FLAG_SELECTED);
        this.dispatchEventWith(Event.CHANGE);
    }

    protected var _data:Object;

    public function get data():Object {
        return this._data;
    }

    public function set data(value:Object):void {
        if (this._data == value) {
            return;
        }
        this._data = value;
        if (data)
            addSkin(ResourcesManager.getTexture(ICommand(data).textureName));
        this.invalidate(INVALIDATION_FLAG_DATA);
    }

    protected var _index:int = -1;

    public function get index():int {
        return this._index;
    }

    public function set index(value:int):void {
        if (this._index == value) {
            return;
        }
        this._index = value;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }

    protected var _owner:List;

    public function get owner():List {
        return this._owner;
    }

    public function set owner(value:List):void {
        if (this._owner == value) {
            return;
        }
        this._owner = value;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }

    private function addSkin(skinTexture:Texture):void {
        var skin:Image = new Image(skinTexture);
        skin.width = width;
        skin.height = height;
        addChild(skin);
    }

    private function onDragComplete(event:DragDropEvent):void {
        if (event.isDropped) {
            owner.dataProvider.removeItem(data);
        }
    }

    private function onCommandCardTouch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch) {
            var dragData:DragData = new DragData();
            var dragImage:Image = new Image(ResourcesManager.getTexture(ICommand(data).textureName));
            dragImage.width = width;
            dragImage.height = height;
            dragImage.alignPivot();
            dragData.setDataForFormat("addCard", data);
            DragDropManager.startDrag(this, touch, dragData, dragImage);
        }
    }
}
}
