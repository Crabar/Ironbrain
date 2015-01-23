/**
 * Created by Crabar on 1/18/15.
 */
package models {
import models.commands.ICommand;

public class CommandsDeck {
    public function CommandsDeck() {
        _cards = new <ICommand>[];
    }

    private var _cards:Vector.<ICommand>;

    public function getNextCommand():ICommand {
        return _cards.pop();
    }

    public function removeCommand():void {

    }

    public function addCommand(command:ICommand):void {
        _cards.push(command);
    }

    public function shuffle():void {
        var shuffledDeck:Vector.<ICommand> = new <ICommand>[];
        var randomIndex:uint;
        var deckSize:uint = _cards.length;

        for (var i:int = 0; i < deckSize; i++) {
            randomIndex = int(Math.random() * _cards.length);
            shuffledDeck.push(_cards[randomIndex]);
            _cards.splice(randomIndex, 1);
        }

        _cards = shuffledDeck;
    }

    public function get size():uint {
        return _cards ? _cards.length : 0;
    }
}
}
