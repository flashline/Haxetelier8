package apix.ui.progressBar;
//
import apix.common.event.StandardEvent;
import apix.common.event.EventSource;
import apix.common.event.timing.Clock;
import apix.common.util.Global;
import apix.common.display.Common;
import apix.ui.UICompo.UICompoLoader;
//
import apix.ui.UICompo.CompoProp;
import apix.ui.UICompo;
import haxe.Http; 
//using
using apix.common.util.StringExtender;
using apix.common.util.ArrayExtender;
#if (js || cock)
	import js.Browser;
	import js.html.Element;
	using apix.common.display.ElementExtender;
	typedef Elem = Element;
#elseif flash
	import flash.display.Sprite;
	using apix.common.display.SpriteExtender;
	typedef Elem = Sprite;
#end



typedef ProgressBarProp = { 
	> CompoProp	,
} 
//
class ProgressBar extends UICompo    {  
	var pnum:Int;
	var clk:Clock;
	/**
	* constructor
	* @param ?p ProgressBarProp
	*/
	public function new (?p:ProgressBarProp) {
		super(); 
		
		compoSkinList = ProgressBarLoader.__compoSkinList;
		setup(p);	
		pnum = 0;
	}
	/**
	 * update ProgressBarProp
	 * @param ?p ProgressBarProp
	 * @return this
	 */
	public function setup (?p:ProgressBarProp) :ProgressBar {	
		setCompoProp(p);
		if (isInitialized()) {
			if (!isCreated()) create();
			if (auto && !enabled ) enable();
		}
		return this;
	}
	/**
	 * active ProgressBar when it is not auto.
	 * @return this
	 */
	override public function enable ()  :ProgressBar {
		enabled = true;	
		clk = new Clock(onClock);
		return this ;
	}
	/**
	 * private  
	 */
	function onClock (c:Clock)  {	
		pnum++;
		if (pnum == 100) {
			clk.stop();
		}
		else {			
			var bar:Elem = ("#" + id + " ." + UICompo.BAR_CLASS).get(element);
			bar.width(pnum * 2);
		}
		
	}
	//
	override function set_into (v:String) :String {
		setup( { into:v } );
		return v;
	}
	
	//
	//
	//
	/**
	 * static public  
	 */
	/**
	 * load a skin.
	 * use it for each used skin ; compos can have same or its own skin.
	 * @param	?skinName="default" skinname
	 * @param	?pathStr skin's path from UICompoLoader.baseUrl
	 */
	public static function init (?skinName = "default", ?pathStr:String)  {
		ProgressBarLoader.__init(skinName,pathStr);
	}	
}
//
//
/**
 * static class to loadinit ProgressBar
 */
class ProgressBarLoader extends UICompoLoader   { 
	static  inline 	var PATH:String = "ProgressBar/" ;	
	//
	static public	var __compoSkinList:Array<CompoSkin> = new Array() ;
	/*
	static 			var __tmpSkinName:String  ;
	static 			var __tmpFromPath:String  ;	
	*/
	//
	/**
	 * public static 
	 */
	static public function __init (?skinName = "default", ?pathStr:String)  {
		pathStr != null && skinName == "default" ? trace("f::Invalid skinName '" + skinName + "' when a custom path is given ! ") : true ;
		pathStr= pathStr==null ? UICompoLoader.DEFAULT_SKIN_PATH + ProgressBarLoader.PATH : pathStr ; 
		UICompoLoader.__push( ProgressBarLoader.__load,UICompoLoader.baseUrl+pathStr,skinName) ;
	}
	/**
	 * private static
	 */
	static function __load (fromPath:String,sk:String)  {
		var h:Http = new Http(fromPath + UICompoLoader.SKIN_FILE);
		h.onData = __onData;	
		h.request(false);
		UICompoLoader.__tmpSkinName = sk;
		UICompoLoader.__tmpFromPath = fromPath;	
	}	
	static function __onData (result:String)  {
		var skinContent=UICompoLoader.__storeData(result);		
		//
		ProgressBarLoader.__compoSkinList.push({skinName:UICompoLoader.__tmpSkinName,skinContent:skinContent,skinPath:UICompoLoader.__tmpFromPath}); 		
		UICompoLoader.__onEndLoad();		
	}
	
}
