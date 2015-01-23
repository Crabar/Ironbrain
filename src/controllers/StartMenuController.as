/**
 * Created by Crabar on 1/17/15.
 */
package controllers {
import models.ApplicationModel;

public class StartMenuController {
    public function StartMenuController() {

    }

    public function startNewGame():void {
        ApplicationController.instance.changeView(ApplicationModel.PLAYGROUND_VIEW);
    }
}
}
