package com.destroytoday.dwarf.mediators.base {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.base.ToolView;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.ApplicationUtil;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Jonnie Hallman
	 */	
	public class ToolMediator extends Mediator {
		/**
		 * @private 
		 */		
		[Inject]
		public var toolController:ToolController;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var toolModel:ToolModel;
		
		/**
		 * Constructs the ToolMediator instance.
		 */		
		public function ToolMediator() {
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function onRegister():void {
			eventMap.mapListener(tool.stage.nativeWindow, Event.ACTIVATE, windowFocusHandler);
			eventMap.mapListener(tool.stage.nativeWindow, Event.CLOSE, windowCloseHandler);
			eventMap.mapListener(tool.stage, MouseEvent.CONTEXT_MENU, contextMenuHandler, MouseEvent);
			if (ApplicationUtil.pc) eventMap.mapListener(tool.stage, KeyboardEvent.KEY_UP, keyUpHandler, KeyboardEvent);
			
			tool.colorChangeSignal.add(colorChangeHandler);
			tool.alphaChangeSignal.add(alphaChangeHandler);
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function onRemove():void {
			tool.colorChangeSignal.removeAll();
			tool.alphaChangeSignal.removeAll();
		}
		
		/**
		 * @private
		 * @return 
		 */		
		protected function get tool():ToolView {
			// MUST be overriden
			return null;
		}
		
		protected function get menu():NativeMenuPlus {
			// MUST be overriden
			return null;
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function windowFocusHandler(event:Event):void {
			toolModel.currentTool = tool;
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function windowCloseHandler(event:Event):void {
			mediatorMap.removeMediator(this);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function contextMenuHandler(event:MouseEvent):void {
			event.preventDefault();

			menu.display(tool.stage, event.stageX, event.stageY);
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function keyUpHandler(event:KeyboardEvent):void {
			if (!event.controlKey) return;

			switch (event.keyCode) {
				case Keyboard.X:
					if (!event.altKey && !event.shiftKey) toolController.cutTool();
					break;
				case Keyboard.C:
					if (!event.altKey && !event.shiftKey) toolController.copyTool();
					break;
				case Keyboard.V:
					if (!event.altKey && !event.shiftKey) toolController.pasteTool();
					break;
				case Keyboard.M:
					if (event.altKey && !event.shiftKey) tool.maximize(); else if (!event.altKey && !event.shiftKey) tool.minimize();
					break;
			}
		}
		
		/**
		 * @private 
		 * @param ruler
		 * @param color
		 */		
		protected function colorChangeHandler(tool:ToolView, color:uint):void {
			toolModel.toolColor = color;
		}
		
		/**
		 * @private 
		 * @param ruler
		 * @param alpha
		 */		
		protected function alphaChangeHandler(tool:ToolView, alpha:Number):void {
			toolModel.toolAlpha = alpha;
		}
	}
}