package com.recursiveflow.shared.controller
{
    import com.recursiveflow.shared.controller.Command;

    /**
     * Combines a map-backed factory "create" method with some supporting functions.
     * 
     * @author Alastair Dant
     */
    public interface CommandManager
    {
    	function register(instance : Command) : void;   
    	
    	function remove(name : String) : void; 	
    	
    	function destroy() : void;
    	
        function createFrom(name : String) : Command;
        
        function notifyComplete(command : Command) : void;
    }
}