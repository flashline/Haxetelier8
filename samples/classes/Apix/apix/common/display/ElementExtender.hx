/**
 * Copyright (c) jm Delettre.
 * 
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package apix.common.display ;
import apix.common.event.timing.MouseClock;
import apix.common.tools.math.Rectangle;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.EventListener;
import js.html.EventTarget;
import js.html.InputElement;
import js.html.MouseEvent;
import js.html.TextAreaElement;
import apix.common.tools.math.Vector;
import apix.common.event.StandardEvent;
import apix.common.util.Global;
/**
 * extends js.html.Element usage in caller : import js.html.Element; import apix.common.display.ElementExtender ; using apix.common.display.ElementExtender;
 */
typedef ElemBoundInfo = {
    var x : Float;
    var y : Float;
    var left : Float;
    var right: Float;
	var top: Float;
	var bottom: Float;
	var width: Float;
	var height: Float;
	
}
typedef DraggableElementInfo = {
    var elem : Element;
	var ox:Float;
	var oy:Float;
    var bounds : Rectangle;
	var mouseScale:Vector;
}
class ElementExtender  {
	//
	static var listeners:Array<Dynamic>=[];
	static var dragArray:Array<DraggableElementInfo>=[];
	//
	public static function elemBy (el:Element, v:String):Element {
		if (el.getElementsByClassName(v)[0] == null) trace("f:: class '" + v + "' doesn't exist in element with id '"+el.id+"'");
		return cast(el.getElementsByClassName(v)[0], Element) ;
	}
	public static function elemByTag (el:Element, v:String):Element {
		if (el.getElementsByTagName(v)[0] == null) trace("f:: tag '" + v + "' doesn't exist in element with id '"+el.id+"'");
		return cast(el.getElementsByTagName(v)[0], Element)  ;
	}
	/* KEEP... THEN TODO in haxe
	public function elemByAtt(oElm, strTagName, strAttributeName, strAttributeValue){
		var arrElements = (strTagName == "*" && oElm.all)? oElm.all : oElm.getElementsByTagName(strTagName);
		var arrReturnElements = new Array();
		var oAttributeValue = (typeof strAttributeValue != "undefined")? new RegExp("(^|\\s)" + strAttributeValue + "(\\s|$)", "i") : null;
		var oCurrent;
		var oAttribute;
		for(var i=0; i<arrElements.length; i++){
			oCurrent = arrElements[i];
			oAttribute = oCurrent.getAttribute && oCurrent.getAttribute(strAttributeName);
			if(typeof oAttribute == "string" && oAttribute.length > 0){
				if(typeof strAttributeValue == "undefined" || (oAttributeValue && oAttributeValue.test(oAttribute))){
					arrReturnElements.push(oCurrent);
				}
			}
		}
		return arrReturnElements;
	}
	*/
	public static function child (el:Element, v:String):Element {
		var ret:Element = null; var child:Element = null;
		for (i in el.children) {
			child = cast(i, Element);			
			if (child.id == v) {
				ret = child;
				break;
			}
		}
		if (ret == null) trace("f:: child with id '" + v + "' doesn't exist in element with id '"+el.id+"'");		
		return ret ;
	}
	public static function childByName (el:Element, v:String):InputElement {
		var ret = null;
		var child=null;
		for (i in el.children) {	
			if (Std.is(i, InputElement) || (Std.is(i,TextAreaElement) ) ) {
				child = i;	
				if ((untyped child).name == v) {
					ret = child;
					break;
				}
			}
		}
		if (ret == null) trace("f:: InputElement child with name '" + v + "' doesn't exist in element with id '"+el.id+"'");		
		return untyped ret ;
	}
	public static function clone (el:Element, ?b:Bool=true):Element {
		return cast( el.cloneNode(b), Element);
	}
	public static function positionInWindow(el:Element) {		
		var v = new Vector(0, 0);
		do {
			v.x += el.offsetLeft-el.scrollLeft;
			v.y += el.offsetTop-el.scrollTop;
			el = el.offsetParent;
		} while ( el!=null );
		return v;
	} 
	public static function getBoundInfo(el:Element) : ElemBoundInfo{
		var r = el.getBoundingClientRect();
		var ebi:ElemBoundInfo = {  x:null, y:null, left:null, right:null, top:null, bottom:null, width:null, height:null };		
		var v = positionInWindow(el);
		ebi.x = v.x;
		ebi.y = v.y;
		ebi.left = r.left;
		ebi.right = r.right;
		ebi.top = r.top;
		ebi.bottom = r.bottom;
		ebi.width = r.width;
		ebi.height = r.height;
		return ebi;
	}
	public static function handCursor(el:Element, ?v:Bool = true)  { 		
		var str;
		if (v) str = "pointer" ; else str = "auto" ;
		el.style.cursor = str ;
	}
	public static function visible(el:Element, ?b:Bool = null) :Bool { 		
		if (el == null) { trace ("f::Element is null !"); }	
		if (b == null) {
			b = (el.style.visibility == "hidden") ? false : true  ;
			if (b == null) { trace ("f::Element " + el.id + " hasn't valid visibility !"); }			
		}
		else { 
			b = boolVal(b);
			if (b) el.style.visibility = "visible" ; else el.style.visibility = "hidden" ;			
		}
		return b;
	}
	
