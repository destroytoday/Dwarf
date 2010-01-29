package com.destroytoday.dwarf.util {
	import com.destroytoday.dwarf.constants.ToolType;
	import com.destroytoday.dwarf.core.ITool;
	import com.destroytoday.dwarf.views.ruler.RulerView;

	public class ToolUtil {
		public function ToolUtil() {
			throw Error("The TootUtil class cannot be instantiated.");
		}
		
		public static function getToolClass(type:String):Class {
			switch (type) {
				case ToolType.RULER:
					return RulerView;
			}
			
			return null;
		}
		
		public static function getToolType(tool:ITool):String {
			if (tool is RulerView) {
				return ToolType.RULER;
			}
			
			return null;
		}
	}
}