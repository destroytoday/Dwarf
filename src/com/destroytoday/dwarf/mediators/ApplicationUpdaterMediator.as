package com.destroytoday.dwarf.mediators {
	import air.update.events.DownloadErrorEvent;
	
	import com.destroytoday.dwarf.services.ApplicationUpdaterService;
	import com.destroytoday.dwarf.views.updater.ApplicationUpdaterView;
	import com.destroytoday.events.TextFieldLinkManagerEvent;
	import com.destroytoday.text.TextFieldLinkManager;
	
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationUpdaterMediator extends Mediator {
		[Inject]
		public var updaterService:ApplicationUpdaterService;
		
		[Inject]
		public var view:ApplicationUpdaterView;
		
		public namespace ns = "http://ns.adobe.com/air/framework/update/description/1.0";
		
		public function ApplicationUpdaterMediator() {
		}
		
		override public function onRegister():void {
			eventMap.mapListener(view.textfield.linkManager, TextFieldLinkManagerEvent.LINK_CLICK, linkClickHandler, TextFieldLinkManagerEvent);
			eventMap.mapListener(updaterService.updater, ProgressEvent.PROGRESS, downloadProgressHandler, ProgressEvent);
			eventMap.mapListener(updaterService.updater, DownloadErrorEvent.DOWNLOAD_ERROR, downloadErrorHandler, DownloadErrorEvent);
			
			view.setInfo(updaterService.updater.currentVersion, updaterService.updater.updateDescriptor.ns::version);
			
			view.stage.nativeWindow.activate();
		}
		
		protected function linkClickHandler(event:TextFieldLinkManagerEvent):void {
			if (event.url == "update") {
				updaterService.updater.downloadUpdate();
			} else {
				updaterService.updater.cancelUpdate();
				
				view.close();
			}
		}
		
		protected function downloadProgressHandler(event:ProgressEvent):void {
			view.setProgress(event.bytesLoaded, event.bytesTotal);
		}
		
		protected function downloadErrorHandler(event:DownloadErrorEvent):void {
			view.setError(event.text);
		}
	}
}