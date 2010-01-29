package com.destroytoday.dwarf.util {
	import com.destroytoday.dwarf.constants.ToolType;
	import com.destroytoday.dwarf.views.base.ToolView;
	import com.destroytoday.dwarf.views.guide.GuideView;
	import com.destroytoday.dwarf.views.ruler.RulerView;

	public class ToolUtil {
		public function ToolUtil() {
			throw Error("The TootUtil class cannot be instantiated.");
		}
		
		public static function getToolClass(type:String):Class {
			switch (type) {
				case ToolType.RULER:
					return RulerView;
				case ToolType.GUIDE:
					return GuideView;
			}
			
			return null;
		}
		
		public static function getToolType(tool:ToolView):String {
			if (tool is RulerView) {
				return ToolType.RULER;
			} else if (tool is GuideView) {
				return ToolType.GUIDE;
			}
			
			return null;
		}
	}
}