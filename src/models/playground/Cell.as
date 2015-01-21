/**
 * Created by Crabar on 1/17/15.
 */
package models.playground {
public class Cell {
    public function Cell(x:Number, y:Number, width:Number, height:Number, rowIndex:uint, colIndex:uint) {
        _x = x;
        _y = y;
        _width = width;
        _height = height;
        _rowIndex = rowIndex;
        _colIndex = colIndex;
        _children = new <CellObject>[];
    }

    private var _x:Number;
    private var _y:Number;
    private var _width:Number;
    private var _height:Number;
    private var _rowIndex:uint;
    private var _colIndex:uint;
    private var _children:Vector.<CellObject>;

    public function get x():Number {
        return _x;
    }

    public function get y():Number {
        return _y;
    }

    public function get width():Number {
        return _width;
    }

    public function get height():Number {
        return _height;
    }

    public function get rowIndex():uint {
        return _rowIndex;
    }

    public function get colIndex():uint {
        return _colIndex;
    }

    public function get children():Vector.<CellObject> {
        return _children;
    }

    public function addChild(child:CellObject):void {
        _children.push(child);
        child.cell = this;
    }
}
}