	/**
	 * add child 
	 */
    public static function  addChild (el:Element, v:Element) : Element {	
		if (el == null) { trace ("f::Element is null !"); }	
		return untyped el.appendChild(v);
	}	
	/**
	 * remove all children 
	 */
    public static function  removeChildren (el:Element) {	
		if ( el.hasChildNodes() ) {
			while ( el.childNodes.length >0 ) {	
				el.removeChild( el.firstChild );   
			}
		}
	}
	/**
	 * remove element -used when native js remove() doesn't work !
	 */
    public static function  delete (el:Element) {	
		if ( el.parentNode!=null ) {
			el.parentNode.removeChild( el );   
		}
	}
	
	/**
	 * set rotatation axis
	 */
    public static function  setRotationAxis (e:Element, v:String) {	
		var el:Dynamic = untyped e;
		el.style.webkitTransformOrigin=v;
		el.style.mozTransformOrigin=v;
		el.style.msTransformOrigin=v;
		el.style.oTransformOrigin=v;		
		el.style.khtmlTransformOrigin = v;
		el.style.transformOrigin=v;
	}	
	/**
	 * change rotation
	 */
    public static function  setRotation (e:Element, v:Float) {	
		var el:Dynamic = untyped e;
		var r = Std.string(v);
		el.style.webkitTransform = "rotate(" + r + "deg)" ;
		el.style.mozTransform = "rotate(" + r + "deg)" ;
		el.style.msTransform = "rotate(" + r + "deg)" ;
		el.style.oTransform = "rotate(" + r + "deg)" ;		
		el.style.khtmlTransform = "rotate(" + r + "deg)" ;
		el.style.transform = "rotate(" + r + "deg)" ;		
	}	
	/**
	 * used for loop rotation+=n
	 */
    public static function  rotate (el:Element, v:Float) {	
		var r:Float = untyped el.rotation;
		if (r == null) {
			r = 0.0;
			(untyped el).rotation = 0.0 ;
		}
		v += (untyped el).rotation;
		setRotation (el, v);
		(untyped el).rotation = v;
	}	
	/**
	 * start element basic drag
	 */
    public static function  startDrag (el:Element, ?r:Rectangle, ?ms:Vector, ?forceStopAllDrag:Bool = true) {	
		dragArray.push( { elem:el, ox:el.offsetLeft, oy:el.offsetTop, bounds: r, mouseScale:ms } );
		var onMouseUp = forceStopAllDrag == true?stopAllDrag:null;
		if (Global._mouseClock == null) Global._mouseClock = new MouseClock(onDragClock,onMouseUp);			
	}
	public static function  stopDrag (el:Element) {	
		var len = dragArray.length;
		for (n in 0...len) {
			var dei:DraggableElementInfo = dragArray[n];					
			if (dei.elem == el) {
				dragArray.splice( n, 1 );
				break;
			}
		}
		if (dragArray.length == 0 && Global._mouseClock != null ) Global._mouseClock = Global._mouseClock.remove();
	}
	/**
	 * get/set x pos 
	 */    
	public static function posx(el:Element, ?v:Float = null,?bounds:Rectangle): Float { 	
		var vx = numVal(v, null);
		if (vx == null) {
			if (el.offsetLeft != null) vx = el.offsetLeft ; 
			else if (el.clientLeft != null) vx = el.clientLeft ; 
			else if (el.scrollLeft != null) vx = el.scrollLeft ; 
			else vx = numVal(Std.parseFloat(el.style.left),null);
			if (vx == null) { trace ("f::Element " + el.id + " hasn't valid left position !"); }
		}
		else {
			if (bounds != null) {
				if (vx < bounds.x ) vx = bounds.x ;
				else if (vx > bounds.x + bounds.width) vx = bounds.x + bounds.width;
			}
			el.style.left = Std.string( vx) + 'px';	
		}
		return vx;
	}
	/**
	 * get/set y pos
	 */  
	public static function posy(el:Element,?v:Float = null,?bounds:Rectangle): Float { 	
		var vy = numVal(v, null);
		if (vy == null) {
			if (el.offsetTop != null) vy = el.offsetTop ; 
			else if (el.clientTop != null) vy = el.clientTop ; 
			else if (el.scrollTop != null) vy = el.scrollTop ; 
			else vy = numVal(Std.parseFloat(el.style.left),null);
			if (vy == null) { trace ("f::Element " + el.id + " hasn't valid top position !"); }
		}
		else {
			if (bounds != null) {
				if (vy < bounds.y) vy = bounds.y ;
				else if (vy > bounds.y + bounds.height) vy = bounds.y + bounds.height;
			}
			el.style.top = Std.string( vy) + 'px';			
		}
		return vy;
	}
	/**
	 * get/set width
	 */  
	public static function width(el:Element, ?v:Float = null): Float { 
		if (el == null) { trace ("f::Element is null !"); }	
		var w = numVal(v, null);
		if (w == null) {
			if (el.clientWidth != null) w = el.clientWidth ; 
			else if (el.offsetWidth != null) w = el.offsetWidth ; 
			else if (el.scrollWidth != null) w = el.scrollWidth ; 
			else w = numVal(Std.parseFloat(el.style.width),null);
			if (w == null) { trace ("f::Element " + el.id + " hasn't valid width !"); }			
		}
		else { el.style.width=Std.string( w) + 'px'; }
		return w;
	}
	/**
	 * get/set height
	 */  
	public static function height(el:Element, ?v:Float = null): Float { 
		if (el == null) { trace ("f::Element is null !"); }	
		var h = numVal(v, null);
		if (h == null) {
			if (el.clientHeight != null) h = el.clientHeight ; 
			else if (el.offsetHeight != null) h = el.offsetHeight ; 
			else if (el.scrollHeight != null) h = el.scrollHeight ; 
			else h = numVal(Std.parseFloat(el.style.height),null);
			if (h == null) { trace ("f::Element " + el.id + " hasn't valid height !"); }			
		}
		else { el.style.height=Std.string( h) + 'px'; }
		return h;
	}
	/**
	 * get parentElement ...
	 */
	public static function parent (el:Element): Null<Element> { 
		if (el == null) { trace ("f::Element is null !"); }			
		return el.parentElement;
	}	
	/**
	 * get/set innerHtml ...
	 */
    public static function  inner (el:Element, ?v:String = null): Null<String> { 
		if (el == null) { trace ("f::Element is null !"); }	
		if (v == null) { v = el.innerHTML ;	}
		else { el.innerHTML=v; }
		return v;
	}	
	/**
	 * has el css class ?
	 */
    public static function  haveClass (el:Element, v:String ): Bool { 
		if (el == null) { trace ("f::Element is null !"); }			
		var ex = false;
		for (i in el.classList) {
			if (i == v) ex = true;
		}
		return ex;
	}	
	/**
	 * add css class ?
	 */
	public static function  addClass (el:Element, v:String ): Bool { 
		if (el == null) { trace ("f::Element is null !"); }	
		if (haveClass (el, v) ) return false;
		else {
			el.classList.add(v);
			return true;
		}
	}	
	/**
	 * remove css class ?
	 */
	public static function  removeClass (el:Element, v:String ): Bool { 
		if (el == null) { trace ("f::Element is null !"); }	
		if (!haveClass (el, v)) return false;
		else {
			el.classList.remove(v);
			return true;
		}
	}
	/**
	 * for mobiles ; must be used width apix/default/common.css -default or modified.
	 */
	public static function  doOnTouchStart (el:Element) { 
		if (el == null) { trace ("f::Element is null !"); }	
		addClass(el,"apix_do_when_touch");
	}	
	public static function  doOnTouchEnd (el:Element) { 
		if (el == null) { trace ("f::Element is null !"); }	
		removeClass(el,"apix_do_when_touch");
	}	
	
