package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.core.ITool;
	
	import org.osflash.signals.Signal;
	
	public class AddToolSignal extends Signal {
		public function AddToolSignal() {
			super(ITool);
		}
	}
}