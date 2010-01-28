package com.destroytoday.dwarf.services {
	import air.update.ApplicationUpdater;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	
	import com.destroytoday.dwarf.constants.Config;
	import com.destroytoday.dwarf.views.updater.ApplicationUpdaterView;
	import com.google.analytics.GATracker;
	
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.mvcs.Actor;
	
	public class ApplicationUpdaterService extends Actor {
		/**
		 * @private 
		 */		
		[Inject]
		public var tracker:GATracker;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		public var updater:ApplicationUpdater;
		
		public function ApplicationUpdaterService() {
			updater = new ApplicationUpdater();
			
			updater.updateURL = Config.APPLICATION_UPDATER_URL;
			
			updater.addEventListener(UpdateEvent.INITIALIZED, initializedHandler);
			updater.addEventListener(ErrorEvent.ERROR, errorHandler);
			updater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, checkForUpdateHandler);
			updater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, updateStatusHandler);
			updater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, updateErrorHandler);
			updater.addEventListener(UpdateEvent.DOWNLOAD_START, downloadStartHandler);
			updater.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			updater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, downloadCompleteHandler);
			updater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, downloadErrorHandler);
			updater.addEventListener(UpdateEvent.BEFORE_INSTALL, beforeInstallHandler);
		}
		
		protected function initializedHandler(event:UpdateEvent):void {
			trace(event);	
			
			if (updater.isFirstRun) {
				if (updater.previousVersion) {
					tracker.trackEvent("Application", "Install", updater.currentVersion);
				} else {
					tracker.trackEvent("Application", "Update", updater.previousVersion + " to " + updater.currentVersion);
				}
			}
			
			updater.checkNow();
		}
		
		protected function errorHandler(event:ErrorEvent):void {
			trace(event);	
		}
		
		protected function checkForUpdateHandler(event:UpdateEvent):void {
			trace(event);	
		}
		
		protected function updateStatusHandler(event:StatusUpdateEvent):void {
			event.preventDefault();
			
			trace(event);	
			
			if (event.available) {
				mediatorMap.createMediator(new ApplicationUpdaterView());
			}
		}

		protected function updateErrorHandler(event:StatusUpdateErrorEvent):void {
			trace(event);	
		}
		
		protected function downloadStartHandler(event:UpdateEvent):void {
			trace(event);	
		}
		
		protected function progressHandler(event:ProgressEvent):void {
			trace(event);	
		}
		
		protected function downloadCompleteHandler(event:UpdateEvent):void {
			trace(event);	
		}
		
		protected function downloadErrorHandler(event:DownloadErrorEvent):void {
			trace(event);	
		}
		
		protected function beforeInstallHandler(event:UpdateEvent):void {
			trace(event);	
		}
	}
}
