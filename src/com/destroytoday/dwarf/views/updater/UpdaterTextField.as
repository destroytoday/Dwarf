package com.destroytoday.dwarf.views.updater {
	import com.destroytoday.dwarf.assets.Assets;
	import com.destroytoday.dwarf.assets.Color;
	import com.destroytoday.text.TextFieldLinkManager;
	import com.destroytoday.text.TextFieldPlus;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class UpdaterTextField extends TextFieldPlus {
		public var linkManager:TextFieldLinkManager;
		
		public function UpdaterTextField() {
			linkManager = new TextFieldLinkManager(this);
			
			embedFonts = true;
			defaultTextFormat = new TextFormat(Assets.INTERSTATE_REGULAR_FONT, 11, Color.GREY_C3C6C8, null, null, null, null, null, null, null, null, null, 4);
			styleSheet = Assets.getStyleSheet();
			multiline = true;
			wordWrap = true;
			selectable = false;
			autoSize = TextFieldAutoSize.LEFT;
			antiAliasType = AntiAliasType.ADVANCED;
			
			x = 78.0;
			y = 20.0;
			width = 280.0 - x;
		}
	}
}


