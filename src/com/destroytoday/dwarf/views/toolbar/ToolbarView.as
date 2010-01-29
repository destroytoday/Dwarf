package com.destroytoday.dwarf.views.toolbar {
	import com.destroytoday.display.Group;
	import com.destroytoday.display.GroupAlignType;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.constants.ToolbarState;
	import com.gskinner.motion.GTween;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Screen;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Rectangle;
	
	public class ToolbarView extends Group {
		public var leftGroup:Group;
		public var rightGroup:Group;
		
		public var applicationButton:TextButton;
		public var rulerButton:TextButton;
		public var guideButton:TextButton;
		public var quitButton:TextButton;
		
		protected var positionTween:GTween;
		
		protected var bounds:Rectangle;
		
		protected var _state:String = ToolbarState.NORMAL;
		
		public function ToolbarView() {
			leftGroup = addChild(new Group()) as Group;
			rightGroup = addChild(new Group()) as Group;
			
			applicationButton = leftGroup.addChild(new TextButton()) as TextButton;
			rulerButton = leftGroup.addChild(new TextButton()) as TextButton;
			guideButton = leftGroup.addChild(new TextButton()) as TextButton;
			
			quitButton = rightGroup.addChild(new TextButton()) as TextButton;
			
			applicationButton.paddingRight = 2.0;
			applicationButton.maxWidth = 27.0;
			applicationButton.text = "Dw";
			applicationButton.textfield.x = 2.0;
			applicationButton.textfield.textColor = Color.RED;
			
			rulerButton.text = "Ruler";
			guideButton.text = "Guide";
			quitButton.text = "Quit";
			
			positionTween = new GTween(this, 0.75);
			
			leftGroup.align = GroupAlignType.LEFT;
			leftGroup.gap = 1.0;
			leftGroup.measureChildren = false;
			
			rightGroup.align = GroupAlignType.RIGHT;
			rightGroup.gap = 1.0;
			rightGroup.right = 0.0;
			rightGroup.measureChildren = false;
			
			measureChildren = false;
			
			left = 0.0;
			right = 0.0;
			height = 25.0;
			
			scrollRect = bounds = new Rectangle(0.0, height, 0.0, height);
			
			positionTween.onInit = positionTweenInitHandler;
			positionTween.onComplete = positionTweenCompleteHandler;
		}
		
		override public function get y():Number {
			return (bounds) ? bounds.y : 0.0;
		}
		
		override public function set y(value:Number):void {
			if (bounds) {
				bounds.y = value;
				
				scrollRect = bounds;
			}
		}
		
		public function resize():void {
			var screen:Rectangle = Screen.mainScreen.visibleBounds;
			
			stage.nativeWindow.x = screen.x;
			stage.nativeWindow.y = screen.y;
			stage.nativeWindow.width = Screen.mainScreen.bounds.width;
			stage.nativeWindow.height = height;
		}
		
		public function get state():String {
			return _state;
		}
		
		public function set state(value:String):void {
			_state = value;
		}
		
		override protected function updateBounds():void {
			super.updateBounds();
			
			if (bounds) {
				bounds.width = width;
				
				scrollRect = bounds;
			}

			graphics.clear();
			graphics.beginFill(Color.GREY_2B);
			graphics.drawRect(0.0, 0.0, width, height);
			graphics.endFill();
		}
		
		override protected function addedToStageHandler(event:Event):void {
			super.addedToStageHandler(event);
			
			resize();
			
			if (stage.nativeWindow.active) {
				positionTween.setValue('y', 0.0);
			}

			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, applicationActivateHandler, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, applicationDeactivateHandler, false, 0, true);
		}
		
		protected function applicationActivateHandler(event:Event):void {
			positionTween.setValue('y', 0.0);
		}
		
		protected function applicationDeactivateHandler(event:Event):void {
			positionTween.setValue('y', height);
		}
		
		protected function positionTweenInitHandler(tween:GTween):void {
			if (y == height) {
				stage.nativeWindow.visible = true;
			}
		}
		
		protected function positionTweenCompleteHandler(tween:GTween):void {
			if (y == height) {
				stage.nativeWindow.visible = false;
			}
		}
	}
}