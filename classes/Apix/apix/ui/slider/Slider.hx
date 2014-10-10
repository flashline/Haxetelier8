package apix.ui.slider;
//
import apix.common.tools.math.MathX;
import apix.common.event.StandardEvent;
import apix.common.event.EventSource;
import apix.common.tools.math.Rectangle;
import apix.common.tools.math.Vector;
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
#if js
	import js.html.Element;
	using apix.common.display.ElementExtender;
	typedef Elem = Element;
#else if flash
	//TO CONTINUE
	import flash.display.Sprite;	
	using apix.common.display.SpriteExtender;
	typedef Elem = Sprite;
#else 
	//TODO
#end
//
typedef Selector = { 
	/**
	 * button (selector's Element)
	 */
	public 	var elem : Elem; 
	/**
	 * numeric value between start and end
	 */
	public 	var value : Float;
	/**
	 * rounded value with 0 to n decimal(s)
	 */
	public  var round :Int -> Float;
	/**
	 * physical position between the bounds.
	 */
	public 	var pos : Float; 
	//private vars
	var xpos : Float; 
	var ypos : Float; 
	
}

typedef SliderProp = { 
	> CompoProp ,
	/**
	 * slider Element.
	 */
	?bounds:Rectangle ,
	/**
	 * numeric start value (from -n to n)
	 * default is bounds.x (or bounds.y if vertical)
	 */
	?start:Float,
	/**
	 * numeric end value(from -n to n)
	 * default is start + bounds.length 
	 */
	?end:Float,	
	/**
	 * physical scale between mouse move and selector move.
	 * default is 1 
	 */
	?mouseScale:Float,	
	/**
	 * used when there are several selectors : true if a selector can move over an other selector
	 * default is false
	 */
	?overlay:Bool,
	/**
	 * used when overlay is false : minimum space in pixel between 2 selectors
	 * default is 5 
	 */
	?gap:Int
	
} 
//
class Slider extends UICompo    {  
	/**
	 * event dispatcher when a Slider's Selector is changing.
	 */
	public var change(default,null):EventSource ;
	/**
	 * Selector array.
	 * use it when multi Selector Slider
	 */
	public var selectors(default,null):Array<Selector>;	
	/**
	 * mouse move scale.
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var mouseScale(get,null):Float;			   		
	/**
	 * geometric bounds
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var bounds(get,null):Rectangle;		// also write-enabled by setup() 	// 
	/**
	 * start value
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var start(get,null):Float;			
	/**
	 * end value
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var end(get,null):Float;				
	/**
	 * true if a selector can move over an other selector - default is false
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var overlay(get, null):Bool;		
	/**
	 * minimum space between 2 selectors
	 * read-only.
	 * use setup() to write this var ; @see SliderProp .
	 */
	public var gap(get, null):Int;		
	/**
	 * true if there are several selectors
	 * read-only.
	 */
	public var multiple(get,null):Bool;	
	/**
	 * length =  end - start ;
	 * read-only.
	 */
	public var length(get,null):Float;			
	/**
	 * true if Slider is vertical.
	 * read-only.
	 */
	public var vertical(get, null):Bool;	
	/**
	 * Selector.value of last moved Selector.
	 * read-only.
	 */
	public var value(get,null):Float;			
	/**
	 * Selector.round() of last moved Selector.
	 */
	public function round (?n:Int = 0) :Float {	return lastSelector.round(n) ;	}
	//
	var mouseScaleVector(get,null):Vector;
	var lastSelector:Selector;
	var lastSelectorIndex:Int;
	/**
	* constructor
	* @param ?p SliderProp
	*/
	public function new (?p:SliderProp) {
		super(); 
		change = new EventSource();
		selectors = new Array();
		compoSkinList = SliderLoader.__compoSkinList;
		setup(p);		
	}
	/**
	 * update SliderProp
	 * @param ?p SliderProp
	 * @return this
	 */
	public function setup (?p:SliderProp) :Slider {	
		setCompoProp(p);
		if (isInitialized()) {
			if (!isCreated()) create();
			if (auto && !enabled ) enable();
		}
		return this;
	}
	/**
	 * active slider when it is not auto.
	 * @return this
	 */
	override public function enable ()  :Slider {			
		var arr:Array<Elem>= ("#"+id+" ."+UICompo.SELECTOR_CLASS).all(element);
		if (arr.length>0) {
			for (el in arr) { 			
				selectors.push(updateSelector ( { elem:el, value:null, pos:null, xpos:el.posx(), ypos:el.posy(), round :null } ));				
				//el.on(g.isMobile?StandardEvent.TOUCH_START:StandardEvent.MOUSE_DOWN, startDrag);
				//el.on(g.isMobile?StandardEvent.TOUCH_END:StandardEvent.MOUSE_UP, stopDrag);
				el.on(StandardEvent.MOUSE_DOWN, startDrag);
				el.on(StandardEvent.MOUSE_UP, stopDrag);
			}	
			lastSelector = selectors[0];
		}
		enabled = true;	
		return this;
	}
	/**
	 * private  
	 */
	function startDrag (e) {			
		e.preventDefault();		
		var el:Elem = e.currentTarget;
		if (g.isMobile) el.doOnTouchStart();
		var o = selectors.objectOf(el,"elem");
		lastSelector=o.object;		
		lastSelectorIndex = o.index;		
		el.startDrag(getSelectorBounds(), mouseScaleVector);//
		Global.mouseClock.top.on(onClock,{elem:el});
	}
	function stopDrag (e) {
		var el:Elem = e.currentTarget;
		if (g.isMobile) el.doOnTouchEnd();
		el.stopDrag();
	}
	function onClock (e:StandardEvent) {
		var elem:Elem = e.data.elem;
		lastSelector.xpos = elem.posx(); lastSelector.ypos = elem.posy(); 
		updateSelector(lastSelector);
		e = new StandardEvent(this);
		e.currentSelector = lastSelector;
		change.dispatch(e);
	}
	//
	override function set_into (v:String) :String {
		setup( { into:v } );
		return v;
	}
	function get_mouseScale () :Float {
		if (compoProp.mouseScale == null) compoProp.mouseScale=1 ;
		return compoProp.mouseScale;
	}
	function get_bounds () :Rectangle {
		var r:Rectangle=null;
		if (compoProp.bounds != null) r = compoProp.bounds ;
		else {
			var b:Elem = ("#" + id + " ." + UICompo.BOUNDS_CLASS).get() ;
			if (b != null) r = new Rectangle(b.posx(), b.posy(), b.width(), b.height());
			else {
				if (element.width()>element.height()) 	r = new Rectangle(0, 0, element.width(), 0);
				else									r = new Rectangle(0, 0, 0,element.height());
			}
		}
		compoProp.bounds = r;
		return r;
	}
	function getSelectorBounds () :Rectangle {
		var v:Rectangle=bounds;
		if (multiple) if (!overlay) {
			var vx=0.; var vy=0.; var w=0. ; var h=0. ;
			var prev = lastSelectorIndex - 1;
			var next = lastSelectorIndex + 1;
			if (lastSelectorIndex == 0) {
				vx = bounds.x; 
				vy = bounds.y;
				w = selectors[next].xpos - vx- (!vertical?gap:0);
				h = selectors[next].ypos - vy- (vertical?gap:0);				
			}
			else if (lastSelectorIndex == selectors.length-1) {
				vx = selectors[prev].xpos+(!vertical?gap:0);
				vy = selectors[prev].ypos+(vertical?gap:0);
				w = bounds.x+bounds.width - vx;
				h = bounds.y+bounds.height - vy;				
			}
			else if (lastSelectorIndex>0 && lastSelectorIndex< selectors.length-1) {
				vx = selectors[prev].xpos+(!vertical?gap:0);
				vy = selectors[prev].ypos+(vertical?gap:0);
				w = selectors[next].xpos - vx-(!vertical?gap:0);
				h = selectors[next].ypos - vy-(vertical?gap:0);	
			}	
			else { trace("f:: Selector index error ! "); }
			
			v = new Rectangle(vx,vy,w,h);
		}
		return v;
	}
	function get_start () :Float {
		var v:Float=null;
		if (compoProp.start != null) v = compoProp.start ;
		else {
			v = (!vertical)?bounds.x:bounds.y;			
		}
		compoProp.start = v;
		return v;
	}
	function get_end () :Float {
		var v:Float=null;
		if (compoProp.end != null) v = compoProp.end ;
		else {
			v = start + bounds.length;	
		}
		compoProp.end = v;
		return v;
	}
	function get_length () :Float {
		return end-start ;
	}
	function get_overlay () :Bool {
		var v:Bool = null;
		if (multiple) {
			if (compoProp.overlay != null) v = compoProp.overlay ;
			else {
				v = false;	
			}
			compoProp.overlay = v;
		}
		return v;
	}
	function get_gap () :Int {
		var v:Int;
		if (compoProp.gap != null) v = compoProp.gap ;
		else v = 5;	
		compoProp.gap= v;		
		return v;
	}
	function get_multiple () :Bool {		
		return (selectors.length>1) ;
	}
	function get_vertical () :Bool {
		return (bounds.length==bounds.height) ;
	}
	function get_value () :Float {
		return lastSelector.value ;
	}	
	function updateSelector (o:Selector):Selector  {
		var sc = length / bounds.length ;	
		o.pos = !vertical? o.xpos :o.ypos ;
		o.value = start + (o.pos - (!vertical?bounds.x:bounds.y)) * sc;
		o.round = function (?n:Int = 0) { return MathX.round(o.value, n) ; } ;
		return o;
	}
	function get_mouseScaleVector () :Vector {
		if (mouseScaleVector == null) mouseScaleVector = new Vector(mouseScale,mouseScale);
		return mouseScaleVector ;
	}
	
	//
	//
	//
	/**
	 * static public  
	 */
	/**
	 * load a skin.
	 * use it for each used skin ; sliders can have same or its own skin.
	 * @param	?skinName="default" skinname
	 * @param	?pathStr skin's path from UICompoLoader.baseUrl
	 */
	public static function init (?skinName = "default", ?pathStr:String)  {
		SliderLoader.__init(skinName,pathStr);
	}	
}
//
//
/**
 * static class to loadinit Slider
 */
class SliderLoader extends UICompoLoader   { 
	static  inline 	var PATH:String = "Slider/" ;	
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
		pathStr= pathStr==null ? UICompoLoader.DEFAULT_SKIN_PATH + SliderLoader.PATH : pathStr ; 
		UICompoLoader.__push( SliderLoader.__load,UICompoLoader.baseUrl+pathStr,skinName) ;
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
		SliderLoader.__compoSkinList.push({skinName:UICompoLoader.__tmpSkinName,skinContent:skinContent,skinPath:UICompoLoader.__tmpFromPath}); 		
		UICompoLoader.__onEndLoad();		
	}
	
}
