package com.recursiveflow.shared.controller 
{

    /**
     * Encapsulates an atomic block of application logic as per the GOF Command pattern. 
     * 
     * @author Alastair Dant
     */
    public interface Command
    {
        function getName() : String;
        
        function setManager( mgr : CommandManager) : void;

        function getManager() : CommandManager;

        function execute(context : Object) : void;
    }
}