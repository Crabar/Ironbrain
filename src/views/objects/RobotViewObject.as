/**
 * Created by Crabar on 1/17/15.
 */
package views.objects {

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import models.playground.Cell;

import starling.display.Image;
import starling.textures.Texture;

public class RobotViewObject extends Image {
    public function RobotViewObject() {
        super(getRobotTexture());
        alignPivot();
    }

    private var _currentPosition:Cell;
    private var _currentDirection:Number = 0;

    private function getRobotTexture():Texture {
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

    public function moveTo(targetCell:Cell):void {
        x = targetCell.x + (targetCell.width) / 2;
        y = targetCell.y + (targetCell.height) / 2;
        _currentPosition = targetCell;
    }

    public function get currentPosition():Cell {
        return _currentPosition;
    }

    public function rotate(degrees:Number):void {
        rotation = (rotation + (degrees / 180) * Math.PI);
    }

    public function get currentDirection():Number {
        var degrees:Number = (rotation / Math.PI) * 180;
        return degrees > 0 ? degrees % 360 : (360 + degrees) % 360;
    }
}
}
