package com.destroytoday.dwarf.views.toolbar {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.text.TextFieldPlus;
	
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.osmf.display.ScaleMode;
	
	public class TextButton extends Group {
		public var textfield:TextFieldPlus;
		
		protected var _maxWidth:Number = Number.MAX_VALUE;
		
		protected var _fillColor:uint = Color.GREY_3;
		
		public function TextButton() {
			textfield = addChild(new TextFieldPlus()) as TextFieldPlus;
			
			textfield.embedFonts = true;
			textfield.defaultTextFormat = new TextFormat(Assets.INTERSTATE_REGULAR_FONT, 11, Color.GREY_C3C6C8);
			textfield.selectable = false;
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.antiAliasType = AntiAliasType.ADVANCED;

			textfield.x = 4.0;
			textfield.y = 5.0;
			
			measureChildren = false;
			buttonMode = true;
			mouseChildren = false;
			
			height = 25.0;
			
			draw();
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		public function get maxWidth():Number {
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
			
			width = Math.min(_maxWidth, width);
			
			draw();
		}
		
		public function get text():String {
			return textfield.text;
		}
		
		public function set text(value:String):void {
			textfield.text = value;
			
			width = Math.min(_maxWidth, Math.round(textfield.width + 9.0));
			
			draw();
		}
		
		public function get fillColor():uint {
			return _fillColor;
		}
		
		public function set fillColor(value:uint):void {
			_fillColor = value;
			
			draw();
		}
		
		public function draw():void {
			graphics.clear();
			graphics.beginFill(fillColor);
			graphics.drawRect(0.0, 0.0, width, height);
			graphics.endFill();
			graphics.lineStyle(0.0, Color.GREY_2, 1.0, false, ScaleMode.NONE, CapsStyle.SQUARE);
			graphics.moveTo(0.0, 0.0);
			graphics.lineTo(0.0, height - 1.0);
			graphics.moveTo(width - 1.0, 0.0);
			graphics.lineTo(width - 1.0, height - 1.0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void {
			fillColor = Color.GREY_42;
		}
		
		protected function mouseOutHandler(event:MouseEvent):void {
			fillColor = Color.GREY_3;
		}
	}
}