	/**
	 * get/set value , or textContent , or innerHtml ...
	 */
    public static function  text (e:Element, ?v:String = null) {	
		var el:Dynamic = e; if (el == null) { trace ("f::Element is null !"); }	
		if (v == null) {
			if (Std.is(el, InputElement) || Std.is(el, TextAreaElement)) v = el.value;
			else if (Std.is(el, Element)) {
				if (el.textContent!=null) v = el.textContent ;
				else if ( el.nodeValue != null) v = el.nodeValue ;			
				else if ( el.innerHTML!=null) v = el.innerHTML ;
			}			
		}
		else { 
			if (Std.is(el, InputElement) || Std.is(el, TextAreaElement)) el.value = v;
			else if (Std.is(el, Element)) {
				if (el.textContent!=null) el.textContent =v  ;
				else if ( el.nodeValue != null) el.nodeValue=v ;			
				else if ( el.innerHTML!=null) el.innerHTML =v;
			}
		}
		if (v == null)  { trace ("f::Element " + el.id + " hasn't text property !"); }	
		return v;
	}	
	
	/**
	 * involve enter key (hexa OD) to elem's click event
	 * el MUST BE visible and MUST NOT BE display:"none"
	 */
	public static function  joinEnterKeyToClick (el:Element, ?buttonArray:Array<Element> , ?focusElem:Element) {	
		var activeEl:Element = null;
		if (focusElem != null) focusElem.focus();		
		else el.focus();
		if (buttonArray == null) buttonArray = [];
		buttonArray.push(el);
		Browser.window.onkeypress = function (e) { 
			if (untyped e.keyCode == 13) { 	
				for (button in buttonArray) {
					if (button==Browser.document.activeElement) {
						activeEl = Browser.document.activeElement;
					}
				}
				if (activeEl==null) {
					var evt  = new Event(StandardEvent.CLICK);
					el.dispatchEvent(evt);
				}
			}
		} ;
	}	
	public static function  clearEnterKeyToClick (el:Element) {	
		Browser.window.onkeypress = null ;
	}	
	
