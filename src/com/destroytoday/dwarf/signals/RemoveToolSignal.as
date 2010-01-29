package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.views.base.ToolView;
	
	import org.osflash.signals.Signal;
	
	public class RemoveToolSignal extends Signal {
		public function RemoveToolSignal() {
			super(ToolView);
		}
	}
}