package com.destroytoday.dwarf.constants {
	public class RegularExpression {
		public static const CLIPBOARD:RegExp = /^type=(\w+) x=(\-?\d+) y=(\-?\d+) width=(\d+) height=(\d+) color=(\d+) alpha=([\d\.]+)$/
		
		public function RegularExpression() {
			throw Error("The RegularExpression class cannot be instantiated.");
		}
	}
}