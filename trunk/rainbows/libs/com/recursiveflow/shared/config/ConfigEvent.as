package com.recursiveflow.shared.config 
{    import flash.events.Event;
    
    /**
     * Used to signal that initial config data is ready or that configuration changes have occurred. 
     *      * @author Alastair Dant     */    public class ConfigEvent extends Event 
    {
        public static const READY : String = "Initial Config Available";
        
        public function ConfigEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
        {            super(type, bubbles, cancelable);        }
    }}