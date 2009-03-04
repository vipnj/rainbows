package com.recursiveflow.rainbows.control {    import flash.net.URLRequest;            import com.recursiveflow.shared.controller.BaseCommand;        import com.recursiveflow.rainbows.Application;        /**     * Prompts the parent application to load and play the required source wave.     *      * Queries the environment to determine where the appropriate asset will be located.     *      * @author Alastair Dant     */    public class SelectMusicCommand extends BaseCommand    {        private var parent : Application;        private var source : URLRequest;        public function SelectMusicCommand(parent:Application, file:String)         {            this.parent = parent;            this.source = parent.getSource(file);        }        public override function execute(context : Object) : void        {        	parent.changeMusic(source);        }    }}