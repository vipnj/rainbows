package com.recursiveflow.shared.controller 
{    import flash.utils.getQualifiedClassName;
    
    import com.recursiveflow.shared.controller.Command;    

    /**
     * Base implementation of the Command interface including some straightforward plumbing.
     *      * @author Alastair Dant     */    public class BaseCommand implements Command 
    {        private var manager : CommandManager;

        public function getName() : String
        {            return getQualifiedClassName(this);
        }

        public function setManager(mgr : CommandManager) : void
        {
            this.manager = mgr;        }

        public function getManager() : CommandManager
        {            return this.manager;
        }

        public function execute(context : Object) : void
        {
        }
    }}