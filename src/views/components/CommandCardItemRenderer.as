/**
 * Created by Crabar on 1/18/15.
 */
package views.components {
import feathers.controls.List;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.core.TokenList;
import feathers.dragDrop.DragData;
import feathers.dragDrop.DragDropManager;
import feathers.dragDrop.IDragSource;
import feathers.dragDrop.IDropTarget;
import feathers.events.DragDropEvent;
import feathers.skins.IStyleProvider;

import models.commands.ICommand;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.ResourcesManager;

public class CommandCardItemRenderer extends DefaultListItemRenderer implements IDragSource {
    public function CommandCardItemRenderer() {
        super();
        addEventListener(TouchEvent.TOUCH, onCommandCardTouch);
        addEventListener(DragDropEvent.DRAG_COMPLETE, onDragComplete);
    }

    override public function set data(value:Object):void {
        if (value) {
            super.data = value;
            addSkin(ResourcesManager.getTexture(ICommand(data).textureName));
        }
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
