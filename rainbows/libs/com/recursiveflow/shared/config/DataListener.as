package com.recursiveflow.shared.config 
{
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;    

    /**
     * Packages up all of the handlers required to observe data loading into a single interface.
     *      * @author Alastair Dant     */    public interface DataListener 
    {
    	function handleProgress(event : ProgressEvent) : void
    	function handleComplete(event : Event) : void;
    	function handleHTTPStatus(event : HTTPStatusEvent) : void;
    	function handleSecurityError(event : SecurityErrorEvent) : void;
		function handleIOError(event : IOErrorEvent) : void;    	    }}