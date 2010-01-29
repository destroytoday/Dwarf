package com.destroytoday.dwarf.mediators {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.desktop.GuideMenu;
	import com.destroytoday.dwarf.desktop.RulerMenu;
	import com.destroytoday.dwarf.mediators.base.ToolMediator;
	import com.destroytoday.dwarf.views.base.ToolView;
	import com.destroytoday.dwarf.views.guide.GuideView;
	import com.destroytoday.dwarf.views.ruler.RulerView;

	/**
	 * The GuideMediator.
	 * @author Jonnie Hallman
	 */	
	public class GuideMediator extends ToolMediator {
		/**
		 * @private 
		 */		
		[Inject]
		public var guideMenu:GuideMenu;
		
		/**
		 * @private 
		 */		
		[Inject]
		public var view:GuideView;
		
		/**
		 * Constructs the RulerMediator instance.
		 */		
		public function GuideMediator() {
		}
		
		override public function onRegister():void {
			super.onRegister();
			
			view.orientationChangeSignal.add(orientationChangeHandler);
		}
		
		/**
		 * @private
		 * @return 
		 */		
		override protected function get tool():ToolView {
			return view;
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override protected function get menu():NativeMenuPlus {
			return guideMenu;
		}
		
		/**
		 * @private 
		 * @param tool
		 * @param color
		 */		
		protected function orientationChangeHandler(guide:GuideView, orientation:String):void {
			toolModel.toolOrientation = orientation;
		}
	}
}