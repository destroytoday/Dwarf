package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddToolSignal;
	import com.destroytoday.dwarf.signals.RemoveToolSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.ApplicationUtil;
	import com.destroytoday.util.WindowUtil;
	
	import flash.desktop.DockIcon;
	import flash.desktop.Icon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenuItem;
	import flash.events.ScreenMouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	public class IconMenu extends NativeMenuPlus {
		/**
		 * @private 
		 */	
		[Inject]
		public var addToolSignal:AddToolSignal;
		
		/**
		 * @private 
		 */	
		[Inject]
		public var removeToolSignal:RemoveToolSignal;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var toolController:ToolController;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var toolModel:ToolModel;
		
		public function IconMenu() {
		}
		
		/**
		 * Builds the menu.
		 */		
		public function setup():void {
			var modifier:uint;
			
			if (ApplicationUtil.mac) {
				(NativeApplication.nativeApplication.icon as DockIcon).menu = this;
				
				data = 
					<menu>
						<item name="newRuler" label="New Ruler" />
						<separator />
						<item name="closeTool" label="Close Tool" enabled="false" />
					</menu>;
			} else {
				var icon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				
				icon.bitmaps = [new Assets.ICON_32X32()];
				icon.menu = this;
				
				data = 
					<menu>
						<item name="newRuler" label="New Ruler" />
						<separator />
						<item name="closeTool" label="Close Tool" enabled="false" />
						<item name="quit" label="Quit" />
					</menu>;
				
				icon.addEventListener(ScreenMouseEvent.CLICK, iconClickHandler, false, 0, true);
			}
			
			//add listeners
			addToolSignal.add(addToolHandler);
			removeToolSignal.add(removeToolHandler);
			itemSelectSignal.add(iconMenuItemSelectHandler);
		}
		
		/**
		 * @private
		 * @param tool
		 */		
		protected function addToolHandler(tool:ITool):void {
			getItemByName("closeTool").enabled = true;
		}
		
		/**
		 * @private 
		 * @param tool
		 */		
		protected function removeToolHandler(tool:ITool):void {
			if (toolModel.tools.length == 0) {
				getItemByName("closeTool").enabled = false;
			}
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
					toolController.addTool(RulerView);
					break;
				case "closeTool":
					toolController.removeCurrentTool();
					break;
				case "quit":
					WindowUtil.closeAll(true);
					break;
			}
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function iconClickHandler(event:ScreenMouseEvent):void {
			if (toolModel.currentTool.window) {
				NativeApplication.nativeApplication.activate(toolModel.currentTool.window);
			} else {
				NativeApplication.nativeApplication.activate(NativeApplication.nativeApplication.openedWindows[0]);
			}
		}
	}
}