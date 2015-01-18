/**
 * Created by Crabar on 1/18/15.
 */
package events {
import flash.events.Event;

public class ModelEvent extends Event {
    public static const DATA_CHANGED:String = "dataChanged";

    public function ModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }


}
}
