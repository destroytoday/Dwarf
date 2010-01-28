package com.destroytoday.dwarf.mediators {
	import com.destroytoday.dwarf.controllers.ToolController;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.dwarf.views.toolbar.ToolbarView;
	import com.destroytoday.util.WindowUtil;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ToolbarMediator extends Mediator {
		[Inject]
		public var toolController:ToolController;
		
		[Inject]
		public var view:ToolbarView;
		
		public function ToolbarMediator() {
		}
		
		override public function onRegister():void {
			eventMap.mapListener(view.applicationButton, MouseEvent.CLICK, applicationButtonClickHandler, MouseEvent);
			eventMap.mapListener(view.rulerButton, MouseEvent.CLICK, rulerButtonClickHandler, MouseEvent);
			eventMap.mapListener(view.quitButton, MouseEvent.CLICK, quitButtonClickHandler, MouseEvent);
		}
		
		protected function applicationButtonClickHandler(event:MouseEvent):void {
			navigateToURL(new URLRequest("http://github.com/destroytoday/Dwarf"));
		}
		
		protected function rulerButtonClickHandler(event:MouseEvent):void {
			toolController.addTool(RulerView);
		}
		
		protected function quitButtonClickHandler(event:MouseEvent):void {
			WindowUtil.closeAll(true);
		}
	}
}