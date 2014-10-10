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
#if js
	import js.Browser;
	import js.html.Element;
	import js.html.Document;
	import js.html.Node;
	import js.html.NodeList;
#else if flash
	import flash.display.Sprite;
	import flash.display.Stage;
#end
/**
 * Contains display static methods to abstract language specific methods
 */
class Common {	
	public static inline var DESC_EXT:String = #if (js) "html" #elseif flash "xml" #end ;
	//	
	public static inline function getElem(v:String) :  #if (js) Element #elseif flash Sprite #end {
		#if (js)
			return  Browser.document.getElementById(v);
		#elseif flash 
			//todo 
		#end
	}
	public static inline function createElem() : #if (js) Element #elseif flash Sprite #end {
		#if (js)
			return Browser.document.createElement("div");
		#elseif flash
			return new Sprite();
		#end
	}	
	public static inline function getElemsByTagName(v:String) : #if (js) NodeList #else Array<Sprite> #end {
		#if (js)
			return  Browser.document.getElementsByTagName(v);
		#end
	}
	
	public static var document (get, null):#if (js) Document #end;
	static function get_document() : #if (js) Document #end {
		#if (js)
			return  Browser.document;
		#end
	}
	public static var head (get, null):#if (js) Element #end;
	static function get_head() : #if (js) Element #end {
		#if (js)
			return  Browser.document.head ;
		#else
			//todo
		#end
	}
	//
	public static var body (get, null):#if (js) Element #end;
	static function get_body() : #if (js) Element #end {
		#if (js)
			return Browser.document.body;
		#end
	}
	//
	public static var availWidth (get, null): Float ;
	static function get_availWidth() : Float {
		#if (js)
			return Browser.window.screen.availWidth ;
		#elseif (cock)
			return Browser.window.innerWidth ;			
		#end
	}	
	public static var availHeight (get, null): Float;
	static function get_availHeight() : Float {
		#if (js)
			return Browser.window.screen.availHeight ;
		#else
			//todo
				
		#end
	}	
	public static var userAgent (get, null): String;
	static function get_userAgent() : String {
		#if (js)
			return Browser.navigator.userAgent ;
		#end
	}	
	// get new unique Id
	public static var newSingleId(get, null):String ; static var __nextSingleId:Int=-1 ;
	static function get_newSingleId ():String { 
		__nextSingleId++ ; var id = "apix_instance_" + __nextSingleId ; 
		if (Common.getElem(id)!=null) trace("f::Id "+id+" already exists ! "); 
		return id;
	}	
	//
	
	
	
	
		
}
 