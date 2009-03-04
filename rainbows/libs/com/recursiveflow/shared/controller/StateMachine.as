package com.recursiveflow.shared.controller 
{
    import flash.events.Event;
    import flash.utils.Dictionary;

    import com.recursiveflow.shared.config.Environment;

    /**
     * AS3 implementation of a StateMachine capable of tracking changes to application state via AS3 events.
     * 
     * Upon notification of a new event, determines if transition is permitted from current state.
     * 
     * If so, fires Command specified as transition handler, then switches to required target state.
     * 
     * @author Alastair Dant
     */
    public class StateMachine extends SimpleCommandManager implements EventSubscriber
    {
        private static var ALL_OTHER_STATES : String = "*";
        
        // reference to environment
        private var env : Environment;
        
        // state management variables
        private var active : Boolean;
        private var transitionMap : Dictionary;
        private var currentState : State;
        private var currentTransition : StateTransition;
        private var currentHandler : Command;

        public function StateMachine(env : Environment) 
        {
            this.env = env;
            this.active = false;
            this.currentState = State.DEFAULT;
            this.transitionMap = new Dictionary();
        }

        public function notify(event : Event) : void 
        {
            if (transitionMap[event.type])
            {
                performTransitionFor(event.type, {});					
            }
        }

        public function getCurrentState() : State
        {
            return currentState;
        }

        public function addTransition(eventName : String, sourceStates : Array, target : State, handler : Command) : void
        {
            var transition : StateTransition = new StateTransition(sourceStates, target, handler.getName());
			var stateTransitionMap : Object;
			
			// fetch the transition map entry for this event if it already exists
			if (transitionMap[eventName])
			{
				stateTransitionMap = transitionMap[eventName];
			}
            // otherwise, create transition map for this event and register self for notification
			else
			{		
				stateTransitionMap = {};
				env.getEventBroadcaster().register(eventName, this);
			}
			
			// register transition handler, overwriting previous entry if it already exists
			register(handler);
			
            // if some source states were provided, loop through and make the appropriate state->transition mappings
            if (sourceStates.length > 0)
            {
                for (var i : Number = 0;i < sourceStates.length; i++) 
                {
                    stateTransitionMap[State(sourceStates[i])] = transition;	
                }
            }
			// otherwise, add wildcard mapping so that all other source states trigger the same transition
			else
            {	
                trace("f adding wildcard rule for transition triggered by event " + eventName);
			
                stateTransitionMap[ALL_OTHER_STATES] = transition;			
            }
		
            // put the transition map for the specified event back into the master transition map
            transitionMap[eventName] = stateTransitionMap;		
        }

        public function performTransitionFor(eventName : String, context : Object) : void 
        {
            trace("attempting to perform transition for " + eventName);
            
            currentTransition = findTransitionFor(eventName);
			
            trace("found transition handler " + currentTransition.getHandlerName());

            if (currentTransition && currentTransition.isAvailableFrom(currentState))
            {			
                var targetState : State = currentTransition.getTargetState();
			
                trace(eventName + " - switching from " + currentState.getName() + " to " + targetState.getName());
			
                currentHandler = createFrom(currentTransition.getHandlerName());
			
                currentState = (targetState == State.KEEP_CURRENT ? currentState : targetState);
                currentHandler.execute(prepare(context));
            }	
			else
            {
                trace(eventName + " - cannot transition from " + currentState.getName() + " to " + currentTransition.getTargetState().getName());
            }
        }
        private function findTransitionFor(eventName : String) : StateTransition        {
            if (transitionMap[eventName])
            {
                var transition : StateTransition = null;		
                var stateTransitionMap : Object = transitionMap[eventName];
	
                if (stateTransitionMap[currentState])
                {
                    transition = StateTransition(stateTransitionMap[currentState]);
                }
				else if (stateTransitionMap[ALL_OTHER_STATES])
                {
                    transition = StateTransition(stateTransitionMap[ALL_OTHER_STATES]);
                }
				
                return transition;
            }
			else
            {
                return null;	
            }
        }

        private function prepare(context : Object) : Object 
        {
            return context;	
        }
    }
}