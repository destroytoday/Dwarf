package com.destroytoday.dwarf.assets {
	import flash.display.Bitmap;
	import flash.text.StyleSheet;

	/**
	 * The Assets class handles all embedded assets.
	 * @author Jonnie Hallman
	 */	
	public class Assets {
		/**
		 * @private
		 * Embeds Interstate Regular.
		 * Use a different font if you don't own it. 
		 */		
		[Embed(source="fonts.swf", fontName="Interstate-Regular")]
		protected static const _INTERSTATE_REGULAR_FONT:String;
		
		/**
		 * Interstate Regular
		 */		
		public static const INTERSTATE_REGULAR_FONT:String = "Interstate-Regular";
		
		/**
		 * The system tray icon (PC only) 
		 */		
		[Embed(source="icons/32.png", mimeType="image/png")]
		public static const ICON_32X32:Class;
		
		/**
		 * The application updater icon
		 */		
		[Embed(source="icons/48.png", mimeType="image/png")]
		public static const ICON_48X48:Class;
		
		/**
		 * @private 
		 */		
		protected static var styleSheet:StyleSheet;
		
		/**
		 * @private
		 */		
		public function Assets() {
			throw Error("The Assets class cannot be instantiated.");
		}
		
		public static function getStyleSheet():StyleSheet {
			if (!styleSheet) {
				styleSheet = new StyleSheet();
				
				styleSheet.setStyle("h1", {fontSize: 18, color: Color.WHITE_HTML});
				styleSheet.setStyle("a:link", {color: Color.BLUE_HTML});
				styleSheet.setStyle("a:hover", {color: Color.BLUE_OVER_HTML});
				styleSheet.setStyle(".error", {color: Color.RED_HTML});
			}
			
			return styleSheet;
		}
	}
}