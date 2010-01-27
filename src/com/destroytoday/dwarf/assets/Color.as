package com.destroytoday.dwarf.assets {
	public class Color {
		public static const WHITE:uint = 0xFFFFFF;
		public static const BLACK:uint = 0x000000;
		public static const RED:uint = 0xCA3430;
		public static const ORANGE:uint = 0xFF8024;
		public static const YELLOW:uint = 0xFFD800;
		public static const GREEN:uint = 0x00A841;
		public static const BLUE:uint = 0x007998;
		
		public static const names:Array = ["black", "red", "orange", "yellow", "green", "blue"];
		
		public function Color() {
			throw Error("The Color class cannot be instantiated.");
		}
	}
}