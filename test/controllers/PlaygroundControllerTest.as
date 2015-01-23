/**
 * Created by Crabar on 1/23/15.
 */
package controllers {
import events.ModelEvent;

import mockolate.received;
import mockolate.runner.MockolateRule;

import models.PlaygroundModel;
import models.commands.ICommand;
import models.playground.Cell;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.nullValue;

public class PlaygroundControllerTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();
    [Mock]
    public var testCommand:ICommand;
    [Mock]
    public var model:PlaygroundModel;
    private var _playgroundController:PlaygroundController;

    [Before]
    public function setUp():void {
        _playgroundController = new PlaygroundController(model);
    }

    [Test]
    public function testGenerateAvailableCommands():void {
        assertThat(model.availableCommands, nullValue());
        _playgroundController.generateDeck(100);
        _playgroundController.generateAvailableCommands(100);
        assertThat(model.availableCommands.length, equalTo(100));

    }

    [Test]
    public function testGenerateDeck():void {
        assertThat(model.deck, equalTo(null));
        _playgroundController.generateDeck(100);
        assertThat(model.deck.size, equalTo(100));
    }

    [Test]
    public function testGenerateField():void {
        assertThat(model.field, nullValue());
        _playgroundController.generateField(1000, 1000, 20, 20);
        assertThat(model.field.length, equalTo(20));
        for (var i:int = 0; i < model.field.length; i++) {
            var row:Vector.<Cell> = model.field[i];
            assertThat(row.length, equalTo(20));
            for (var j:int = 0; j < row.length; j++) {
                assertThat(row[j], instanceOf(Cell));
            }
        }
    }

    [Test]
    public function testAddAvailableCommand():void {
        assertThat(model.availableCommands, nullValue());
        _playgroundController.addAvailableCommand(testCommand);
        assertThat(model.availableCommands.length, equalTo(1));
        _playgroundController.addAvailableCommand(testCommand);
        _playgroundController.addAvailableCommand(testCommand);
        _playgroundController.addAvailableCommand(testCommand);
        assertThat(model.availableCommands.length, equalTo(4));
    }

    [Test]
    public function testStartNewRound():void {
        _playgroundController.generateDeck(60);
        _playgroundController.startNewRound();
        assertThat(model.deck.size, equalTo(52));
        assertThat(model.availableCommands.length, equalTo(8));
        assertThat(model, received().method("dispatchEventWith").args(equalTo(ModelEvent.DATA_CHANGED)));
    }

    [Test]
    public function testAddAndRemoveActiveCommand():void {
        _playgroundController.addActiveCommand(0, testCommand);
        assertThat(model.activeCommands[0], equalTo(testCommand));
        _playgroundController.removeActiveCommand(0);
        assertThat(model.activeCommands[0], nullValue());

    }

}
}
