package com.destroytoday.dwarf.desktop {
	import com.destroytoday.desktop.NativeMenuPlus;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.dwarf.models.ToolModel;
	import com.destroytoday.dwarf.views.ruler.RulerView;
	import com.destroytoday.util.NumberUtil;
	
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
					<item name="480x360" label="480x360" />
					<item name="720x480" label="720x480" />
					<item name="1280x720" label="1280x720" />
					<item name="1920x1080" label="1920x1080" />
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
			var ruler:RulerView = toolModel.currentTool as RulerView;
			
			var m:uint = 5;
			
			for (var i:uint = 0; i < m; ++i) {
				getItemByName(String(20 + i * 20)).checked = int(ruler.alpha * 100.0) == 20 + i * 20
			}
			
			for each(var color:String in Color.names) {
				getItemByName(color).checked = ruler.color == Color[color.toUpperCase()];
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
				case "480x360":
					ruler.stage.nativeWindow.width = 480.0;
					ruler.stage.nativeWindow.height = 360.0;
					break;
				case "720x480":
					ruler.stage.nativeWindow.width = 720.0;
					ruler.stage.nativeWindow.height = 480.0;
					break;
				case "1280x720":
					ruler.stage.nativeWindow.width = 1280.0;
					ruler.stage.nativeWindow.height = 720.0;
					break;
				case "1920x1080":
					ruler.stage.nativeWindow.width = 1920.0;
					ruler.stage.nativeWindow.height = 1080.0;
					break;
				default:
					if (item.name == String(int(item.name))) {
						ruler.alpha = int(item.name) * 0.01;
					} else {
						ruler.fadeColorTo(Color[item.name.toUpperCase()], 0.25);
					}
			}
		}
	}
}