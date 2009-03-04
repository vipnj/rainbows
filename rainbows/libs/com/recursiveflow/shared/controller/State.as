package com.recursiveflow.shared.controller 
{
    /**
     * Base class representing a state in program logic. Uses the typesafe enum style of constant definition.
     * 
     * Subclasses are welcome to add new state constants. 
     * 
     * @author Alastair Dant
     */
    public class State 
    {
        public static var DEFAULT : State = new State("Default state");
        public static var KEEP_CURRENT : State = new State("Keeps current state rather than transitioning to another");
        
        private var name : String;

        public function State(name : String) 
        {
            this.name = name;
        }

        public function getName() : String
        {
            return name;
        }

        public function toString() : String
        {
            return this.name;
        }
    }
}