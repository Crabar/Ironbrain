package views {
import flash.events.EventDispatcher;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class BaseView extends Sprite {
    protected var _background:Image;

    private var _model:EventDispatcher;

    public function get model():EventDispatcher {
        return _model;
    }

    public function set model(value:EventDispatcher):void {
        _model = value;
    }

    private var _data:Object;

    public function get data():Object {
        return _data;
    }

    public function set data(value:Object):void {
        _data = value;
    }

    public function BaseView() {
        super();
        width = Game.WIDTH;
        height = Game.HEIGHT;
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    protected function createChildren():void {
    }

    private function onAddedToStage(event:Event):void {
        createChildren();
    }
}
}