/**
 * Created by Crabar on 1/23/15.
 */
package models {
import asx.fn._;

import flash.events.Event;

import mockolate.nice;

import mockolate.prepare;

import models.commands.ICommand;

import models.commands.ICommand;

import org.flexunit.async.Async;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;

public class CommandsDeckTest {

    private var _deck:CommandsDeck;

    [Before(async, timeout=5000)]
    public function setUp():void {
        _deck = new CommandsDeck();
        Async.proceedOnEvent(this,
                prepare(ICommand),
                Event.COMPLETE);
    }

    [Test]
    public function testAddCommand():void {
        assertThat(_deck.size, equalTo(0));
        addMockCommandsToDeck(20);
        assertThat(_deck.size, equalTo(20));
    }

    private function addMockCommandsToDeck(count:uint):void {
        for (var i:int = 0; i < count; i++) {
            _deck.addCommand(nice(ICommand));
        }

    }

    [Test]
    public function testGetNextCommand():void {
        addMockCommandsToDeck(10);
        assertThat(_deck.getNextCommand(), instanceOf(ICommand));
        assertThat(_deck.size, equalTo(9));
    }
}
}
