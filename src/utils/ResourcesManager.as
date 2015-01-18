/**
 * Created by Crabar on 1/18/15.
 */
package utils {
import flash.filesystem.File;

import starling.textures.Texture;

import starling.utils.AssetManager;

public class ResourcesManager {
    private static var _assetManager:AssetManager;

    public static function init(scaleFactor:uint):void {
        _assetManager = new AssetManager(scaleFactor, true);
    }

    public static function loadTextures():void {
        var appDir:File = File.applicationDirectory;
        _assetManager.enqueue(appDir.resolvePath("assets/textures"));
        _assetManager.loadQueue(onLoadAssetsProgress);
    }

    private static function onLoadAssetsProgress(ratio:Number):void {

    }

    public static function getTexture(name:String):Texture {
        return _assetManager.getTexture(name);
    }
}
}
