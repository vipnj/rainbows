package com.recursiveflow.shared.config 
{
    import flash.net.URLRequest;    
    
    /**
     * Responsible for building URLs according to the current environment configuration. 
     * 
     * @author Alastair Dant
     */
    public class UrlManager
    {
        private var env : Environment;

        public function UrlManager(env : Environment) 
        {
            this.env = env;
        }

        public function getResourceURL(type : String, filename : String) : URLRequest
        {
            return makeRequest(env.getProperty("url.resources.base") + env.getProperty("url.resources." + type) + filename);	
        }

        public function getServiceURL(name : String) : URLRequest
        {
            return makeRequest(env.getProperty("url.services.base") + env.getProperty("url.services." + name));	
        }

        public function getConfigURL(name : String) : URLRequest
        {
            return makeRequest(buildConfigURL("", name));	
        }

        public function buildConfigURL(directory : String, name : String) : String 
        {
            var base : String = env.getParameter("configroot");
            var file : String = env.getProperty("url.config." + name);
		
            return base + directory + file;	
        }	
        
        private function makeRequest(url : String) : URLRequest
        {
            return new URLRequest(url);
        }
    }
}