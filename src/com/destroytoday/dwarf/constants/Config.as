package com.destroytoday.dwarf.constants {
	public class Config {
		public static const APPLICATION_UPDATER_URL:String = "http://destroytoday.com/dwarf/update.xml";
		
		public static const GOOGLE_ANALYTICS_ACCOUNT:String = "UA-3256994-6";
		
		public function Config() {
			throw Error("The Config class cannot be instantiated.");
		}
	}
}