package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.views.guide.GuideView;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * The AddGuideCommand class creates the GuideView instance's mediator.
	 * @author Jonnie Hallman
	 */	
	public class AddGuideCommand extends Command {
		[Inject]
		public var guide:GuideView;
		
		/**
		 * @private
		 */		
		public function AddGuideCommand() {
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function execute():void {
			mediatorMap.createMediator(guide);
		}
	}
}