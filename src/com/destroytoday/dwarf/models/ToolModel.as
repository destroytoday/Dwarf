package com.destroytoday.dwarf.models {
	import com.destroytoday.dwarf.constants.OrientationType;
	import com.destroytoday.dwarf.views.base.ToolView;
	import com.destroytoday.filesystem.CacheObject;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * The ToolModel class keeps track of the tools being used.
	 * @author Jonnie Hallman
	 */	
	public class ToolModel extends Actor {
		/**
		 * @private 
		 */		
		protected var _tools:Vector.<ToolView> = new Vector.<ToolView>();
		
		/**
		 * @private 
		 */		
		protected var cache:CacheObject = new CacheObject("tools");
		
		/**
		 * @private 
		 */		
		protected var _currentTool:ToolView;
		
		/**
		 * Constructs the ToolModel instance.
		 */		
		public function ToolModel() {
		}

		/**
		 * Returns an array of the currently-used tools.
		 * @return 
		 */		
		public function get tools():Vector.<ToolView> {
			return _tools;
		}
		
		/**
		 * The currently-focused tool.
		 * @return 
		 */		
		public function get currentTool():ToolView {
			return _currentTool;
		}
		
		/**
		 * @private 
		 * @param tool
		 */		
		public function set currentTool(tool:ToolView):void {
			_currentTool = tool;
		}
		
		/**
		 * The last used tool color.
		 * @return 
		 */		
		public function get toolColor():uint {
			return uint(cache.getProperty("toolColor"));
		}
		
		/**
		 * @private 
		 * @param value
		 */		
		public function set toolColor(value:uint):void {
			cache.setProperty("toolColor", value);
		}
		
		/**
		 * The last used tool alpha.
		 * @return 
		 */		
		public function get toolAlpha():Number {
			return Number(cache.getProperty("toolAlpha"));
		}
		
		/**
		 * @private 
		 * @param value
		 */		
		public function set toolAlpha(value:Number):void {
			cache.setProperty("toolAlpha", value);
		}
		
		/**
		 * The last used tool orientation.
		 * @return 
		 */		
		public function get toolOrientation():String {
			var orientation:String = String(cache.getProperty("toolOrientation"));
			
			if (orientation != OrientationType.HORIZONTAL || orientation != OrientationType.VERTICAL) {
				toolOrientation = orientation = OrientationType.HORIZONTAL;
			}

			return orientation;
		}
		
		/**
		 * @private 
		 * @param value
		 */		
		public function set toolOrientation(value:String):void {
			cache.setProperty("toolOrientation", value);
		}
		
		/**
		 * Adds the provided tool.
		 * @param tool the tool to add
		 */		
		public function addTool(tool:ToolView):ToolView {
			if (_tools.indexOf(tool) > -1) return null;
			
			_tools[_tools.length] = tool;
			
			tool.color = toolColor;
			tool.alpha = toolAlpha;
			if (tool.hasOwnProperty("orientation")) tool['orientation'] = toolOrientation;
			
			return tool;
		}
		
		/**
		 * Removes the provided tool. 
		 * @param tool the tool to remove
		 * @return the tool
		 */		
		public function removeTool(tool:ToolView):ToolView {
			var index:int = _tools.indexOf(tool);

			if (index == -1) return null;
			
			if (_currentTool == tool) _currentTool = null;
			
			_tools.splice(index, 1);
			
			return tool;
		}
	}
}