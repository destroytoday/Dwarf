package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.core.ITool;
	
	import org.osflash.signals.Signal;
	
	public class RemoveToolSignal extends Signal {
		public function RemoveToolSignal() {
			super(ITool);
		}
	}
}