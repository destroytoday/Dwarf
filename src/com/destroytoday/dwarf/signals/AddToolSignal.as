package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.views.base.ToolView;
	
	import org.osflash.signals.Signal;
	
	public class AddToolSignal extends Signal {
		public function AddToolSignal() {
			super(ToolView);
		}
	}
}