	/**
	 * call examples :
	 *    view.connection.addLst("click",onClick,false,{param1:"param11",param2:"param12"} ); 
	 *	  view.connection.removeLst("click", onClick, false );
	 * 	  if no parameters needs to be sent, original listener is used ; else a delegate listener is used.
	 * @param	srcEvt
	 * @param	type
	 * @param	listenerFunction
	 * @param	?b
	 * @param	?data
	 */
	public static function on(srcEvt:EventTarget, type:String, listenerFunction:Dynamic, ?b:Bool = false, ?data:Dynamic = null) {
		if (StandardEvent.isMouseType(type)) handCursor(untyped srcEvt);		
		var deleguateFunction:EventListener = getLst(srcEvt, listenerFunction, data);
		var el:Dynamic=untyped srcEvt;if (el.listeners == null) el.listeners = [];
		el.listeners.push( {type:type, listenerFunction:listenerFunction, deleguateFunction:deleguateFunction } );		
		srcEvt.addEventListener(type, deleguateFunction, b );
	}	
	public static function off(srcEvt:EventTarget, type:String, listenerFunction:Dynamic, ?b:Bool = false)  {			
		if ( !removeDelegateListener(srcEvt, type, listenerFunction, b) ) {
			srcEvt.removeEventListener(type, listenerFunction, b);
		}
		if ((!hasLst (srcEvt)) ) handCursor(untyped srcEvt, false);
	}
	/**
	 * alias of on()  and off()
	 */
	public static inline function addLst(srcEvt:EventTarget, type:String, listenerFunction:Dynamic, ?b:Bool = false, ?data:Dynamic = null) {		
		on(srcEvt,convertEventType(type), listenerFunction, b, data);
	}
	public static inline function removeLst(srcEvt:EventTarget, type:String, listenerFunction:Dynamic, ?b:Bool = false)  {			
		off(srcEvt,convertEventType(type), listenerFunction, b);
	}
	/**
	 * <b>returns true</b> if at least one listener exists.
	 */
    public static function  hasLst (srcEvt:EventTarget, ?type:String, ?listenerFunction:Dynamic) : Bool {	
		var el:Dynamic = untyped srcEvt;
		var ret:Bool = false;
		if (el.listeners != null) {
			var len = el.listeners.length;
			for (n in 0...len) {
				var i = el.listeners[n];				
				if (type == null) {
					ret = true; break;
				}
				else if (i.type == type) {											
					if (listenerFunction == null) ret = true;
					else if (Reflect.compareMethods(i.listenerFunction,listenerFunction) ) ret = true; 
					if (ret) break;
				}
			}	
		}
		return ret;
	}
	/**
	 * 
	 * @param	type Event type
	 * @return touch or mouse event type.
	 */
	static inline function convertEventType(type:String) : String {			
		if (Global.get().isMobile) {
			if (type == StandardEvent.MOUSE_DOWN) type = StandardEvent.TOUCH_START ;
			else if (type == StandardEvent.MOUSE_UP) type = StandardEvent.TOUCH_END ;
		}
		else {
			if (type == StandardEvent.TOUCH_START) type = StandardEvent.MOUSE_DOWN ;
			else if (type == StandardEvent.TOUCH_END) type = StandardEvent.MOUSE_UP ;
		}
		return type;
	}	
	
