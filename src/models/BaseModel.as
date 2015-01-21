/**
 * Created by Crabar on 1/18/15.
 */
package models {
import starling.events.EventDispatcher;


[Event(name="dataChanged", type="events.ModelEvent")]
public class BaseModel extends EventDispatcher {
    public function BaseModel() {
        super();
    }
}
}
