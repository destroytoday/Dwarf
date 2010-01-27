package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.util.ApplicationUtil;
	
	import flash.desktop.DockIcon;
	import flash.desktop.Icon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenuItem;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	public class IconMenu extends NativeMenuPlus {
		[Inject]
		public var toolController:ToolController;
		
		public function IconMenu() {
		}
		
		public function setup():void {
			var modifier:uint;
			
			if (ApplicationUtil.mac) {
				(NativeApplication.nativeApplication.icon as DockIcon).menu = this;
				
				data = 
					<menu>
						<item name="newRuler" label="New Ruler" />
						<separator />
						<item name="closeTool" label="Close Tool" />
					</menu>;
			} else {
				var icon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				
				icon.bitmaps = [new Assets.ICON_16X16()];
				icon.menu = this;
				
				data = 
					<menu>
						<item name="newRuler" keyEquivalentModifiers="control" keyEquivalent="r" label="New Ruler" />
						<separator />
						<item name="closeTool" keyEquivalentModifiers="control" keyEquivalent="w" label="Close Tool" />
					</menu>;
			}
			
			//add listeners
			itemSelectSignal.add(iconMenuItemSelectHandler);
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function iconMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			switch (item.name) {
				case "aboutDwarf":
					navigateToURL(new URLRequest("http://github.com/destroytoday/Dwarf"));
					break;
				case "newRuler":
					toolController.addRuler();
					break;
				case "closeTool":
					toolController.removeCurrentTool();
					break;
			}
		}
	}
}