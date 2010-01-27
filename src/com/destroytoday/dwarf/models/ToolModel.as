package com.destroytoday.dwarf.models {
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.filesystem.CacheObject;
	
	import flash.display.NativeWindow;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * The ToolModel class keeps track of the tools being used.
	 * @author Jonnie Hallman
	 */	
	public class ToolModel extends Actor {
		/**
		 * @private 
		 */		
		protected var _tools:Vector.<ITool> = new Vector.<ITool>();
		
		/**
		 * @private 
		 */		
		protected var cache:CacheObject = new CacheObject("tools");
		
		/**
		 * @private 
		 */		
		protected var _currentTool:ITool;
		
		/**
		 * Constructs the ToolModel instance.
		 */		
		public function ToolModel() {
		}
		
		/**
		 * Returns an array of the currently-used tools.
		 * @return 
		 */		
		public function get tools():Vector.<ITool> {
			return _tools;
		}
		
		/**
		 * The currently-focused tool.
		 * @return 
		 */		
		public function get currentTool():ITool {
			return _currentTool;
		}
		
		/**
		 * @private 
		 * @param tool
		 */		
		public function set currentTool(tool:ITool):void {
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
		 * Adds the provided tool.
		 * @param tool the tool to add
		 */		
		public function addTool(tool:ITool):ITool {
			if (_tools.indexOf(tool) > -1) return null;
			
			_tools[_tools.length] = tool;
			
			tool.color = toolColor;
			tool.alpha = toolAlpha;
			
			return tool;
		}
		
		/**
		 * Removes the provided tool. 
		 * @param tool the tool to remove
		 * @return the tool
		 */		
		public function removeTool(tool:ITool):ITool {
			var index:int = _tools.indexOf(tool);

			if (index == -1) return null;
			
			if (_currentTool == tool) _currentTool = null;
			
			_tools.splice(index, 1);
			
			return tool;
		}
	}
}