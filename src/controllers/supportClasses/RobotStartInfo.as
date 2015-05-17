/**
 * Created by Crabar on 1/31/15.
 */
package controllers.supportClasses {
import models.playground.Cell;

import views.objects.BaseRobotView;

public class RobotStartInfo {

    public var skin:BaseRobotView;
    public var startRowPosition:uint;
    public var startColumnPosition:uint;

    public function RobotStartInfo(skin:BaseRobotView, rowPosition:uint, columnPosition:uint) {
        this.skin = skin;
        this.startRowPosition = rowPosition;
        this.startColumnPosition = columnPosition;
    }
}
}
