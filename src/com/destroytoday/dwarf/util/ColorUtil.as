package com.destroytoday.dwarf.util {
	import com.destroytoday.dwarf.assets.Color;
	
	import flash.ui.Keyboard;

	public class ColorUtil {
		public function ColorUtil() {
			throw Error("The ColorUtil class cannot be instantiated.");
		}
		
		public static function getColorBetween(colorStart:uint, colorEnd:uint, position:Number = .5):uint {
			var red:uint, green:uint, blue:uint;
			
			red = ((colorStart >> 16) * (1 - position)) + ((colorEnd >> 16) * position);
			green = (((colorStart >> 8) & 0xFF) * (1 - position)) + (((colorEnd >> 8) & 0xFF) * position);
			blue = ((colorStart & 0xFF) * (1 - position)) + ((colorEnd & 0xFF) * position);
			
			return (red << 16 | green << 8 | blue);
		}
		
		public static function getColorByKey(keyCode:uint):uint {
			switch (keyCode) {
				case Keyboard.R:
					return Color.RED;
				case Keyboard.O:
					return Color.ORANGE;
				case Keyboard.Y:
					return Color.YELLOW;
				case Keyboard.G:
					return Color.GREEN;
				case Keyboard.B:
					return Color.BLUE;
				case Keyboard.K:
					return Color.BLACK;
				case Keyboard.W:
					return Color.WHITE;
			}
			
			return null;
		}
	}
}