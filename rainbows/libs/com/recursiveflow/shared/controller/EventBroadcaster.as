package com.recursiveflow.shared.controller 
{    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    
    import com.recursiveflow.shared.controller.EventSubscriber;    

    /**
     * Relays event notifications to all interested parties.
     *      * @author Alastair Dant     */    public class EventBroadcaster extends EventDispatcher implements EventSubscriber
    {        private var eventSubscriptionMap : Dictionary;
        
        public function EventBroadcaster()
        {            super(null);
            
            this.eventSubscriptionMap = new Dictionary();        }
        
        public function register(eventType:String, subscriber:EventSubscriber):void
        {
        	if (!eventSubscriptionMap[eventType])
        	{
        		eventSubscriptionMap[eventType] = [];
        	}
        	
        	getSubscribers(eventType).push(subscriber);
        }

        public function notify(event:Event):void
        {
        	if (hasSubscribers(event.type))
        	{
	        	for each (var subscriber : EventSubscriber in getSubscribers(event.type)) 
	        	{
                    subscriber.notify(event);
                }
        	}        	
        }
        
        private function getSubscribers(eventType : String) : Array
        {
            return eventSubscriptionMap[eventType] as Array;
        }
        
        private function hasSubscribers(eventType : String) : Boolean
        {
            return (eventSubscriptionMap[eventType]);
        }
    }}