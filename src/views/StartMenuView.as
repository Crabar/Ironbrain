/**
 * Created by Crabar on 1/17/15.
 */
package views {
import controllers.StartMenuController;

import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import flash.events.EventDispatcher;

import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;

public class StartMenuView extends BaseView {
    public function StartMenuView() {
        super();
    }

    private var _controller:StartMenuController;

    override protected function createChildren():void {
        createBackground();
        createButtons();
    }

    override public function set model(value:EventDispatcher):void {
        _controller = new StartMenuController();
    }

    private function createButtons():void {
        var menu:ButtonGroup = new ButtonGroup();
        menu.direction = ButtonGroup.DIRECTION_VERTICAL;
        menu.gap = 20;
        menu.dataProvider = prepareButtonsData();
        addChild(menu);
        menu.validate();
        menu.x = (width  - menu.width) / 2;
        menu.y = (height - menu.height) / 2;
    }

    private function prepareButtonsData():ListCollection {
        var buttons:ListCollection = new ListCollection();
        buttons.addItem({label: "New game", triggered: onNewGameButtonClick});
//        buttons.addItem({label: Main.localeManager.getString("start_menu", "loadGame"), triggered: onLoadGameButtonClick});
        return buttons;
    }

    private function onNewGameButtonClick(event:Event):void {
        _controller.startNewGame();
    }

    private function createBackground():void {
        _background = new Image(Texture.fromColor(1, 1, 0xf0f0f0ff));
        _background.width = Game.WIDTH;
        _background.height = Game.HEIGHT;
        addChild(_background);
    }


}
}
