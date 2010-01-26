package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * The AddRulerCommand class creates the RulerView instance's mediator.
	 * @author Jonnie Hallman
	 */	
	public class AddRulerCommand extends SignalCommand {
		[Inject]
		public var ruler:RulerView;
		
		/**
		 * @private
		 */		
		public function AddRulerCommand() {
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function execute():void {
			mediatorMap.createMediator(ruler);
		}
	}
}