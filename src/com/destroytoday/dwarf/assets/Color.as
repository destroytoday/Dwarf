package com.destroytoday.dwarf.assets {
	public class Color {
		// interface colors
		public static const GREY_2:uint = 0x222222;
		public static const GREY_2B:uint = 0x2B2B2B;
		public static const GREY_3:uint = 0x333333;
		public static const GREY_42:uint = 0x424242;
		public static const GREY_A:uint = 0xAAAAAA;
		public static const GREY_C3C6C8:uint = 0xC3C6C8;
		
		// stylesheet colors
		public static const WHITE_HTML:String = "#FFFFFF";
		public static const BLUE_HTML:String = "#007998";
		public static const BLUE_OVER_HTML:String = "#3CAEAF";
		public static const RED_HTML:String = "#CA3430";
		
		// tool colors
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