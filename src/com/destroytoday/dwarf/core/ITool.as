package com.destroytoday.dwarf.core {
	import flash.display.NativeWindow;
	
	import org.osflash.signals.Signal;

	public interface ITool {
		function get color():uint;
		function set color(value:uint):void;
		
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		function get colorChangeSignal():Signal;
		function get alphaChangeSignal():Signal;
		
		function get window():NativeWindow;
		
		function open():void;
		function close():void;
		function maximize():void;
		function minimize():void;
	}
}