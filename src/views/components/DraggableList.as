/**
 * Created by Crabar on 1/18/15.
 */
package views.components {
import feathers.controls.List;
import feathers.dragDrop.DragDropManager;
import feathers.dragDrop.IDropTarget;
import feathers.events.DragDropEvent;

import models.commands.ICommand;

public class DraggableList extends List implements IDropTarget {
    public function DraggableList() {
        super();
        addEventListener(DragDropEvent.DRAG_ENTER, onDragEnter);
        addEventListener(DragDropEvent.DRAG_DROP, onDragDrop);
    }

    private function onDragDrop(event:DragDropEvent):void {
        var commandCard:ICommand = event.dragData.getDataForFormat("removeCard") as ICommand;
        dataProvider.addItem(commandCard);
    }

    private function onDragEnter(event:DragDropEvent):void {
        if (event.dragData.hasDataForFormat("removeCard")) {
            DragDropManager.acceptDrag(this);
        }
    }
}
}
