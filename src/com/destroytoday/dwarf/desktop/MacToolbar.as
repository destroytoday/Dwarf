package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddToolSignal;
	import com.destroytoday.dwarf.signals.RemoveToolSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.ApplicationUtil;
	import com.destroytoday.util.WindowUtil;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenuItem;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * The Toolbar class represents the desktop toolbar on Mac.
	 * @author Jonnie Hallman
	 */	
	public class MacToolbar {
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
		
		/**
		 * The Application menu item. 
		 */		
		public var applicationItem:NativeMenuItem;
		
		/**
		 * The Application menu. 
		 */		
		public var applicationMenu:NativeMenuPlus;
		
		/**
		 * The File menu item. 
		 */		
		public var fileItem:NativeMenuItem;
		
		/**
		 * The File menu. 
		 */		
		public var fileMenu:NativeMenuPlus;
		
		/**
		 * The Edit menu item. 
		 */		
		public var editItem:NativeMenuItem;
		
		/**
		 * The Edit menu. 
		 */		
		public var editMenu:NativeMenuPlus;
		
		/**
		 * The Window menu item. 
		 */		
		public var windowItem:NativeMenuItem;
		
		/**
		 * The Window menu. 
		 */		
		public var windowMenu:NativeMenuPlus;
		
		/**
		 * Constructs the Toolbar instance.
		 */		
		public function MacToolbar() {
		}
		
		/**
		 * Builds the menus and wires their signals.
		 */		
		public function setup():void {
			//
			// Dwarf Item / Menu
			//
			applicationItem = NativeApplication.nativeApplication.menu.getItemAt(0);
			applicationMenu = new NativeMenuPlus();
			
			applicationMenu.data = 
				<menu>
					<item name="aboutDwarf" label="About Dwarf" />
					<separator />
					<!--<item name="preferences" keyEquivalentModifiers="command" keyEquivalent="," label="Preferences..." />
					<separator />-->
					<item name="quit" keyEquivalentModifiers="command" keyEquivalent="q" label="Quit" />
				</menu>;
			
			applicationItem.submenu = applicationMenu;
			
			//
			// File Item / Menu
			//
			fileItem = NativeApplication.nativeApplication.menu.getItemAt(1);
			fileMenu = new NativeMenuPlus();
			
			fileMenu.data = 
				<menu>
					<item name="newRuler" keyEquivalentModifiers="command" keyEquivalent="r" label="New Ruler" />
					<separator />
					<item name="closeTool" keyEquivalentModifiers="command" keyEquivalent="w" label="Close Tool" enabled="false" />
				</menu>;
			
			fileItem.submenu = fileMenu;
			
			//
			// Edit Item / Menu
			//
			editItem = NativeApplication.nativeApplication.menu.getItemAt(2);
			editMenu = new NativeMenuPlus();
			
			editMenu.data = 
				<menu>
					<item name="cut" keyEquivalentModifiers="command" keyEquivalent="x" label="Cut" enabled="false" />
					<item name="copy" keyEquivalentModifiers="command" keyEquivalent="c" label="Copy" enabled="false" />
					<item name="paste" keyEquivalentModifiers="command" keyEquivalent="v" label="Paste" />
				</menu>;
			
			editItem.submenu = editMenu;
			
			//
			// Window Item / Menu
			//
			windowItem = NativeApplication.nativeApplication.menu.getItemAt(3);
			windowMenu = new NativeMenuPlus();
			
			windowMenu.data = 
				<menu>
					<item name="maximizeWindow" keyEquivalentModifiers="command" keyEquivalent="M" label="Maximize" />
					<item name="minimizeWindow" keyEquivalentModifiers="command" keyEquivalent="m" label="Minimize" />				
				</menu>;
			
			windowItem.submenu = windowMenu;
			
			//add listeners
			addToolSignal.add(addToolHandler);
			removeToolSignal.add(removeToolHandler);
			applicationMenu.itemSelectSignal.add(applicationMenuItemSelectHandler);
			fileMenu.itemSelectSignal.add(fileMenuItemSelectHandler);
			editMenu.itemSelectSignal.add(editMenuItemSelectHandler);
			windowMenu.itemSelectSignal.add(windowMenuItemSelectHandler);
		}
		
		/**
		 * @private
		 * @param tool
		 */		
		protected function addToolHandler(tool:ITool):void {
			fileMenu.getItemByName("closeTool").enabled = true;
			editMenu.getItemByName("cut").enabled = true;
			editMenu.getItemByName("copy").enabled = true;
			windowMenu.getItemByName("maximizeWindow").enabled = true;
			windowMenu.getItemByName("minimizeWindow").enabled = true;
		}
		
		/**
		 * @private 
		 * @param tool
		 */		
		protected function removeToolHandler(tool:ITool):void {
			if (toolModel.tools.length == 0) {
				fileMenu.getItemByName("closeTool").enabled = false;
				editMenu.getItemByName("cut").enabled = false;
				editMenu.getItemByName("copy").enabled = false;
				windowMenu.getItemByName("maximizeWindow").enabled = false;
				windowMenu.getItemByName("minimizeWindow").enabled = false;
			}
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function applicationMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			switch (item.name) {
				case "aboutDwarf":
					navigateToURL(new URLRequest("http://github.com/destroytoday/Dwarf"));
					break;
				case "preferences":
					break;
				case "quit":
					WindowUtil.closeAll(true);
					break;
			}
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function fileMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			switch (item.name) {
				case "newRuler":
					toolController.addTool(RulerView);
					break;
				case "closeTool":
					toolController.removeCurrentTool();
					break;
			}
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function editMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			switch (item.name) {
				case "cut":
					toolController.cutTool();
					break;
				case "copy":
					toolController.copyTool();
					break;
				case "paste":
					toolController.pasteTool();
					break;
			}
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function windowMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			if (!toolModel.currentTool) return;
			
			switch (item.name) {
				case "maximizeWindow":
					toolModel.currentTool.maximize();
					break;
				case "minimizeWindow":
					toolModel.currentTool.minimize();
					break;
			}
		}
	}
}