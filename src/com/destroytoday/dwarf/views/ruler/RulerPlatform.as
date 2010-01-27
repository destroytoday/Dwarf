package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Color;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	
	/**
	 * The RulerPlatform class consists of the ruler's fill and grid.
	 * @author Jonnie Hallman
	 */	
	public class RulerPlatform extends Group {
		/**
		 * @private 
		 */		
		protected var grid:BitmapData = new BitmapData(10.0, 10.0, true, 0x00000000);
		
		/**
		 * @private 
		 */		
		protected var gridColor:uint = 0x33FFFFFF;
		
		/**
		 * @private 
		 */		
		protected var _alpha:Number = 0.8;
		
		/**
		 * @private 
		 */		
		protected var _fillColor:uint = Color.BLACK;
		
		/**
		 * Constructs the RulerPlatform instance.
		 */		
		public function RulerPlatform() {
			measureChildren = false;
			
			left = 0.0;
			top = 0.0;
			right = 0.0;
			bottom = 0.0;
			
			drawGridBitmapData();
		}
		
		/**
		 * The transparency of the Ruler.
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
			if (value < 0.2 || value > 1.0) return;
			
			_alpha = value;
			
			draw();
		}
		
		/**
		 * The color of the Ruler's platform.
		 * @return 
		 */		
		public function get fillColor():uint {
			return _fillColor;
		}
		
		/**
		 * @private
		 * @param value
		 */		
		public function set fillColor(value:uint):void {
			_fillColor = value;
			
			draw();
		}
		
		/**
		 * Draws the grid bitmap data.
		 */		
		protected function drawGridBitmapData():void {
			var m:uint = 10.0;
			
			for (var i:uint = 0; i < m; ++i) {
				grid.setPixel32(i, m - 1.0, gridColor);
				grid.setPixel32(m - 1.0, i, gridColor);
			}
		}
		
		/**
		 * @private
		 */		
		override protected function updateBounds():void {
			super.updateBounds();

			draw();
		}
		
		/**
		 * Draws the fill and grid.
		 */		
		public function draw():void {
			graphics.clear();
			
			// draw the edge fill
			graphics.beginFill(fillColor, _alpha);
			graphics.moveTo(0.0, 0.0);
			graphics.lineTo(width, 0.0);
			graphics.lineTo(width, 20.0);
			graphics.lineTo(20.0, 20.0);
			graphics.lineTo(20.0, height);
			graphics.lineTo(0.0, height);
			graphics.endFill();
			
			// draw the body fill
			graphics.beginFill(fillColor, _alpha * 0.625);
			graphics.drawRect(20.0, 20.0, width, height);
			graphics.endFill();
			
			// draw the grid
			graphics.beginBitmapFill(grid);
			graphics.lineStyle();
			graphics.drawRect(0.0, 0.0, width, height);
			graphics.endFill();
		}
	}
}