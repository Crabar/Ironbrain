/**
 * Created by Crabar on 1/18/15.
 */
package events {
import starling.events.Event;

public class AnimationEvent extends Event {

    public static const ANIMATION_ENDED:String = "animationEnded";

    public function AnimationEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
