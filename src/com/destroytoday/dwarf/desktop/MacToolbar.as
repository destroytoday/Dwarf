package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.models.ToolModel;
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
		[Inject]
		public var toolController:ToolController;
		
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
					<item name="closeTool" keyEquivalentModifiers="command" keyEquivalent="w" label="Close Tool" />
				</menu>;
			
			fileItem.submenu = fileMenu;
			
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
			applicationMenu.itemSelectSignal.add(applicationMenuItemSelectHandler);
			fileMenu.itemSelectSignal.add(fileMenuItemSelectHandler);
			windowMenu.itemSelectSignal.add(windowMenuItemSelectHandler);
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
					toolController.addRuler();
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