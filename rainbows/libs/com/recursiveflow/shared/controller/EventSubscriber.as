package com.recursiveflow.shared.controller 
{
    import flash.events.Event;    
    
    /**
     * Designates that a class is capable of subscribing to Event broadcasts.
     *      * @author Alastair Dant     */    public interface EventSubscriber 
    {
    	function notify(event:Event):void;    }}