package models {

import events.ApplicationEvent;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import flash.events.EventDispatcher;

import views.BaseView;
import views.PlaygroundView;
import views.StartMenuView;

[Event(name="viewChanged", type="events.ApplicationEvent")]
public class ApplicationModel extends EventDispatcher {
    public static const PLAYGROUND_VIEW:String = "playgroundView";
    public static const START_MENU_VIEW:String = "startMenuView";
    private const VIEW_MODELS:Object = {};

    public function ApplicationModel(screenNavigator:ScreenNavigator) {
        super();
        _screenNavigator = screenNavigator;
        initScreenNavigator();
        initModels();
    }
    private var _screenNavigator:ScreenNavigator;

    [Bindable(event="viewChanged")]
    public function get currentView():BaseView {
        return BaseView(_screenNavigator.activeScreen);
    }

    public function set currentViewId(value:String):void {
        if (_screenNavigator.activeScreenID == value) return;
        _screenNavigator.showScreen(value);
        dispatchEvent(new ApplicationEvent(ApplicationEvent.VIEW_CHANGED));
    }

    private function initScreenNavigator():void {
        _screenNavigator.addScreen(START_MENU_VIEW, new ScreenNavigatorItem(StartMenuView));
        _screenNavigator.addScreen(PLAYGROUND_VIEW, new ScreenNavigatorItem(PlaygroundView));
    }

    private function initModels():void {
        VIEW_MODELS[START_MENU_VIEW] = null;
        VIEW_MODELS[PLAYGROUND_VIEW] = new PlaygroundModel();
    }

    public function getModel(view:String):EventDispatcher {
        return VIEW_MODELS[view];
    }
}
}