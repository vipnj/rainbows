package com.recursiveflow.shared.controller 
{
    /**
     * Defines how one state may transition to the next in a StateMachine.
     * 
     * @author Alastair Dant
     */
    public class StateTransition 
    {
        private var sourceStates : Array;
        private var targetState : State;
        private var handlerName : String;

        public function StateTransition(sourceStates : Array, targetState : State, handlerName : String) 
        {
            this.sourceStates = sourceStates;
            this.targetState = targetState;
            this.handlerName = handlerName;		
        }

        public function isAvailableFrom(state : State) : Boolean 
        {
            var i : Number = sourceStates.length;
            var allowed : Boolean = (i == 0);
		
            while (!allowed && --i >= 0)
            {
                allowed = (state == sourceStates[i]);
            }		
		
            return allowed;
        }

        public function getTargetState() : State 
        {
            return this.targetState;	
        }

        public function getHandlerName() : String 
        {
            return this.handlerName;
        }
    }
}