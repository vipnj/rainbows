package com.recursiveflow.shared.controller 
{    import flash.utils.Dictionary;
    
    import com.recursiveflow.shared.controller.CommandManager;
    
    import flash.utils.getDefinitionByName;    

    /**
     * Simple CommandManager implementation that manages registered Command classes in a dictionary
     * and creates new Command instances from them as required.
     *      * @author Alastair Dant     */    public class SimpleCommandManager implements CommandManager 
    {
        private var commandMap : Dictionary;
        private var commandList : Array;

        public function SimpleCommandManager() 
    	{
    		this.commandMap = new Dictionary(true);
            this.commandList = [];
        }
    	        public function register(instance : Command) : void
        {
        	var name:String = instance.getName();
        	
        	commandMap[name] = getDefinitionByName(name) as Class;
        	commandList.push(name);
        }
        
        public function remove(name : String) : void
        {
        	commandMap[name] = undefined;
        }
        
        public function destroy() : void
        {
        	for each (var name : String in commandList) 
        	{
        		remove(name);	
        	}
        	
        	commandList = [];
        }
        
        public function createFrom(name : String) : Command
        {
        	if (commandMap[name])
        	{
        		var classDef:Class = commandMap[name] as Class;
           		
           		return new classDef() as Command;
        	}
        	else        	{
            	throw new Error("Attempt to create an unregistered Command");
            }
        }
        
        public function notifyComplete(command : Command) : void        {
        }
    }}