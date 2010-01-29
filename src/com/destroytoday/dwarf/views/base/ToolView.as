package com.destroytoday.dwarf.views.base {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.util.ColorUtil;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Quadratic;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The ToolView class represents base class for all tools.
	 * @author Jonnie Hallman
	 */	
	public class ToolView extends Group {
		/**
		 * @private 
		 */		
		protected var _window:NativeWindow;
		
		/**
		 * @private 
		 */		
		protected var colorTween:GTween;
		
		/**
		 * @private 
		 */		
		protected var _colorChangeSignal:Signal = new Signal(ToolView, uint);
		
		/**
		 * @private 
		 */		
		protected var _alphaChangeSignal:Signal = new Signal(ToolView, Number);
		
		/**
		 * @private
		 */		
		protected var _maximized:Boolean;
		
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
		protected var colorFade:Number;
		
		/**
		 * @private
		 */		
		protected var colorFadeStart:uint;
		
		/**
		 * @private 
		 */		
		protected var colorFadeEnd:uint;
		
		/**
		 * Constructs the ToolView instance.
		 */		
		public function ToolView() {
			// set NativeWindow properties
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			
			windowOptions.systemChrome = NativeWindowSystemChrome.NONE;
			windowOptions.transparent = true;
			
			_window = new NativeWindow(windowOptions);
			
			colorTween = new GTween(null, 0.5, null, {ease: Quadratic.easeInOut, autoPlay: false});
			
			window.stage.addChild(this);
			
			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			window.stage.align = StageAlign.TOP_LEFT;
			
			measureChildren = false;
			
			// add listeners
			window.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
			window.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
			window.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			
			colorTween.onChange = colorFadeChangeHandler;
		}
		
		/**
		 * Opens the tool.
		 */		
		public function open():void {
			// open window
			stage.nativeWindow.activate();
			
			// must be called after opening the window
			stage.nativeWindow.alwaysInFront = true;
		}
		
		/**
		 * Closes the tool.
		 */		
		public function close():void {
			stage.nativeWindow.close();
		}
		
		/**
		 * Maximizes the tool. If it's already maximized, restore it.
		 */		
		public function maximize():void {
			if (_maximized) {
				stage.nativeWindow.restore();
			} else {
				stage.nativeWindow.maximize();
			}
			
			_maximized = !_maximized;
		}
		
		/**
		 * Minimizes the tool.
		 */		
		public function minimize():void {
			_maximized = false;
			
			stage.nativeWindow.minimize();
		}
		
		/**
		 * Fades the tool's color to the provided color.
		 * @param color the color to fade to
		 */		
		public function fadeColorTo(color:uint, delay:Number = 0.0):void {
			colorFade = 0.0;
			colorFadeStart = this.color;
			colorFadeEnd = color;
			colorTween.delay = 0.0;
			colorTween.setValue("colorFade", 1);
			colorTween.paused = false;
			colorTween.delay = delay;
		}
		
		/**
		 * Returns the tool's native window.
		 * @return 
		 */		
		public function get window():NativeWindow {
			return _window;
		}
		
		/**
		 * The color of the tool.
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
			
			_colorChangeSignal.dispatch(this, _color);
		}
		
		/**
		 * @inheritDoc
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
			
			_alphaChangeSignal.dispatch(this, _alpha);
		}
		
		/**
		 * The Signal that dispatches when the tool's color changes.
		 * @return 
		 */		
		public function get colorChangeSignal():Signal {
			return _colorChangeSignal;
		}
		
		/**
		 * The Signal that dispatches when the tool's alpha changes.
		 * @return 
		 */		
		public function get alphaChangeSignal():Signal {
			return _alphaChangeSignal;
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function activateHandler(event:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function deactivateHandler(event:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		/**
		 * @private 
		 * @param tween
		 */		
		protected function colorFadeChangeHandler(tween:GTween):void {
			color = ColorUtil.getColorBetween(colorFadeStart, colorFadeEnd, tween.ratio);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function keyDownHandler(event:KeyboardEvent):void {
			if (!event.altKey && !event.controlKey) {
				switch (event.keyCode) {
					case Keyboard.LEFT:
						_maximized = false;
						
						stage.nativeWindow.x -= (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.RIGHT:
						_maximized = false;
						
						stage.nativeWindow.x += (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.UP:
						_maximized = false;
						
						stage.nativeWindow.y -= (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.DOWN:
						_maximized = false;
	
						stage.nativeWindow.y += (event.shiftKey) ? 10.0 : 1.0;
						break;
					case Keyboard.LEFTBRACKET:
						alpha = (event.shiftKey) ? 0.2 : alpha - 0.2;
						break;
					case Keyboard.RIGHTBRACKET:
						alpha = (event.shiftKey) ? 1.0 : alpha + 0.2;
						break;
				}
			}
		}
		
		/**
		 * @private 
		 * @param event
		 */		
		protected function keyUpHandler(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.R:
				case Keyboard.O:
				case Keyboard.Y:
				case Keyboard.G:
				case Keyboard.B:
				case Keyboard.K:
				case Keyboard.W:
					fadeColorTo(ColorUtil.getColorByKey(event.keyCode));
					break;
			}
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function mouseDownHandler(event:MouseEvent):void {
			_maximized = false;

			stage.nativeWindow.startMove();
		}
		
		/**
		 * @private
		 * @param event
		 */		
		override protected function addedToStageHandler(event:Event):void {
			super.addedToStageHandler(event);
			
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, windowResizeHandler);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function windowResizeHandler(event:NativeWindowBoundsEvent):void {
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
	}
}