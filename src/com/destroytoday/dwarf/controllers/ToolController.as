package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.contexts.ApplicationContext;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddRulerSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.WindowUtil;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * The ToolController class adds and removes tools.
	 * @author Jonnie Hallman
	 */	
	public class ToolController extends Actor {
		[Inject]
		public var model:ToolModel;
		
		[Inject]
		public var addRulerSignal:AddRulerSignal;
		
		/**
		 * Constructs the ToolController instance.
		 */		
		public function ToolController() {
		}
		
		/**
		 * Adds a ruler.
		 */		
		public function addRuler():void {
			var ruler:RulerView = new RulerView();
			
			addRulerSignal.dispatch(ruler);
			
			ruler.open();
			
			model.addTool(ruler);
		}
		
		/**
		 * Removes the provided ruler.
		 * @param ruler
		 */		
		public function removeRuler(ruler:RulerView):void {
			ruler.close();
			model.removeTool(ruler);
		}
		
		/**
		 * Removes the current tool, as indicated by the ToolModel.
		 */		
		public function removeCurrentTool():void {
			var tool:ITool = model.removeTool(model.currentTool);
			
			if (tool) tool.close();
		}
	}
}