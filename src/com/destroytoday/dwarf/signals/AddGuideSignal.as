package com.destroytoday.dwarf.signals {
	import com.destroytoday.dwarf.views.guide.GuideView;
	
	import org.osflash.signals.Signal;
	
	public class AddGuideSignal extends Signal {
		public function AddGuideSignal() {
			super(GuideView);
		}
	}
}