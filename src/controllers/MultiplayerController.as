/**
 * Created by Crabar on 1/25/15.
 */
package controllers {
import avmplus.getQualifiedClassName;

import com.reyco1.multiuser.MultiUserSession;
import com.reyco1.multiuser.data.UserObject;

import flash.net.registerClassAlias;

import models.PlaygroundModel;
import models.commands.ICommand;
import models.commands.MoveForwardBy1Command;
import models.commands.TurnLeftCommand;
import models.commands.TurnRightCommand;

import starling.events.EventDispatcher;

public class MultiplayerController extends EventDispatcher {
    public static const INITIALIZED:String = "initialized";
    public static const USER_CONNECTED:String = "userConnected";
    public static const USER_ADDED:String = "userAdded";
    public static const USER_DISCONNECTED:String = "";
    public static const DATA_RECEIVED:String = "dataReceived";
    public static const ALL_PLAYERS_CONNECTED:String = "allPlayersConnected";

    private var _model:PlaygroundModel;
    private var _connection:MultiUserSession;
    private var _expectingPlayers:uint = 0;
    private var _users:Array;

    private static const SERVER:String = "rtmfp://p2p.rtmfp.net/";
    private static const DEV_KEY:String = "c76915953ea52b2c47e1acc4-c26c1042f0a6";


    public function MultiplayerController(model:PlaygroundModel) {
        _model = model;
        registerClasses();
    }

    private function registerClasses():void {
        registerClassAlias(getQualifiedClassName(MoveForwardBy1Command), MoveForwardBy1Command);
        registerClassAlias(getQualifiedClassName(TurnLeftCommand), TurnLeftCommand);
        registerClassAlias(getQualifiedClassName(TurnRightCommand), TurnRightCommand);
    }

    public function connect(expectingPlayers:uint):void {
        _expectingPlayers = expectingPlayers;
        _connection = new MultiUserSession(SERVER + DEV_KEY, "ironbrain-test");
        _connection.onConnect = onConnected;
        _connection.onUserAdded = onUserAdded;
        _connection.onUserRemoved = onUserRemoved;
        _connection.onObjectRecieve = onDataReceive;
        _connection.connect("thisUser" + Math.random().toString(), new Date().time - new Date().timezoneOffset);
    }

    private function getUserIdFromPeerId(peerId:String):int {
        for (var i:int = 0; i < _users.length; i++) {
            var object:UserObject = _users[i];
            if (object.id == peerId)
                return i;
        }

        return -1;
    }

    private function onDataReceive(peerID:String, data:Object):void {
        var userId:int = getUserIdFromPeerId(peerID);

        if (userId != -1) {
            for (var i:int = 0; i < data.length; i++) {
                var object:ICommand = data[i];
                _model.addActiveCommand(i, object, userId);
            }
        }

        dispatchEventWith(DATA_RECEIVED);
    }

    private function onUserRemoved(user:UserObject):void {
        //
    }

    private function onUserAdded(user:UserObject):void {
        if (_connection.userArray.length == _expectingPlayers) {
            _users = _connection.userArray.sortOn("details", Array.NUMERIC);
            dispatchEventWith(ALL_PLAYERS_CONNECTED, false, _users)
            _connection.onUserAdded = null;
        }
    }

    private function onConnected(user:UserObject):void {
        dispatchEventWith(USER_CONNECTED, false, user);

        if (_connection.userArray.length == _expectingPlayers) {
            _users = _connection.userArray.sortOn("details", Array.NUMERIC);
            dispatchEventWith(ALL_PLAYERS_CONNECTED, false, _users);
        }

    }

    public function sendActiveCommands(commands:Vector.<ICommand>):void {
        _connection.sendObject(commands);
    }

    public function closeSession():void {
        if (_connection)
            _connection.close();
    }
}
}
