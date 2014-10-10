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
package apix.common.util ;
import apix.ui.slider.Slider;
import apix.ui.slider.Slider.SliderProp;
import js.Browser;
import js.html.Element;
import js.html.NodeList;
using apix.common.display.ElementExtender;
/**
 * extends String usage in caller : using apix.common.util.StringExtender;
 */
class StringExtender  {
	static public var rootHtmlElement:Element;
	//
	public static function on (v:String,type:String, listenerFunction:Dynamic, ?b:Bool = false, ?data:Dynamic = null,?parent=null) {
		var nl:Array<Element>;	
		nl = all (v, parent);	
		for (el in nl) {
			el.on(type, listenerFunction, b, data);
		}
	}
	public static function off (v:String,type:String, listenerFunction:Dynamic, ?b:Bool = false,?parent=null) {
		var nl:Array<Element>;
		nl = all (v, parent);	
		for (el in nl) {
			el.off(type, listenerFunction, b);
		}
	}
	public static function all (v:String, ?parent = null) :Array<Element> {
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;	
		return untyped parent.querySelectorAll(v);	
	}
	public static function get (v:String,?parent=null):Element{
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;		
		return untyped parent.querySelector(v);	
	}
	//UICompo
	public static function slider (v:String,?p:SliderProp) :Slider {
		if (p == null) p = { };
		p.into = v;
		return new Slider	(p); 
	}
}
 