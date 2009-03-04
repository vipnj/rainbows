package com.recursiveflow.shared.config 
{
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.utils.Dictionary;

    import com.recursiveflow.shared.util.StringUtil;    

    /**
     * Allows access to Java resource bundle style properties files without use of Flex framework.
     * 
     * @author Alastair Dant
     */
    public class PropertiesFile
    {
        private var url : URLRequest;
        private var	properties : Object;
        private var listener : DataListener;

        public function PropertiesFile(url : String) 
        {
            this.url = new URLRequest(url);
        }

        public function load(listener : DataListener) : void
        {
            var loader : URLLoader = new URLLoader();

            this.listener = listener;

            // set handler to deal with successful completion of load process 
            loader.addEventListener(Event.COMPLETE, processData);
			
            // delegate all other handling to the data listener		
            loader.addEventListener(ProgressEvent.PROGRESS, listener.handleProgress);	
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, listener.handleSecurityError);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, listener.handleHTTPStatus);
            loader.addEventListener(IOErrorEvent.IO_ERROR, listener.handleIOError);

            try 
            {
                loader.load(url);
            } 
            catch (error : Error) 
            {
                trace("Unable to load properties file from " + url + " - " + error);
            }
        }

        public function getSubset(prefix : String) : Dictionary
        {
            var result : Dictionary = new Dictionary();
            var len : Number = prefix.length;
		
            for(var s:String in properties)
            {
                if(s.substr(0, len) == prefix)
                {
                    result[s] = properties[s];
                }
            }
		
            return result;
        }

        public function hasProperty(key : String) : Boolean
        {
            return (properties[key] != null);
        }

        public function getProperties() : Object
        {
            return this.properties;
        }

        public function getProperty(key : String) : String 
        {
            return StringUtil.trimTrailingSpace(properties[key] as String);
        }

        public function getNumericProperty(key : String) : Number 
        {
            return Number(getProperty(key));
        }

        public function getBooleanProperty(key : String) : Boolean 
        {
            return (getProperty(key).toLowerCase() == "true");
        }

        private function processData(event : Event) : void 
        {
            var loader : URLLoader = event.target as URLLoader;
            
            if (loader.dataFormat == URLLoaderDataFormat.TEXT)
            {            
                trace("Handling Java style props file");
                properties = parse(loader.data as String);
                
                StringUtil.dumpToLog(properties, 3);
            }
            else if (loader.dataFormat == URLLoaderDataFormat.VARIABLES)
            {
                trace("Handling URL-encoded variables");
                properties = loader.data as URLVariables;				            	
            }
            else
            {
                trace("Unable to process specified properties file");
                properties = new Dictionary();
            }           
            
            listener.handleComplete(event);
        }

        private function parse(data : String) : Dictionary
        {
			var propsMap : Dictionary = new Dictionary();
            var propsList : Array = data.split("\n");
            var propsPair : Array;
		
            for (var i : Number = 0;i < propsList.length; i++) 
            {
                propsPair = propsList[i].split("=");
                
                if (propsPair.length == 2) { propsMap[propsPair[0]] = propsPair[1]; }
            }
		
            return propsMap;
        }
    }
}