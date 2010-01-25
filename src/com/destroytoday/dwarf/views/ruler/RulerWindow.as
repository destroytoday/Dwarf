package com.destroytoday.dwarf.views.ruler {
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.ui.Keyboard;
	
	/**
	 * The RulerWindow is the base class of the ruler tool.
	 * @author Jonnie Hallman
	 */	
	public class RulerWindow extends NativeWindow {
		/**
		 * The ruler's visual content. 
		 */		
		public var content:RulerContentView;
		
		/**
		 * Constructs the RulerWindow instance.
		 */		
		public function RulerWindow() {
			// set NativeWindow properties
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			
			options.systemChrome = NativeWindowSystemChrome.NONE;
			options.transparent = true;
			
			super(options);
			
			// instantiate components
			content = stage.addChild(new RulerContentView()) as RulerContentView;
			
			// set instance properties
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			width = 400.0;
			height = 300.0;
			
			// open window
			activate();
			
			// must be called after opening the window
			alwaysInFront = true;

			// add listeners
			addEventListener(Event.ACTIVATE, activateHandler);
			addEventListener(Event.DEACTIVATE, deactivateHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function activateHandler(event:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		/**
		 * @private
		 * @param event
		 */		
		protected function deactivateHandler(event:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function keyDownHandler(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					if (event.controlKey) {
						width -= (event.shiftKey) ? 10.0 : 1.0;
					} else {
						x -= (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.RIGHT:
					if (event.controlKey) {
						width += (event.shiftKey) ? 10.0 : 1.0;
					} else {
						x += (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.UP:
					if (event.controlKey) {
						height -= (event.shiftKey) ? 10.0 : 1.0;
					} else {
						y -= (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.DOWN:
					if (event.controlKey) {
						width += (event.shiftKey) ? 10.0 : 1.0;
					} else {
						y += (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
			}
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function mouseDownHandler(event:MouseEvent):void {
			var resizeType:String;

			// top left
			if (event.stageX <= 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP_LEFT;
				
			// top
			} else if (event.stageX > 10.0 && event.stageX < width - 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP;
				
			// top right
			} else if (event.stageX >= width - 10.0 && event.stageY <= 10.0) {
				resizeType = NativeWindowResize.TOP_RIGHT;
				
			// left
			} else if (event.stageX <= 10.0 && event.stageY > 10.0 && event.stageY < height - 10.0) {
				resizeType = NativeWindowResize.LEFT;
				
			// center
			} else if (event.stageX > 10.0 && event.stageX < width - 10.0 && event.stageY > 10.0 && event.stageY < height - 10.0) {
				startMove();
				
			// right
			} else if (event.stageX >= width - 10.0 && event.stageY > 10.0 && event.stageY < height - 10.0) {
				resizeType = NativeWindowResize.RIGHT;
				
			// bottom left
			} else if (event.stageX <= 10.0 && event.stageY > height - 10.0) {
				resizeType = NativeWindowResize.BOTTOM_LEFT;
				
			// bottom
			} else if (event.stageX > 10.0 && event.stageX < width - 10.0 && event.stageY > height - 10.0) {
				resizeType = NativeWindowResize.BOTTOM;
				
			// bottom right
			} else if (event.stageX >= width - 10.0 && event.stageY >= 10.0) {
				resizeType = NativeWindowResize.BOTTOM_RIGHT;
			}
			
			if (resizeType) {
				startResize(resizeType);
			}
		}
	}
}