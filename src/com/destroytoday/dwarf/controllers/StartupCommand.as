package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.services.ApplicationUpdaterService;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.ApplicationUtil;
	import com.google.analytics.GATracker;
	
	import flash.system.Capabilities;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * The StartupCommand class checks for application updates.
	 * @author Jonnie Hallman
	 */	
	public class StartupCommand extends SignalCommand {
		/**
		 * @private 
		 */		
		[Inject]
		public var updaterService:ApplicationUpdaterService;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var tracker:GATracker;
		
		/**
		 * @private
		 */		
		public function StartupCommand() {
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function execute():void {
			tracker.trackEvent("Application", "Startup", Capabilities.os);
			
			updaterService.updater.initialize();
		}
	}
}