package com.destroytoday.dwarf.views.ruler {
	import com.destroytoday.display.Group;
	import com.destroytoday.text.TextFieldPlus;
	
	import flash.display.NativeWindowResize;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.Keyboard;
	
	/**
	 * The RulerContentView class consists of the ruler's visual components.
	 * @author Jonnie Hallman
	 */	
	public class RulerContentView extends Group {
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
		 * Constructs the RulerContentView instance.
		 */		
		public function RulerContentView() {
			// instantiate the components
			platform = addChild(new RulerPlatform()) as RulerPlatform;
			widthText = addChild(new RulerSizeText()) as RulerSizeText;
			heightText = addChild(new RulerSizeText()) as RulerSizeText;
			
			// set the components' properties
			widthText.center = 10.0;
			widthText.y = 10.0;
			heightText.rotation = -90.0;
			heightText.middle = 10.0;
			heightText.x = 10.0;
			platform.doubleClickEnabled = true;
			
			// set the instance's properties
			measureChildren = false;
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