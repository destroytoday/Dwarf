package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.display.Group;
	
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
		protected var fillColor:uint = 0x007998;
		
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
			graphics.beginFill(fillColor, 0.8);
			graphics.moveTo(0.0, 0.0);
			graphics.lineTo(width, 0.0);
			graphics.lineTo(width, 20.0);
			graphics.lineTo(20.0, 20.0);
			graphics.lineTo(20.0, height);
			graphics.lineTo(0.0, height);
			graphics.endFill();
			
			// draw the body fill
			graphics.beginFill(fillColor, 0.5);
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