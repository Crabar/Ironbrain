package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;

import mx.resources.ResourceManager;

import starling.core.Starling;

import starling.core.Starling;
import starling.events.Event;

import utils.ResourcesManager;

[SWF(frameRate="60")]
public class Main extends Sprite {
    private var _starling:Starling;

    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        Game.WIDTH = 320;
        Game.HEIGHT = 480;
        //
        var viewPort:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
        //
        _starling = new Starling(Game, stage, viewPort);
        _starling.stage.stageWidth = Game.WIDTH;
        _starling.stage.stageHeight = Game.HEIGHT;
        _starling.showStats = true;
        _starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
        _starling.start();

    }

    private function onRootCreated(event:Event):void {
        ResourcesManager.init(Starling(event.currentTarget).contentScaleFactor);
        ResourcesManager.loadTextures();
    }
}
}
