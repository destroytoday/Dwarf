package com.destroytoday.dwarf.views.updater {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.util.NumberUtil;
	
	import flash.display.Bitmap;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class ApplicationUpdaterView extends Group {
		public var icon:Bitmap;
		
		public var textfield:UpdaterTextField;
		
		protected var currentVersion:String;
		
		protected var newVersion:String;
		
		public function ApplicationUpdaterView() {
			// set NativeWindow properties
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();

			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.maximizable = false;
			windowOptions.minimizable = false;
			windowOptions.resizable = false;

			var window:NativeWindow = new NativeWindow(windowOptions);
			
			// instantiate components
			icon = addChild(new Assets.ICON_48X48()) as Bitmap;
			textfield = addChild(new UpdaterTextField()) as UpdaterTextField;
			
			icon.x = 20.0;
			icon.y = 20.0;
			
			measureChildren = false;
			
			left = 0.0;
			top = 0.0;
			right = 0.0;
			bottom = 0.0;
			
			window.stage.addChild(this);

			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			window.stage.align = StageAlign.TOP_LEFT;
			
			window.title = "Dwarf / Updater";
			window.width = 300.0;
			window.height = 200.0;
		}
		
		public function setInfo(currentVersion:String, newVersion:String):void {
			this.currentVersion = currentVersion;
			this.newVersion = newVersion;
			
			textfield.linkManager.htmlText = 
				"<h1>New Update Available</h1><br/>" +
				"Current version: " + currentVersion + "<br/>" +
				"New version: " + newVersion + "<br/><br/>" +
				"<a href=\"event:update\">Update now</a><br/>" + 
				"<a href=\"event:ignore\">Ignore</a>";
		}

		public function setProgress(bytesLoaded:Number, bytesTotal:Number):void {
			textfield.linkManager.htmlText = 
				"<h1>New Update Available</h1><br/>" +
				"Current version: " + currentVersion + "<br/>" +
				"New version: " + newVersion + "<br/><br/>" +
				int((bytesLoaded / bytesTotal) * 100.0) + "% of " + NumberUtil.pad(bytesTotal * 0.001, 1) + "kb";
		}
		
		public function setError(error:String):void {
			textfield.linkManager.htmlText = 
				"<h1>New Update Available</h1><br/>" +
				"Current version: " + currentVersion + "<br/>" +
				"New version: " + newVersion + "<br/><br/>" +
				"<span class=\"error\">Error: " + error + "</span>";
		}
		
		override protected function updateBounds():void {
			super.updateBounds();
			
			graphics.clear();
			graphics.beginFill(Color.GREY_2);
			graphics.drawRect(0.0, 0.0, width, height);
			graphics.endFill();
		}
		
		public function close():void {
			stage.nativeWindow.close();
		}
	}
}