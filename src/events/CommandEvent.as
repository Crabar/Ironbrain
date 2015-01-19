/**
 * Created by Crabar on 1/18/15.
 */
package events {
import starling.events.Event;

public class CommandEvent extends Event {
    public static const COMMAND_ENDED:String = "commandEnded";

    public function CommandEvent(type:String) {
        super(type, bubbles, false);
    }
}
}
