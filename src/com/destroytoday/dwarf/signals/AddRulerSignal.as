package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import org.osflash.signals.Signal;
	
	public class AddRulerSignal extends Signal {
		public function AddRulerSignal() {
			super(RulerView);
		}
	}
}