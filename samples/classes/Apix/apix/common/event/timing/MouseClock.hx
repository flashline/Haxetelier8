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
package apix.common.event.timing;
import apix.common.event.StandardEvent.MouseTouchEvent;
import apix.common.util.Global;
import apix.common.display.Common;
import apix.common.event.EventSource;
import apix.common.event.StandardEvent;
import apix.common.tools.math.Vector;
import js.Browser;
import js.html.MouseEvent;
/**
 * 
 */
class MouseClock   {
	var g:Global;
	var onMouseMove:Dynamic;
	var onMouseUp:Dynamic;
	public var x(default,null):Float;
	public var y(default,null):Float;
	var sx(default,null):Float;
	var sy(default, null):Float;
	//
	public var top(default,null):EventSource ;
	/**
	* Constructor
	* <br/><b>omm</b> callback func 
	* <br/><b>per</b> period in sec.
	*/
    public function new ( omm:Dynamic, ?omu:Dynamic) {	
		g = Global.get();
		onMouseMove = omm;
		onMouseUp = omu;
		var ev:String = g.isMobile?StandardEvent.TOUCH_MOVE:StandardEvent.MOUSE_MOVE;
		Common.document.addEventListener( ev, clockRun); 
		if (onMouseUp != null) {			
			ev=g.isMobile?StandardEvent.TOUCH_END:StandardEvent.MOUSE_UP;
			Common.document.addEventListener(ev, clockStop);	
		}
		top = new EventSource();
	}
	/**
	 * 
	 * <br/><b></b>	
	 */
	/**
	 * getter/setter
	 */

	/**
	 * public
	 */	
	
	public function remove () : Dynamic {
		var ev:String = g.isMobile?StandardEvent.TOUCH_MOVE:StandardEvent.MOUSE_MOVE;
		Browser.document.removeEventListener( ev,clockRun);
		onMouseMove = null;
		top = null;
		return null;
	}
	public function toString() :String {
		var str = "";
		str += "rel x="+x+" / " ;			
		str += "abs x="+(x+sx)+" / " ;			
		str += "rel y="+y+" / " ;			
		str += "abs y="+(y+sy)+" / " ;			
						
		return str;
    }
	/**
	 * private
	 */
	function clockRun (e:MouseTouchEvent) {
		e.preventDefault();
		var ex:Float = g.isMobile?e.changedTouches[0].pageX:e.clientX;
		var ey:Float = g.isMobile?e.changedTouches[0].pageY:e.clientY;
		//		
		if (sx == null) sx = ex;
		if (sy == null) sy = ey;
		x=ex-sx ; 
		//offsetX=e.offsetX ;
		y=ey-sy ; 
		//offsetY=e.offsetY ; 
		onMouseMove(this) ;
		top.dispatch(new StandardEvent(this));
	}
	function clockStop (e:MouseEvent) {
		e.preventDefault();
		var ev:String = g.isMobile?StandardEvent.TOUCH_END:StandardEvent.MOUSE_UP;
		Browser.window.removeEventListener(ev, clockStop);
		if (onMouseUp!=null) onMouseUp(this);
	}
	
}