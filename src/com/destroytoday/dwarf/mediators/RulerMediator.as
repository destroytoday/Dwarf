package com.destroytoday.dwarf.mediators {
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.desktop.RulerMenu;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * The RUlesMediator sets the ToolModel's current tool when focused.
	 * @author Jonnie Hallman
	 */	
	public class RulerMediator extends Mediator {
		[Inject]
		public var rulerMenu:RulerMenu;
		
		[Inject]
		public var toolModel:ToolModel;
		
		[Inject]
		public var view:RulerView;
		
		/**
		 * Constructs the RulerMediator instance.
		 */		
		public function RulerMediator() {
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function onRegister():void {
			eventMap.mapListener(view.stage.nativeWindow, Event.ACTIVATE, windowFocusHandler);
			eventMap.mapListener(view.stage.nativeWindow, Event.CLOSE, windowCloseHandler);
			eventMap.mapListener(view.stage, MouseEvent.CONTEXT_MENU, contextMenuHandler, MouseEvent);
			
			view.colorChangeSignal.add(colorChangeHandler);
			view.alphaChangeSignal.add(alphaChangeHandler);
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function onRemove():void {
			view.colorChangeSignal.removeAll();
			view.alphaChangeSignal.removeAll();
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function windowFocusHandler(event:Event):void {
			toolModel.currentTool = view;
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

			rulerMenu.display(view.stage, event.stageX, event.stageY);
		}
		
		/**
		 * @private 
		 * @param ruler
		 * @param color
		 */		
		protected function colorChangeHandler(ruler:RulerView, color:uint):void {
			toolModel.toolColor = color;
		}
		
		/**
		 * @private 
		 * @param ruler
		 * @param alpha
		 */		
		protected function alphaChangeHandler(ruler:RulerView, alpha:Number):void {
			toolModel.toolAlpha = alpha;
		}
	}
}