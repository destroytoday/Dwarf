package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The AddRulerSignal class dispatches when a ruler is added, executing the AddRulerCommand.
	 * @author Jonnie Hallman
	 */	
	public class AddRulerSignal extends Signal {
		/**
		 * Constructs the AddRulerSignal instance.
		 */		
		public function AddRulerSignal() {
			super(RulerView);
		}
	}
}