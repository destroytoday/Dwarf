package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.constants.OrientationType;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.guide.GuideView;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import flash.display.NativeMenuItem;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class GuideMenu extends NativeMenuPlus {
		[Inject]
		public var toolModel:ToolModel;
		
		public function GuideMenu() {
			setup();
		}
		
		public function setup():void {
			data = 
				<menu>
					<item name="horizontal" label="Horizontal" />
					<item name="vertical" label="Vertical" />
					<separator />
					<item name="red" label="Red" />
					<item name="orange" label="Orange" />
					<item name="yellow" label="Yellow" />
					<item name="green" label="Green" />
					<item name="blue" label="Blue" />
					<item name="black" label="Black" />
					<separator />
					<item name="100" label="100%" />
					<item name="80" label="80%" />
					<item name="60" label="60%" />
					<item name="40" label="40%" />
					<item name="20" label="20%" />
				</menu>;
		}
		
		override public function display(stage:Stage, stageX:Number, stageY:Number):void {
			var guide:GuideView = toolModel.currentTool as GuideView;
			
			var m:uint = 5;
			
			for (var i:uint = 0; i < m; ++i) {
				getItemByName(String(20 + i * 20)).checked = int(guide.alpha * 100.0) == 20 + i * 20
			}
			
			for each(var color:String in Color.names) {
				getItemByName(color).checked = guide.color == Color[color.toUpperCase()];
			}
			
			super.display(stage, stageX, stageY);
		}
		
		override protected function itemSelectHandler(event:Event):void {
			var item:NativeMenuItem = event.currentTarget as NativeMenuItem;
			
			switch(item.name) {
				case OrientationType.HORIZONTAL:
					(toolModel.currentTool as GuideView).orientation = OrientationType.HORIZONTAL;
					break;
				case OrientationType.VERTICAL:
					(toolModel.currentTool as GuideView).orientation = OrientationType.VERTICAL;
					break;
				default:
					if (item.name == String(int(item.name))) {
						toolModel.currentTool.alpha = int(item.name) * 0.01;
					} else {
						toolModel.currentTool.fadeColorTo(Color[item.name.toUpperCase()], 0.25);
					}
			}
		}
	}
}