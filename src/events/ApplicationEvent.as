package events
{
import flash.events.Event;

public class ApplicationEvent extends Event
{
    public static const VIEW_CHANGED:String = "viewChanged";

    public function ApplicationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event
    {
        return new ApplicationEvent(type, bubbles, cancelable);
    }
}
}