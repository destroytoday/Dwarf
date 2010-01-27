package com.destroytoday.dwarf.assets {
	import flash.display.Bitmap;

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
		
		[Embed(source="icons/16.png", mimeType="image/png")]
		public static const ICON_16X16:Class;
		
		/**
		 * @private
		 */		
		public function Assets() {
			throw Error("The Assets class cannot be instantiated.");
		}
	}
}