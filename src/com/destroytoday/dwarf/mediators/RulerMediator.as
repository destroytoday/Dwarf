package com.destroytoday.dwarf.mediators {
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * The RUlesMediator sets the ToolModel's current tool when focused.
	 * @author Jonnie Hallman
	 */	
	public class RulerMediator extends Mediator {
		[Inject]
		public var view:RulerView;
		
		[Inject]
		public var toolModel:ToolModel;
		
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
	}
}