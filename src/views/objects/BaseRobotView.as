/**
 * Created by Crabar on 1/31/15.
 */
package views.objects {
import starling.display.Image;
import starling.textures.Texture;

public class BaseRobotView extends Image implements IRobotView {
    public function BaseRobotView() {
        super(getTexture());
        alignPivot();
    }

    public function getTexture():Texture {
        return null;
    }
}
}
