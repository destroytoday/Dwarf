package com.destroytoday.dwarf.views.guide {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.constants.OrientationType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	
	import org.osmf.display.ScaleMode;
	
	/**
	 * The GuidePlatform class consists of the guide's fill and line.
	 * @author Jonnie Hallman
	 */	
	public class GuidePlatform extends Group {
		/**
		 * @private 
		 */		
		protected var _color:uint = Color.BLACK;
		
		/**
		 * @private 
		 */		
		protected var _alpha:Number = 0.8;
		
		/**
		 * @private 
		 */		
		protected var _orientation:String = OrientationType.HORIZONTAL;
		
		/**
		 * Constructs the GuidePlatform instance.
		 */		
		public function GuidePlatform() {
			measureChildren = false;
			
			left = 0.0;
			top = 0.0;
			right = 0.0;
			bottom = 0.0;
		}
		
		/**
		 * The transparency of the Guide.
		 * @return 
		 */		
		override public function get alpha():Number {
			return _alpha;
		}
		
		/**
		 * @private
		 * @param value
		 */		
		override public function set alpha(value:Number):void {
			_alpha = value;
			
			draw();
		}
		
		/**
		 * The color of the Guide's platform.
		 * @return 
		 */		
		public function get color():uint {
			return _color;
		}
		
		/**
		 * @private
		 * @param value
		 */		
		public function set color(value:uint):void {
			_color = value;
			
			draw();
		}
		
		/**
		 * The orientation of the Guide's platform.
		 * @return 
		 */		
		public function get orientation():String {
			return _orientation;
		}
		
		/**
		 * @private
		 * @param value
		 */		
		public function set orientation(value:String):void {
			_orientation = value;
			
			draw();
		}
		
		/**
		 * @private
		 */		
		override protected function updateBounds():void {
			super.updateBounds();

			draw();
		}
		
		/**
		 * Draws the line and fill.
		 */		
		public function draw():void {
			graphics.clear();
			
			// draw the fill
			graphics.beginFill(_color, _alpha * 0.625);
			graphics.drawRect(0.0, 0.0, width, height);
			graphics.endFill();
			
			// draw the line
			graphics.lineStyle(0.0, _color, 1.0, false, ScaleMode.NONE, CapsStyle.SQUARE);
			
			if (_orientation == OrientationType.HORIZONTAL) {
				graphics.moveTo(0.0, int(height * 0.5));
				graphics.lineTo(width, int(height * 0.5));
			} else if (_orientation == OrientationType.VERTICAL) {
				graphics.moveTo(int(width * 0.5), 0.0);
				graphics.lineTo(int(width * 0.5), height);
			}
		}
	}
}