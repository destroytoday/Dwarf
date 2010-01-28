package com.destroytoday.dwarf.contexts {
	import com.destroytoday.dwarf.constants.Config;
	import com.destroytoday.dwarf.controllers.AddRulerCommand;
	import com.destroytoday.dwarf.controllers.StartupCommand;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.desktop.IconMenu;
	import com.destroytoday.dwarf.desktop.MacToolbar;
	import com.destroytoday.dwarf.desktop.RulerMenu;
	import com.destroytoday.dwarf.mediators.ApplicationUpdaterMediator;
	import com.destroytoday.dwarf.mediators.RulerMediator;
	import com.destroytoday.dwarf.mediators.ToolbarMediator;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.services.ApplicationUpdaterService;
	import com.destroytoday.dwarf.signals.AddRulerSignal;
	import com.destroytoday.dwarf.signals.AddToolSignal;
	import com.destroytoday.dwarf.signals.RemoveToolSignal;
	import com.destroytoday.dwarf.signals.StartupSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.dwarf.views.toolbar.ToolbarView;
	import com.destroytoday.dwarf.views.updater.ApplicationUpdaterView;
	import com.destroytoday.util.ApplicationUtil;
	import com.google.analytics.GATracker;
	
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
			// map controllers
			injector.mapSingleton(ToolController);
			
			// map services
			injector.mapSingleton(ApplicationUpdaterService);
			injector.mapValue(GATracker, new GATracker(contextView, Config.GOOGLE_ANALYTICS_ACCOUNT, "AS3"));
			
			// map models
			injector.mapSingleton(ToolModel);

			// map other
			injector.mapSingleton(IconMenu);
			injector.mapSingleton(RulerMenu);
			
			// map signal commands
			var startupSignal:StartupSignal = StartupSignal(signalCommandMap.mapSignalClass(StartupSignal, StartupCommand));
			injector.mapValue(StartupSignal, startupSignal);
			injector.mapValue(AddRulerSignal, signalCommandMap.mapSignalClass(AddRulerSignal, AddRulerCommand));
			
			// map signals
			injector.mapSingleton(AddToolSignal);
			injector.mapSingleton(RemoveToolSignal);
			
			// map view mediators
			mediatorMap.mapView(ApplicationUpdaterView, ApplicationUpdaterMediator);
			mediatorMap.mapView(ToolbarView, ToolbarMediator);
			mediatorMap.mapView(RulerView, RulerMediator);
			
			// continue mapping instances after signals
			if (ApplicationUtil.mac) {
				injector.mapSingleton(MacToolbar);
				
				var toolbar:MacToolbar = new MacToolbar();
				
				injector.injectInto(toolbar);
				
				toolbar.setup();
			}
			
			var iconMenu:IconMenu = new IconMenu();
			injector.injectInto(iconMenu);
			iconMenu.setup();
			
			startupSignal.dispatch();
		}
	}
}