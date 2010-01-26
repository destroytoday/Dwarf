package {
	import com.destroytoday.dwarf.contexts.ApplicationContext;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * The Dwarf class is the application class.
	 * @author Jonnie Hallman
	 */	
	public class Dwarf extends Sprite {
		/**
		 * The context of the application. 
		 */		
		public var context:ApplicationContext;
		
		/**
		 * Constructs the Dwarf instance.
		 */		
		public function Dwarf() {
			context = new ApplicationContext(this);
			
			stage.frameRate = 50.0; //TODO - integrate framerate throttler
		}
	}
}