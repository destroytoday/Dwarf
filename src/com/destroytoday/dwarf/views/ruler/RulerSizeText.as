package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.text.TextFieldPlus;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * The RulerSizeText indicates the ruler's width or height.
	 * @author Jonnie Hallman
	 */	
	public class RulerSizeText extends Group {
		/**
		 * The TextField that displays the size. 
		 */		
		public var textfield:TextFieldPlus;
		
		/**
		 * @private 
		 */		
		protected var _size:Number = 0.0;
		
		/**
		 * Constructs the RulerSizeText instance.
		 */		
		public function RulerSizeText() {
			// instantiate components
			textfield = addChild(new TextFieldPlus()) as TextFieldPlus;
			
			// set components' properties
			textfield.embedFonts = true;
			textfield.defaultTextFormat = new TextFormat(Assets.INTERSTATE_REGULAR_FONT, 11, Color.WHITE);
			textfield.selectable = false;
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.antiAliasType = AntiAliasType.ADVANCED;
			textfield.thickness = -100.0;

			// set instance's properties
			measureChildren = false;
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		/**
		 * The size in pixels to indicate.
		 * @return 
		 */		
		public function get size():Number {
			return _size;
		}
		
		/**
		 * @private
		 * @param value
		 */		
		public function set size(value:Number):void {
			_size = value;
			
			textfield.text = value + "px";
			
			// center text
			textfield.x = -Math.round(textfield.width * 0.5);
			textfield.y = -Math.round(textfield.height * 0.5);
		}
	}
}