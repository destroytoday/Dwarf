package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	
	import flash.display.NativeMenuItem;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class RulerMenu extends NativeMenuPlus {
		[Inject]
		public var toolModel:ToolModel;
		
		public function RulerMenu() {
			setup();
		}
		
		public function setup():void {
			data = 
				<menu>
					<item name="800x600" label="800x600" />
					<item name="1024x768" label="1024x768" />
					<separator />
					<item name="red" label="Red" />
					<item name="orange" label="Orange" />
					<item name="yellow" label="Yellow" />
					<item name="green" label="Green" />
					<item name="blue" label="Blue" />
					<item name="black" label="Black" />
				</menu>;
		}
		
		override public function display(stage:Stage, stageX:Number, stageY:Number):void {
			var ruler:RulerView = toolModel.currentTool as RulerView;
			
			for each(var color:String in Color.names) {
				getItemByName(color).checked = ruler.platform.fillColor == Color[color.toUpperCase()];
			}
			
			super.display(stage, stageX, stageY);
		}
		
		override protected function itemSelectHandler(event:Event):void {
			var ruler:RulerView = toolModel.currentTool as RulerView;
			var item:NativeMenuItem = event.currentTarget as NativeMenuItem;
			
			switch(item.name) {
				case "800x600":
					ruler.stage.nativeWindow.width = 800.0;
					ruler.stage.nativeWindow.height = 600.0;
					break;
				case "1024x768":
					ruler.stage.nativeWindow.width = 1024.0;
					ruler.stage.nativeWindow.height = 768.0;
					break;
				default:
					ruler.platform.fillColor = Color[item.name.toUpperCase()];
			}
		}
	}
}