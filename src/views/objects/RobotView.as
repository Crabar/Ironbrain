/**
 * Created by Crabar on 1/19/15.
 */
package views.objects {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import starling.display.Image;
import starling.textures.Texture;

public class RobotView extends Image {
    public function RobotView() {
        super(getRobotTexture());
        alignPivot();
    }

    private static function getRobotTexture():Texture {
        var sprite:flash.display.Sprite = new flash.display.Sprite();
        sprite.graphics.lineStyle(1, 0x444444);
        sprite.graphics.beginFill(0x00ff00);
        sprite.graphics.lineTo(12, -12);
        sprite.graphics.lineTo(24, 0);
        sprite.graphics.lineTo(0, 0);
        sprite.graphics.endFill();
        var bounds:Rectangle = sprite.getBounds(sprite);
        var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0xffffff);
        bitmapData.draw(sprite, new Matrix(1, 0, 0, 1, -bounds.left, -bounds.top));
        var texture:Texture = Texture.fromBitmapData(bitmapData);
        return texture;
    }
}
}
