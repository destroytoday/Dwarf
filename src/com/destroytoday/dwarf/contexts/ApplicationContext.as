package com.destroytoday.dwarf.contexts {
	import com.destroytoday.dwarf.controllers.AddRulerCommand;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.desktop.IconMenu;
	import com.destroytoday.dwarf.desktop.MacToolbar;
	import com.destroytoday.dwarf.desktop.RulerMenu;
	import com.destroytoday.dwarf.mediators.RulerMediator;
	import com.destroytoday.dwarf.mediators.ToolbarMediator;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddRulerSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.dwarf.views.toolbar.ToolbarView;
	import com.destroytoday.util.ApplicationUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.mvcs.SignalContext;
	
	/**
	 * The ApplicationContext is the context of the application. (perfect description)
	 * @author Jonnie Hallman
	 */	
	public class ApplicationContext extends SignalContext {
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
			injector.mapSingleton(ToolController);
			injector.mapSingleton(ToolModel);
			injector.mapSingleton(MacToolbar);
			injector.mapSingleton(IconMenu);
			injector.mapSingleton(RulerMenu);
			
			injector.mapValue(AddRulerSignal, signalCommandMap.mapSignalClass(AddRulerSignal, AddRulerCommand));
			
			if (ApplicationUtil.mac) {
				var toolbar:MacToolbar = new MacToolbar();
				
				injector.injectInto(toolbar);
				
				toolbar.setup();
			}
			
			var iconMenu:IconMenu = new IconMenu();
			injector.injectInto(iconMenu);
			iconMenu.setup();
			
			mediatorMap.mapView(ToolbarView, ToolbarMediator);
			mediatorMap.mapView(RulerView, RulerMediator);
		}
	}
}