	//
	/**
	 * @private
	 */
	static function getLst(srcEvt,listenerFunction:Dynamic,?data:Dynamic) : EventListener {
		var deleguateFunction:EventListener;
		if (data == null) deleguateFunction = listenerFunction;
		else {			
			deleguateFunction = function (e:Event) { listenerFunction.call(srcEvt, e, data) ;  } ;				
		}
		return deleguateFunction ;
	}
	
	static function removeDelegateListener(srcEvt:Dynamic, type:String, listenerFunction:Dynamic, ?b:Bool = false) :Bool {
		var match = false;
		var el:Dynamic = untyped srcEvt;
		if (el.listeners!=null) {
			var len = el.listeners.length;
			for (n in 0...len) {
				var i = el.listeners[n];
				if (Reflect.compareMethods(i.listenerFunction,listenerFunction) ) { 
					if (i.type == type) {							
						if (i.deleguateFunction != null) {
							srcEvt.removeEventListener(type, i.deleguateFunction, b);
						}
						el.listeners.splice(n, 1);
						//removeDelegateListener(srcEvt, type, listenerFunction, b);
						match = true;
						break;
					}
				}
			}
		}
		return match;
	}
	static function boolVal(b:Dynamic,?defVal:Bool=false) :Bool {
		if (b==null) return defVal ;
		if (Std.is(b,String)) {
			if 		(b=="true" ) return true;
			else if (b=="false") return false;				
			else  				return defVal ;
		} else if (Std.is(b,Float)  ) {
			if 		(b==0) 		return false ;
			else if (b==1) 		return true ;
			else  				return defVal ;
		} else if (Std.is(b,Bool) ) return b ;
		return defVal;
	}
	static function strVal(s:Dynamic,?defVal:String="") :String {	
		if (s==null) return defVal ;
		if (s=="") return defVal;
		return s;
	}
	static function numVal(n:Dynamic,?defVal:Float) : Float {
		if (n=="0") return Std.parseFloat("0"); 
		if (n==null) return defVal ;
		if (Math.isNaN(n)) return defVal ;
		if (n == "") return defVal ; 
		if (Std.is(n,String)) return Std.parseFloat(n); 
		return Math.pow(n,1) ;
	}
	static function  onDragClock (clk:MouseClock) {	
		var msx = 1.0 ; var msy = 1.0; 
		for (o in dragArray) {		
			if (o.mouseScale != null) { msx = o.mouseScale.x ; msy = o.mouseScale.y; }
			posx(o.elem, o.ox + clk.x*msx, o.bounds) ;
			posy(o.elem, o.oy + clk.y*msy, o.bounds) ;			
		}
	}
	static function stopAllDrag (e:MouseEvent) {	
		if (Global._mouseClock != null ) Global._mouseClock = Global._mouseClock.remove();
		dragArray = [];	
	}
}
 