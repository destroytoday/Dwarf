package com.destroytoday.dwarf.contexts {
	import com.destroytoday.dwarf.desktop.Toolbar;
	import com.destroytoday.util.ApplicationUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	/**
	 * The ApplicationContext is the context of the application. (perfect description)
	 * @author Jonnie Hallman
	 */	
	public class ApplicationContext extends Context {
		/**
		 * Construct the ApplicationContext instance.
		 * @param contextView
		 * @param autoStartup
		 */		
		public function ApplicationContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function startup():void {
			injector.mapSingleton(Toolbar);
			
			if (ApplicationUtil.mac) new Toolbar().setup();
		}
	}
}