package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.contexts.ApplicationContext;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddRulerSignal;
	import com.destroytoday.dwarf.signals.AddToolSignal;
	import com.destroytoday.dwarf.signals.RemoveToolSignal;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.ApplicationUtil;
	import com.destroytoday.util.WindowUtil;
	import com.google.analytics.GATracker;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * The ToolController class adds and removes tools.
	 * @author Jonnie Hallman
	 */	
	public class ToolController extends Actor {
		/**
		 * @private 
		 */		
		[Inject]
		public var tracker:GATracker;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var model:ToolModel;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var addToolSignal:AddToolSignal;
		
		/**
		 * @private 
		 */	
		[Inject]
		public var removeToolSignal:RemoveToolSignal;
		
		/**
		 * @private 
		 */	
		[Inject]
		public var addRulerSignal:AddRulerSignal;
		
		/**
		 * Constructs the ToolController instance.
		 */		
		public function ToolController() {
		}
		
		/**
		 * Adds a tool of the provided class.
		 * @param type the class type to add
		 */		
		public function addTool(type:Class):void {
			tracker.trackEvent("Tools", "Add tool", String(type));
			
			var tool:ITool = new type();
			
			switch (type) {
				case RulerView:
					addRulerSignal.dispatch(tool);
					break;
			}

			tool.open();
			model.addTool(tool);
			addToolSignal.dispatch(tool);
		}
		
		/**
		 * Removes the provided tool.
		 * @param tool the tool to remove
		 */		
		public function removeTool(tool:ITool):void {
			tool.close();
			model.removeTool(tool);
			removeToolSignal.dispatch(tool);
		}
		
		/**
		 * Removes the current tool, as indicated by the ToolModel.
		 */		
		public function removeCurrentTool():void {
			if (model.currentTool) {
				removeTool(model.currentTool);
			}
		}
	}
}