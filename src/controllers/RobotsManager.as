/**
 * Created by Crabar on 1/31/15.
 */
package controllers {
import controllers.supportClasses.RobotStartInfo;

import views.objects.BlueRobotView;

import views.objects.GreenRobotView;

public class RobotsManager {

    private static var _robotsInfos:Array = [new RobotStartInfo(new GreenRobotView(), 10, 3), new RobotStartInfo(new BlueRobotView(), 10, 6)];

    public static function getStartRobotInfo(robotIndex:uint):RobotStartInfo {
        return _robotsInfos[robotIndex];
    }
}
}
