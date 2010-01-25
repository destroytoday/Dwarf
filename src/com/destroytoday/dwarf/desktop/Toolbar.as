package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenuItem;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * The Toolbar class represents the desktop toolbar on Mac.
	 * @author Jonnie Hallman
	 */	
	public class Toolbar extends Actor {
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
		 * Constructs the Toolbar instance.
		 */		
		public function Toolbar() {
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
					<item name="preferences" keyEquivalentModifiers="command" keyEquivalent="," label="Preferences..." />
					<separator />
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
			
			//add listeners
			applicationMenu.itemSelectSignal.add(applicationMenuItemSelectHandler);
			fileMenu.itemSelectSignal.add(fileMenuItemSelectHandler);
		}
		
		/**
		 * @private
		 * @param menu
		 * @param item
		 */		
		protected function applicationMenuItemSelectHandler(menu:NativeMenuPlus, item:NativeMenuItem):void {
			switch (item.name) {
				case "aboutDwarf":
					break;
				case "preferences":
					break;
				case "quit":
					NativeApplication.nativeApplication.exit();
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
					break;
				case "closeTool":
					NativeApplication.nativeApplication.activeWindow.close();
					break;
			}
		}
	}
}