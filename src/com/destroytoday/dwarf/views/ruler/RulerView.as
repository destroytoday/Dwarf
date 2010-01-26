package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.core.ITool;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.ui.Keyboard;
	
	/**
	 * The Ruler class represents the ruler tool and implements the ITool interface.
	 * @author Jonnie Hallman
	 */	
	public class RulerView extends Group implements ITool {
		
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
			// set NativeWindow properties
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			
			windowOptions.systemChrome = NativeWindowSystemChrome.NONE;
			windowOptions.transparent = true;
			
			var window:NativeWindow = new NativeWindow(windowOptions);
			
			// instantiate components
			platform = addChild(new RulerPlatform()) as RulerPlatform;
			widthText = addChild(new RulerSizeText()) as RulerSizeText;
			heightText = addChild(new RulerSizeText()) as RulerSizeText;
			
			window.stage.addChild(this);
			
			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			window.stage.align = StageAlign.TOP_LEFT;
			
			widthText.center = 10.0;
			widthText.y = 10.0;
			heightText.rotation = -90.0;
			heightText.middle = 10.0;
			heightText.x = 10.0;
			platform.doubleClickEnabled = true;
			measureChildren = false;
			
			// set the default size
			window.title = "Ruler";
			window.width = 400.0;
			window.height = 300.0;
			
			// add listeners
			window.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
			window.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
			window.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
		}
		
		/**
		 * Opens the ruler.
		 */		
		public function open():void {
			// open window
			stage.nativeWindow.activate();
			
			// must be called after opening the window
			stage.nativeWindow.alwaysInFront = true;
		}
		
		/**
		 * Closes the ruler.
		 */		
		public function close():void {
			stage.nativeWindow.close();
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function activateHandler(event:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
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
						stage.nativeWindow.width -= (event.shiftKey) ? 10.0 : 1.0;
					} else {
						stage.nativeWindow.x -= (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.RIGHT:
					if (event.controlKey) {
						stage.nativeWindow.width += (event.shiftKey) ? 10.0 : 1.0;
					} else {
						stage.nativeWindow.x += (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.UP:
					if (event.controlKey) {
						stage.nativeWindow.height -= (event.shiftKey) ? 10.0 : 1.0;
					} else {
						stage.nativeWindow.y -= (event.shiftKey) ? 10.0 : 1.0;
					}
					break;
				case Keyboard.DOWN:
					if (event.controlKey) {
						stage.nativeWindow.width += (event.shiftKey) ? 10.0 : 1.0;
					} else {
						stage.nativeWindow.y += (event.shiftKey) ? 10.0 : 1.0;
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
		override protected function addedToStageHandler(event:Event):void {
			super.addedToStageHandler(event);
			
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, windowResizeHandler);
			platform.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function windowResizeHandler(event:NativeWindowBoundsEvent):void {
			width = stage.stageWidth;
			height = stage.stageHeight;
			
			widthText.size = width;
			heightText.size = height;
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function doubleClickHandler(event:MouseEvent):void {
			stage.nativeWindow.minimize();	
		}
	}
}