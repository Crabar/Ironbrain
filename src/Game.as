package {

import controllers.ApplicationController;

import feathers.controls.ScreenNavigator;
import feathers.themes.MinimalMobileTheme;

import models.ApplicationModel;

import starling.display.Sprite;
import starling.events.Event;

public class Game extends Sprite {
    public static var WIDTH:uint;
    public static var HEIGHT:uint;

    private static const START_VIEW:String = ApplicationModel.START_MENU_VIEW;

    public function Game() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        //
        _screenNavigator = new ScreenNavigator();
        _screenNavigator.autoSizeMode = ScreenNavigator.AUTO_SIZE_MODE_STAGE;
        _screenNavigator.clipContent = true;
        addChild(_screenNavigator);
        //
        _model = new ApplicationModel(_screenNavigator);
        ApplicationController.instance.init(_model);
        ApplicationController.instance.changeView(START_VIEW);
        //
    }

    private var _model:ApplicationModel;
    private var _screenNavigator:ScreenNavigator;


    private function onAddedToStage(event:Event):void {
        new MinimalMobileTheme(true);
    }
}
}