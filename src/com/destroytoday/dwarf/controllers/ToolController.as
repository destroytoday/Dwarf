package com.destroytoday.dwarf.controllers {
	import com.destroytoday.dwarf.constants.RegularExpression;
	import com.destroytoday.dwarf.constants.ToolType;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.signals.AddRulerSignal;
	import com.destroytoday.dwarf.signals.AddToolSignal;
	import com.destroytoday.dwarf.signals.RemoveToolSignal;
	import com.destroytoday.dwarf.util.ToolUtil;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.google.analytics.GATracker;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.ClipboardTransferMode;
	
	import mx.utils.ObjectUtil;
	
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
		public function addTool(type:Class):ITool {
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
			
			return tool;
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
		
		public function cutTool():void {
			copyTool();
			removeCurrentTool();
		}	
		
		/**
		 * Copies to current tool's state to the clipboard.
		 */		
		public function copyTool():void {
			if (!model.currentTool) return;
			
			var type:String = ToolUtil.getToolType(model.currentTool);
			
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, "type=" + type + " x=" + model.currentTool.window.x + " y=" + model.currentTool.window.y + " width=" + model.currentTool.window.width + " height=" + model.currentTool.window.height + " color=" + model.currentTool.color + " alpha=" + model.currentTool.alpha);
		}
		
		/**
		 * Pastes the clipboard, if it's a valid tool state.
		 */		
		public function pasteTool():void {
			var match:Array;
			
			var data:String = Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT) as String;
			
			if (data && (match = data.match(RegularExpression.CLIPBOARD))) {
				model.toolColor = match[6];
				model.toolAlpha = match[7];
				
				var tool:ITool = addTool(ToolUtil.getToolClass(match[1]));
				
				tool.window.x = match[2];
				tool.window.y = match[3];
				tool.window.width = match[4];
				tool.window.height = match[5];
			}
		}
	}
}