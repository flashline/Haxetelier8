
package apix.ui;
import apix.common.util.Global;
import apix.common.util.Object;
import apix.common.display.Common;
//using
using apix.common.util.StringExtender;
//
#if (js)
	import js.html.Element;
	using apix.common.display.ElementExtender;
	typedef Elem = Element;
#elseif flash
	import flash.display.Sprite;
	using apix.common.display.SpriteExtender;
	typedef Elem = Sprite;
#end
//
typedef CompoSkin = { public var skinName : String; public var skinContent : String ; public var skinPath : String ; } ;
typedef CompoProp = { 
	?into:String,
	?skin:String,
	?id:String,
	?auto:Bool
	
	/*
	 * TODO
	,
	?x:Float,
	?y:Float,
	?height:Float,
	?width:Float
	*/
} 
//
class UICompo {  
	static public inline var APIX_PRFX :String = "apix_" ;
	static public inline var BAR_CLASS :String = UICompo.APIX_PRFX+"bar" ;
	static public inline var SELECTOR_CLASS :String = UICompo.APIX_PRFX+"selector" ;
	static public inline var BOUNDS_CLASS :String = UICompo.APIX_PRFX+"bounds" ;	
	//
	public var element(default,null):Elem;
	public var id(get,null):String;
	public var skin(get,null):String;
	public var auto(get,null):Bool;
	public var into(get,set):String;
	public var ctnr(get, null):Elem;
	public var compoSkinList:Array<CompoSkin> ;
	//
	//
	var g:Global ;
	var compoProp:Object ;
	var enabled:Bool;
	
	/**
	* constructor
	*/
	public function new () {
		g = Global.get();
		compoProp = new Object();
		compoProp.skin = "default";	
		compoProp.auto = true;	
		enabled = false;
	}	
	public function create () :UICompo {
		element = Common.createElem(); 
		if (id == "") element.id  = Common.newSingleId; 
		else element.id = id;
		element.inner(getCompoSkins(skin).skinContent);
		into.get().appendChild(element); 
		return this;
	}
	public function attach (el:Elem) :UICompo {	
		element = el;
		if (g.strVal(element.id) == "")  element.id = Common.newSingleId; 
		return this;
	}
	// generally, has to be override by subclass !! ");
	public function enable () :UICompo {	
		trace("f:: UICompo.set_into() must be override by subclass !! ");	
		enabled = true;	
		return this;
	}
	public function isCreated () : Bool { 
		return (element != null && g.strVal(element.id)!="" );
	}
	public function isAttached () : Bool {	
		return (ctnr != null) ;
	}		
	public function isEnabled() : Bool {	
		return (enabled) ;
	}		
	public function isInitialized () : Bool{	
		return (getCompoSkins(skin) != null && ctnr != null) ;
	}		
	function getCompoSkins (v:String) :CompoSkin {	
		var ret = null;
		for (o in compoSkinList) {			
			if (o.skinName == v) {
				ret = o; break;
			}
		}
		return ret ;
	}	
	/**
	 * private 
	 */
	function setCompoProp (?p:Dynamic) {	
		var o:Object = new Object(p); 
		if (!o.empty()) {
			o.forEach(	function (k, v, i) {
							compoProp.set(k, v);
						}
			);	
		}	
		if (isCreated() && compoProp.id != id)  element.id = compoProp.id;
	}
	function get_skin () :String {
		return g.strVal(compoProp.skin);
	}	
	function get_id () :String {
		var v;
		if (isCreated()) v = element.id ;
		else v=g.strVal(compoProp.id);
		return v;
	}
	function get_ctnr () :Elem {
		if (isCreated()) return element.parent() ;
		else if (g.strVal(into) != "") return into.get() ;  
		else return null;
			
	}
	function set_into (v:String) :String {
		trace("f:: UICompo.set_into() must be override by subclass !! ");
		return v;
	}	
	function get_into () :String {
		return compoProp.into;
	}	
	function get_auto () :Bool {		
		return g.boolVal(compoProp.auto);
	}	
	//
	//
	//
	/**
	 * public static
	 */
	public static function loadInit (f:Dynamic)  {
		UICompoLoader.__loadInit(f);
	}
	
}
//
//
//
//
//
//
//
//
class UICompoLoader    { 
	//	
	static inline var DEFAULT_SKIN_PATH:String = "apix/default/" ;
	static inline var SKIN_FILE:String = "skin." + Common.DESC_EXT ;
	static inline var TMP_CTNR_ID:String = "apix_tmp_ctnr" ;	
	static inline var TMP_IMG_URL_PREFIX:String = "././././" ;
	static var __stk:Array<Dynamic> = new Array() ;
	static var __callBack:Dynamic ;	
	static 			var __tmpSkinName:String  ;
	static 			var __tmpFromPath:String  ;	
	//
	static public var baseUrl:String = "./" ;
	/**
	 * public static
	 */
	static public function __loadInit (f:Dynamic)  {
		UICompoLoader.__callBack = f;
		var tmp = Common.createElem();
		tmp.id = UICompoLoader.TMP_CTNR_ID;
		Common.body.appendChild(tmp);
		UICompoLoader.__loadNext();
	}	
	/**
	 * private static
	 */
	static function __push (f:Dynamic, url:String,skinName:String)  {
		UICompoLoader.__stk.push({f: f,url:url,skinName:skinName}) ;
	}
	static function __loadNext ()  {		
		if (UICompoLoader.__stk.length>0) {
			var o = UICompoLoader.__stk.pop() ;
			o.f(o.url,o.skinName);		
		}
		else {
			Common.body.removeChild(("#"+UICompoLoader.TMP_CTNR_ID).get());			
			UICompoLoader.__callBack();
		}
	}
	static function __onEndLoad ()  {		
		UICompoLoader.__loadNext();	
	}
	static function __storeData (result:String) : String {
	#if (js)
		var tmpCtnr = Common.getElem(UICompoLoader.TMP_CTNR_ID);
		result = Global.get().strReplace(result, UICompoLoader.TMP_IMG_URL_PREFIX, UICompoLoader.__tmpFromPath ) ; //here no abstact ok
		tmpCtnr.inner(result);				//here no abstact ok
		var tmpStyleEl = tmpCtnr.getElementsByTagName("style")[0]; //here no abstact ok
		var styleContent = tmpStyleEl.textContent ; 
		tmpCtnr.removeChild(tmpStyleEl);
		var styleElArr = Common.getElemsByTagName("style"); //here no abstact ok
		if (styleElArr.length == 0) {
			tmpStyleEl.textContent = styleContent ;
			Common.head.appendChild(tmpStyleEl); //here no abstact ok
		} else {
			var styleEl = styleElArr[0]; //here no abstact ok
			styleEl.textContent+=styleContent;		
		}
		var el:Elem = (untyped tmpCtnr.getElementsByClassName("apix_loader_ctnr")[0]) ; //here no abstact ok
		var skinContent=el.inner(); //here no abstact ok
		tmpCtnr.inner("");	//here no abstact ok	
		return skinContent ;	
	#else
		// TODO
	#end
	}
	
}
