package {
	import com.destroytoday.display.Group;
	import com.destroytoday.dwarf.contexts.ApplicationContext;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.dwarf.views.toolbar.ToolbarView;
	import com.gskinner.motion.GTween;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import mx.effects.easing.Quartic;
	
	[SWF(backgroundColor="#222222")]
	
	/**
	 * The Dwarf class is the application class.
	 * @author Jonnie Hallman
	 */	
	public class Dwarf extends Group {
		/**
		 * The context of the application. 
		 */		
		public var context:ApplicationContext;
		
		/**
		 * The toolbar for managing tools. 
		 */		
		public var toolbarView:ToolbarView;
		
		/**
		 * Constructs the Dwarf instance.
		 */		
		public function Dwarf() {
			GTween.defaultEase = Quartic.easeInOut;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.nativeWindow.minSize = new Point(0, 0);
			stage.frameRate = 50.0; //TODO - integrate framerate throttler
			
			context = new ApplicationContext(this);
			
			toolbarView = addChild(new ToolbarView()) as ToolbarView;
			
			measureChildren = false;
			
			left = 0.0;
			top = 0.0;
			right = 0.0;
			bottom = 0.0;
			
			updateListeners();
			stage.nativeWindow.activate();
		}
	}
}