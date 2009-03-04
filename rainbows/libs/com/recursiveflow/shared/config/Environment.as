package com.recursiveflow.shared.config
{
    import com.recursiveflow.shared.controller.EventBroadcaster;    
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    
    import com.recursiveflow.shared.config.ConfigEvent;
    import com.recursiveflow.shared.config.DataListener;
    import com.recursiveflow.shared.config.PropertiesFile;
    import com.recursiveflow.shared.config.UrlManager;        

    /**
     * Singleton class controlling access to global data.
     * 
     * System parameters (passed in as FlashVars) can be accessed via @see getParameter().
     * 
     * Environment properties (set in an external file) can be accessed via @see getProperty().
     * 
     * @author Alastair Dant
     */
    public class Environment extends EventDispatcher implements DataListener
    {
        //  MEMBER VARIABLES
        private var timeline : MovieClip;
        private var isInitialised : Boolean;

        // PROPS FILE
        private var propFile : PropertiesFile;

        // SINGLETON INSTANCE VARIABLE
        private static var instance : Environment;

        private var urlManager : UrlManager;
        private var eventBroadcaster : EventBroadcaster;

        // NOTE THIS CONSTRUCTOR WOULD BE PRIVATE IN ANY SENSIBLE COMPILER
		function Environment() 
		{
			timeline = null;
			isInitialised = false;
			eventBroadcaster = new EventBroadcaster();
        }

        /**
		 * Static factory method returning reference to current instance
		 */
		public static function getInstance():Environment 
		{
			if (instance == null) { instance = new Environment(); }
			
			return instance;
		}
		
		/**
		 * Initialises this instance by loading external properties etc
		 * 
		 * Requires a reference to the root timeline.		 */
		public function init(timeline:MovieClip, onComplete:Function):void
		{
			if (!isInitialised)
			{	
				this.timeline = timeline;
                
                addEventListener(ConfigEvent.READY, onComplete);
                
                loadProperties();
			}
		}
	
		/**		 * Looks up the property with the given key, provided that the environment has been initialised successfully.
		 */
		public function getProperty(key:String):String
		{
			return propFile.getProperty(key);
		}
		
		/**
		 * Checks the root timeline for the required parameter.  Supplies default values as appropriate.
		 */
		public function getParameter(key:String):String
		{
			//return (timeline[key] == undefined) ? this.getDefaultParameterValue(key) : timeline[key];
			return getDefaultParameterValue(key);
		}
		
		public function getUrlManager() : UrlManager
		{
			return this.urlManager;	
		}
		
		private function loadProperties() : void 
		{
			// build a URL based on the root path specified in the startup parameters
			var url:String = getParameter("configroot") + "environment.properties";		
			
			propFile = new PropertiesFile(url);
			propFile.load(this);
		}
					
		private function getDefaultParameterValue(key : String) : String 
		{
			switch (key)
			{
				case "localecode":	return "en";
				case "configroot":	return "";
				default:			return "Unknown parameter";
            }
        }
        
        /**
         * @see DataListener
         */
        public function handleHTTPStatus(event : HTTPStatusEvent) : void
        {
        	// ignore
        }
        
        /**
         * @see DataListener
         */
        public function handleProgress(event : ProgressEvent) : void
        {
        	// ignore
        }

        /**
         * @see DataListener
         */        
        public function handleComplete(event : Event) : void
        {
            isInitialised = true;
			urlManager = new UrlManager(this);                
            dispatchEvent(new ConfigEvent(ConfigEvent.READY));
        }

        /**
         * @see DataListener
         */        
        public function handleSecurityError(event : SecurityErrorEvent) : void
        {
        	trace("Encountered security error whilst loading " + event.target);
        	trace(event.text);
        }

        /**
         * @see DataListener
         */        
        public function handleIOError(event : IOErrorEvent) : void
        {
        	trace("Encountered IO error whilst loading " + event.target);
        	trace(event.text);        	
        }
        
        public function getEventBroadcaster() : EventBroadcaster
        {
            return eventBroadcaster;
        }
    }
}