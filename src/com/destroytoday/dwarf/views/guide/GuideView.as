package com.destroytoday.dwarf.views.guide {
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.constants.OrientationType;
	import com.destroytoday.dwarf.views.base.ToolView;
	
	import flash.display.NativeWindowResize;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The GuideView class represents the guide tool and extends the ToolView class.
	 * @author Jonnie Hallman
	 */	
	public class GuideView extends ToolView {
		/**
		 * The guide's platform, consisting of both its line and invisible drag area. 
		 */		
		public var platform:GuidePlatform;
		
		/**
		 * @private 
		 */		
		protected var _orientationChangeSignal:Signal = new Signal(GuideView, String);
		
		/**
		 * Constructs the GuideWindow instance.
		 */		
		public function GuideView() {
			super();
			
			// instantiate components
			platform = addChild(new GuidePlatform()) as GuidePlatform;
			
			platform.doubleClickEnabled = true;
			
			// set the default size
			_window.title = "Guide";
			_window.minSize = new Point(0.0, 11.0);
			_window.maxSize = new Point(Number.MAX_VALUE, 11.0);

			// add listeners
			_window.addEventListener(NativeWindowBoundsEvent.MOVING, windowMovingHandler, false, 0, true);
			platform.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			
			_window.maximize();
		}
		
		public function get orientationChangeSignal():Signal {
			return _orientationChangeSignal;
		}
		
		/**
		 * @inerhitDoc
		 */		
		override public function set color(value:uint):void {
			platform.color = value;
			
			super.color = value;
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function set alpha(value:Number):void {
			super.alpha = value;
			
			// set to super's value, so it can use the confined value
			platform.alpha = super.alpha;
		}
		
		public function get orientation():String {
			return platform.orientation;
		}
		
		public function set orientation(value:String):void {
			if (value == OrientationType.VERTICAL && orientation == OrientationType.HORIZONTAL) {
				var x:Number = _window.x + int(_window.width * 0.5);
				
				_window.minSize = new Point(11.0, 0.0);
				_window.maxSize = new Point(11.0, Number.MAX_VALUE);
			} else if (value == OrientationType.HORIZONTAL && orientation == OrientationType.VERTICAL) {
				var y:Number = _window.y + int(_window.height * 0.5);
				
				_window.minSize = new Point(0.0, 11.0);
				_window.maxSize = new Point(Number.MAX_VALUE, 11.0);
			}
			
			_window.maximize();

			platform.orientation = value;

			_orientationChangeSignal.dispatch(this, value);
		}
		
		override protected function keyDownHandler(event:KeyboardEvent):void {
			if (orientation == OrientationType.HORIZONTAL && (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.RIGHT) ||
				orientation == OrientationType.VERTICAL && (event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)) {
				return;
			}
			
			super.keyDownHandler(event);
		}
		
		protected function windowMovingHandler(event:NativeWindowBoundsEvent):void {
			event.preventDefault();

			if (orientation == OrientationType.VERTICAL) {
				_window.x = event.afterBounds.x;
			} else if (orientation == OrientationType.HORIZONTAL) {
				_window.y = event.afterBounds.y;
			}
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