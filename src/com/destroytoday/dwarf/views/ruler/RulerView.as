package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.views.base.ToolView;
	
	import flash.display.NativeWindowResize;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.ui.Keyboard;
	
	/**
	 * The RulerView class represents the ruler tool and extends the ToolView class.
	 * @author Jonnie Hallman
	 */	
	public class RulerView extends ToolView {
		/**
		 * The text indicating the ruler's width.
		 */		
		public var widthText:RulerSizeText;
		
		/**
		 * The text indicating the ruler's height.
		 */		
		public var heightText:RulerSizeText;
		
		/**
		 * The ruler's platform, consisting of both its fill and grid. 
		 */		
		public var platform:RulerPlatform;
		
		
		/**
		 * Constructs the RulerWindow instance.
		 */		
		public function RulerView() {
			super();
			
			// instantiate components
			platform = addChild(new RulerPlatform()) as RulerPlatform;
			widthText = addChild(new RulerSizeText()) as RulerSizeText;
			heightText = addChild(new RulerSizeText()) as RulerSizeText;
			
			widthText.center = 10.0;
			widthText.y = 10.0;
			heightText.rotation = -90.0;
			heightText.middle = 10.0;
			heightText.x = 10.0;
			platform.doubleClickEnabled = true;
			
			// set the default size
			_window.title = "Ruler";
			_window.width = 400.0;
			_window.height = 300.0;
			
			// add listeners
			platform.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		/**
		 * @inerhitDoc
		 */		
		override public function set color(value:uint):void {
			if (value == Color.WHITE) {
				widthText.textfield.textColor = Color.BLACK;
				heightText.textfield.textColor = Color.BLACK;
			} else {
				widthText.textfield.textColor = Color.WHITE;
				heightText.textfield.textColor = Color.WHITE;
			}
			
			platform.fillColor = value;
			
			super.color = value;
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function set alpha(value:Number):void {
			super.alpha = value;
			
			// set to super's value, so it can use the confined value
			platform.alpha = super.alpha
		}
		
		/**
		 * @private
		 * @param event
		 */		
		override protected function keyDownHandler(event:KeyboardEvent):void {
			super.keyDownHandler(event);
			
			if (event.controlKey && !event.altKey) {
				switch (event.keyCode) {
					case Keyboard.LEFT:
						_maximized = false;
						stage.nativeWindow.width -= (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.RIGHT:
						_maximized = false;
						stage.nativeWindow.width += (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.UP:
						_maximized = false;
						stage.nativeWindow.height -= (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.DOWN:
						_maximized = false;
						stage.nativeWindow.height += (event.shiftKey) ? 10.0 : 1.0;
						break;
				}
			}
		}
		
		/**
		 * @private
		 * @param event
		 */		
		override protected function mouseDownHandler(event:MouseEvent):void {
			var resizeType:String;
			
			_maximized = false;

			// top left
			if (event.stageX <= 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP_LEFT;
				
			// top
			} else if (event.stageX > 10.0 && event.stageX < stage.nativeWindow.width - 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP;
				
			// top right
			} else if (event.stageX >= stage.nativeWindow.width - 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP_RIGHT;
				
			// left
			} else if (event.stageX <= 10.0 && event.stageY > 10.0 && event.stageY < stage.nativeWindow.height - 10.0) {
				resizeType = NativeWindowResize.LEFT;
				
			// center
			} else if (event.stageX > 10.0 && event.stageX < stage.nativeWindow.width - 10.0 && event.stageY > 10.0 && event.stageY < stage.nativeWindow.height - 10.0) {
				stage.nativeWindow.startMove();
				
			// right
			} else if (event.stageX >= stage.nativeWindow.width - 10.0 && event.stageY > 10.0 && event.stageY < stage.nativeWindow.height - 10.0) {
				resizeType = NativeWindowResize.RIGHT;
				
			// bottom left
			} else if (event.stageX <= 10.0 && event.stageY > stage.nativeWindow.height - 10.0) {
				resizeType = NativeWindowResize.BOTTOM_LEFT;
				
			// bottom
			} else if (event.stageX > 10.0 && event.stageX < stage.nativeWindow.width - 10.0 && event.stageY > stage.nativeWindow.height - 10.0) {
				resizeType = NativeWindowResize.BOTTOM;
				
			// bottom right
			} else if (event.stageX >= stage.nativeWindow.width - 10.0 && event.stageY >= 10.0) {
				resizeType = NativeWindowResize.BOTTOM_RIGHT;
			}
			
			if (resizeType) {
				stage.nativeWindow.startResize(resizeType);
			}
		}
		
		/**
		 * @private
		 * @param event
		 */		
		override protected function windowResizeHandler(event:NativeWindowBoundsEvent):void {
			super.windowResizeHandler(event);
			
			widthText.size = width;
			heightText.size = height;
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function doubleClickHandler(event:MouseEvent):void {
			if (event.altKey) {
				maximize();
			} else {
				minimize();
			}
		}
	}
}