(function () { "use strict";
function $extend(from, fields) {
	function inherit() {}; inherit.prototype = from; var proto = new inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	match: function(s) {
		if(this.r.global) this.r.lastIndex = 0;
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,__class__: EReg
}
var HxOverrides = function() { }
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
}
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
}
var Main = function() {
	this.g = apix.common.util.Global.get();
	this.g.setupTrace();
	haxe.Log.trace("i::Component loaded !!",{ fileName : "Main.hx", lineNumber : 30, className : "Main", methodName : "new"});
	this.start();
};
Main.__name__ = true;
Main.main = function() {
	apix.ui.slider.Slider.init();
	apix.ui.slider.Slider.init("skinVerti","apix/skinVerti/Slider/");
	apix.ui.slider.Slider.init("skin3","apix/skin3/Slider/");
	apix.ui.progressBar.ProgressBar.init();
	apix.ui.UICompo.loadInit(function() {
		new Main();
	});
}
Main.prototype = {
	onSlider3Change: function(e) {
		apix.common.util.StringExtender.get("#slider3-round2").textContent = Std.string(e.target.round(2));
	}
	,onSliderVertiChange: function(e) {
		var s = e.target;
		apix.common.util.StringExtender.get("#sliderVerti-round").textContent = Std.string(s.round(2));
	}
	,onSliderChange: function(e) {
		apix.common.util.StringExtender.get("#mySlider-sel-0").textContent = Std.string(this.mySlider.selectors[0].round(2));
		apix.common.util.StringExtender.get("#mySlider-sel-1").textContent = Std.string(this.mySlider.selectors[1].round(4));
		apix.common.util.StringExtender.get("#mySlider-sel-2").textContent = Std.string(this.mySlider.selectors[2].round(6));
	}
	,start: function() {
		var s = new apix.ui.slider.Slider({ id : "mySlider", auto : false, start : -10.5, end : 12.25, gap : 8});
		s.set_into("#slidersCtnrId");
		s.enable();
		s.change.on($bind(this,this.onSliderChange));
		this.mySlider = s;
		apix.common.util.StringExtender.slider("#sliderVertiCtnrId",{ skin : "skinVerti"}).change.on($bind(this,this.onSliderVertiChange));
		this.slider3 = apix.common.util.StringExtender.slider("#slider3CtnrId",{ skin : "skin3", start : -1, end : 1});
		this.slider3.change.on($bind(this,this.onSlider3Change));
		apix.common.display.ElementExtender.visible(apix.common.util.StringExtender.get("#sliderToBeAttachedId"),false);
		var p = new apix.ui.progressBar.ProgressBar();
		p.set_into("#progressCtnrId");
	}
	,__class__: Main
}
var IMap = function() { }
IMap.__name__ = true;
var Reflect = function() { }
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	var v = null;
	try {
		v = o[field];
	} catch( e ) {
	}
	return v;
}
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
var StringTools = function() { }
StringTools.__name__ = true;
StringTools.urlEncode = function(s) {
	return encodeURIComponent(s);
}
var apix = {}
apix.common = {}
apix.common.display = {}
apix.common.display.Common = function() { }
apix.common.display.Common.__name__ = true;
apix.common.display.Common.get_document = function() {
	return js.Browser.document;
}
apix.common.display.Common.get_head = function() {
	return js.Browser.document.head;
}
apix.common.display.Common.get_body = function() {
	return js.Browser.document.body;
}
apix.common.display.Common.get_userAgent = function() {
	return js.Browser.navigator.userAgent;
}
apix.common.display.Common.get_newSingleId = function() {
	apix.common.display.Common.__nextSingleId++;
	var id = "apix_instance_" + apix.common.display.Common.__nextSingleId;
	if(js.Browser.document.getElementById(id) != null) haxe.Log.trace("f::Id " + id + " already exists ! ",{ fileName : "Common.hx", lineNumber : 112, className : "apix.common.display.Common", methodName : "get_newSingleId"});
	return id;
}
apix.common.display.ElementExtender = function() { }
apix.common.display.ElementExtender.__name__ = true;
apix.common.display.ElementExtender.handCursor = function(el,v) {
	if(v == null) v = true;
	var str;
	if(v) str = "pointer"; else str = "auto";
	el.style.cursor = str;
}
apix.common.display.ElementExtender.visible = function(el,b) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 152, className : "apix.common.display.ElementExtender", methodName : "visible"});
	if(b == null) {
		b = el.style.visibility == "hidden"?false:true;
		if(b == null) haxe.Log.trace("f::Element " + el.id + " hasn't valid visibility !",{ fileName : "ElementExtender.hx", lineNumber : 155, className : "apix.common.display.ElementExtender", methodName : "visible"});
	} else {
		b = apix.common.display.ElementExtender.boolVal(b);
		if(b) el.style.visibility = "visible"; else el.style.visibility = "hidden";
	}
	return b;
}
apix.common.display.ElementExtender.startDrag = function(el,r,ms,forceStopAllDrag) {
	if(forceStopAllDrag == null) forceStopAllDrag = true;
	apix.common.display.ElementExtender.dragArray.push({ elem : el, ox : el.offsetLeft, oy : el.offsetTop, bounds : r, mouseScale : ms});
	var onMouseUp = forceStopAllDrag == true?apix.common.display.ElementExtender.stopAllDrag:null;
	if(apix.common.util.Global._mouseClock == null) apix.common.util.Global._mouseClock = new apix.common.event.timing.MouseClock(apix.common.display.ElementExtender.onDragClock,onMouseUp);
}
apix.common.display.ElementExtender.stopDrag = function(el) {
	var len = apix.common.display.ElementExtender.dragArray.length;
	var _g = 0;
	while(_g < len) {
		var n = _g++;
		var dei = apix.common.display.ElementExtender.dragArray[n];
		if(dei.elem == el) {
			apix.common.display.ElementExtender.dragArray.splice(n,1);
			break;
		}
	}
	if(apix.common.display.ElementExtender.dragArray.length == 0 && apix.common.util.Global._mouseClock != null) apix.common.util.Global._mouseClock = apix.common.util.Global._mouseClock.remove();
}
apix.common.display.ElementExtender.posx = function(el,v,bounds) {
	var vx = apix.common.display.ElementExtender.numVal(v,null);
	if(vx == null) {
		if(el.offsetLeft != null) vx = el.offsetLeft; else if(el.clientLeft != null) vx = el.clientLeft; else if(el.scrollLeft != null) vx = el.scrollLeft; else vx = apix.common.display.ElementExtender.numVal(Std.parseFloat(el.style.left),null);
		if(vx == null) haxe.Log.trace("f::Element " + el.id + " hasn't valid left position !",{ fileName : "ElementExtender.hx", lineNumber : 256, className : "apix.common.display.ElementExtender", methodName : "posx"});
	} else {
		if(bounds != null) {
			if(vx < bounds.get_x()) vx = bounds.get_x(); else if(vx > bounds.get_x() + bounds.get_width()) vx = bounds.get_x() + bounds.get_width();
		}
		el.style.left = Std.string(vx) + "px";
	}
	return vx;
}
apix.common.display.ElementExtender.posy = function(el,v,bounds) {
	var vy = apix.common.display.ElementExtender.numVal(v,null);
	if(vy == null) {
		if(el.offsetTop != null) vy = el.offsetTop; else if(el.clientTop != null) vy = el.clientTop; else if(el.scrollTop != null) vy = el.scrollTop; else vy = apix.common.display.ElementExtender.numVal(Std.parseFloat(el.style.left),null);
		if(vy == null) haxe.Log.trace("f::Element " + el.id + " hasn't valid top position !",{ fileName : "ElementExtender.hx", lineNumber : 277, className : "apix.common.display.ElementExtender", methodName : "posy"});
	} else {
		if(bounds != null) {
			if(vy < bounds.get_y()) vy = bounds.get_y(); else if(vy > bounds.get_y() + bounds.get_height()) vy = bounds.get_y() + bounds.get_height();
		}
		el.style.top = Std.string(vy) + "px";
	}
	return vy;
}
apix.common.display.ElementExtender.width = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 292, className : "apix.common.display.ElementExtender", methodName : "width"});
	var w = apix.common.display.ElementExtender.numVal(v,null);
	if(w == null) {
		if(el.clientWidth != null) w = el.clientWidth; else if(el.offsetWidth != null) w = el.offsetWidth; else if(el.scrollWidth != null) w = el.scrollWidth; else w = apix.common.display.ElementExtender.numVal(Std.parseFloat(el.style.width),null);
		if(w == null) haxe.Log.trace("f::Element " + el.id + " hasn't valid width !",{ fileName : "ElementExtender.hx", lineNumber : 299, className : "apix.common.display.ElementExtender", methodName : "width"});
	} else el.style.width = Std.string(w) + "px";
	return w;
}
apix.common.display.ElementExtender.height = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 308, className : "apix.common.display.ElementExtender", methodName : "height"});
	var h = apix.common.display.ElementExtender.numVal(v,null);
	if(h == null) {
		if(el.clientHeight != null) h = el.clientHeight; else if(el.offsetHeight != null) h = el.offsetHeight; else if(el.scrollHeight != null) h = el.scrollHeight; else h = apix.common.display.ElementExtender.numVal(Std.parseFloat(el.style.height),null);
		if(h == null) haxe.Log.trace("f::Element " + el.id + " hasn't valid height !",{ fileName : "ElementExtender.hx", lineNumber : 315, className : "apix.common.display.ElementExtender", methodName : "height"});
	} else el.style.height = Std.string(h) + "px";
	return h;
}
apix.common.display.ElementExtender.parent = function(el) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 324, className : "apix.common.display.ElementExtender", methodName : "parent"});
	return el.parentElement;
}
apix.common.display.ElementExtender.inner = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 331, className : "apix.common.display.ElementExtender", methodName : "inner"});
	if(v == null) v = el.innerHTML; else el.innerHTML = v;
	return v;
}
apix.common.display.ElementExtender.haveClass = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 340, className : "apix.common.display.ElementExtender", methodName : "haveClass"});
	var ex = false;
	var _g = 0, _g1 = el.classList;
	while(_g < _g1.length) {
		var i = _g1[_g];
		++_g;
		if(i == v) ex = true;
	}
	return ex;
}
apix.common.display.ElementExtender.addClass = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 351, className : "apix.common.display.ElementExtender", methodName : "addClass"});
	if(apix.common.display.ElementExtender.haveClass(el,v)) return false; else {
		el.classList.add(v);
		return true;
	}
}
apix.common.display.ElementExtender.removeClass = function(el,v) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 362, className : "apix.common.display.ElementExtender", methodName : "removeClass"});
	if(!apix.common.display.ElementExtender.haveClass(el,v)) return false; else {
		el.classList.remove(v);
		return true;
	}
}
apix.common.display.ElementExtender.doOnTouchStart = function(el) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 373, className : "apix.common.display.ElementExtender", methodName : "doOnTouchStart"});
	apix.common.display.ElementExtender.addClass(el,"apix_do_when_touch");
}
apix.common.display.ElementExtender.doOnTouchEnd = function(el) {
	if(el == null) haxe.Log.trace("f::Element is null !",{ fileName : "ElementExtender.hx", lineNumber : 377, className : "apix.common.display.ElementExtender", methodName : "doOnTouchEnd"});
	apix.common.display.ElementExtender.removeClass(el,"apix_do_when_touch");
}
apix.common.display.ElementExtender.addLst = function(srcEvt,type,listenerFunction,b,data) {
	if(b == null) b = false;
	if(apix.common.event.StandardEvent.isMouseType(type)) apix.common.display.ElementExtender.handCursor(srcEvt);
	var deleguateFunction = apix.common.display.ElementExtender.getLst(srcEvt,listenerFunction,data);
	var el = srcEvt;
	if(el.listeners == null) el.listeners = [];
	el.listeners.push({ type : type, listenerFunction : listenerFunction, deleguateFunction : deleguateFunction});
	srcEvt.addEventListener(type,deleguateFunction,b);
}
apix.common.display.ElementExtender.convertEventType = function(type) {
	if(apix.common.util.Global.get().get_isMobile()) {
		if(type == "mousedown") type = "touchstart"; else if(type == "mouseup") type = "touchend";
	} else if(type == "touchstart") type = "mousedown"; else if(type == "touchend") type = "mouseup";
	return type;
}
apix.common.display.ElementExtender.getLst = function(srcEvt,listenerFunction,data) {
	var deleguateFunction;
	if(data == null) deleguateFunction = listenerFunction; else deleguateFunction = function(e) {
		listenerFunction.call(srcEvt,e,data);
	};
	return deleguateFunction;
}
apix.common.display.ElementExtender.boolVal = function(b,defVal) {
	if(defVal == null) defVal = false;
	if(b == null) return defVal;
	if(js.Boot.__instanceof(b,String)) {
		if(b == "true") return true; else if(b == "false") return false; else return defVal;
	} else if(js.Boot.__instanceof(b,Float)) {
		if(b == 0) return false; else if(b == 1) return true; else return defVal;
	} else if(js.Boot.__instanceof(b,Bool)) return b;
	return defVal;
}
apix.common.display.ElementExtender.numVal = function(n,defVal) {
	if(n == "0") return Std.parseFloat("0");
	if(n == null) return defVal;
	if(Math.isNaN(n)) return defVal;
	if(n == "") return defVal;
	if(js.Boot.__instanceof(n,String)) return Std.parseFloat(n);
	return Math.pow(n,1);
}
apix.common.display.ElementExtender.onDragClock = function(clk) {
	var msx = 1.0;
	var msy = 1.0;
	var _g = 0, _g1 = apix.common.display.ElementExtender.dragArray;
	while(_g < _g1.length) {
		var o = _g1[_g];
		++_g;
		if(o.mouseScale != null) {
			msx = o.mouseScale.get_x();
			msy = o.mouseScale.get_y();
		}
		apix.common.display.ElementExtender.posx(o.elem,o.ox + clk.x * msx,o.bounds);
		apix.common.display.ElementExtender.posy(o.elem,o.oy + clk.y * msy,o.bounds);
	}
}
apix.common.display.ElementExtender.stopAllDrag = function(e) {
	if(apix.common.util.Global._mouseClock != null) apix.common.util.Global._mouseClock = apix.common.util.Global._mouseClock.remove();
	apix.common.display.ElementExtender.dragArray = [];
}
apix.common.event = {}
apix.common.event.EventSource = function() {
	this._listenerArray = [];
};
apix.common.event.EventSource.__name__ = true;
apix.common.event.EventSource.prototype = {
	dispatch: function(e) {
		var ret = null;
		if(e.target == null) e.target = this;
		var _g = 0, _g1 = this._listenerArray;
		while(_g < _g1.length) {
			var o = _g1[_g];
			++_g;
			e.data = o.data;
			ret = o.listener(e);
		}
		return ret;
	}
	,on: function(listener,data) {
		this._listenerArray.push({ listener : listener, data : data});
		return true;
	}
	,__class__: apix.common.event.EventSource
}
apix.common.event.StandardEvent = function(target,type,message) {
	if(message == null) message = "";
	if(type == null) type = "event";
	this.target = target;
	this.type = type;
	this.message = message;
};
apix.common.event.StandardEvent.__name__ = true;
apix.common.event.StandardEvent.isMouseType = function(v) {
	var _g = 0, _g1 = ["click","dblclick","mousedown","mouseover"];
	while(_g < _g1.length) {
		var i = _g1[_g];
		++_g;
		if(i == v) return true;
	}
	return false;
}
apix.common.event.StandardEvent.prototype = {
	__class__: apix.common.event.StandardEvent
}
var haxe = {}
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.__name__ = true;
haxe.Timer.prototype = {
	run: function() {
		haxe.Log.trace("run",{ fileName : "Timer.hx", lineNumber : 98, className : "haxe.Timer", methodName : "run"});
	}
	,stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,__class__: haxe.Timer
}
apix.common.event.timing = {}
apix.common.event.timing.Clock = function(f,per) {
	if(per == null) per = 0.04;
	haxe.Timer.call(this,Math.round(per * 1000));
	this.top = new apix.common.event.EventSource();
	this.run = $bind(this,this.clockRun);
	this.listener = f;
	this._idle = false;
};
apix.common.event.timing.Clock.__name__ = true;
apix.common.event.timing.Clock.__super__ = haxe.Timer;
apix.common.event.timing.Clock.prototype = $extend(haxe.Timer.prototype,{
	clockRun: function() {
		if(!this._idle) {
			if(this.listener != null) this.listener(this);
			if(this.top != null) this.top.dispatch(new apix.common.event.StandardEvent(this));
		}
	}
	,__class__: apix.common.event.timing.Clock
});
apix.common.event.timing.MouseClock = function(omm,omu) {
	this.g = apix.common.util.Global.get();
	this.onMouseMove = omm;
	this.onMouseUp = omu;
	var ev = this.g.get_isMobile()?"touchmove":"mousemove";
	apix.common.display.Common.get_document().addEventListener(ev,$bind(this,this.clockRun));
	if(this.onMouseUp != null) {
		ev = this.g.get_isMobile()?"touchend":"mouseup";
		apix.common.display.Common.get_document().addEventListener(ev,$bind(this,this.clockStop));
	}
	this.top = new apix.common.event.EventSource();
};
apix.common.event.timing.MouseClock.__name__ = true;
apix.common.event.timing.MouseClock.prototype = {
	clockStop: function(e) {
		e.preventDefault();
		var ev = this.g.get_isMobile()?"touchend":"mouseup";
		js.Browser.window.removeEventListener(ev,$bind(this,this.clockStop));
		if(this.onMouseUp != null) this.onMouseUp(this);
	}
	,clockRun: function(e) {
		e.preventDefault();
		var ex = this.g.get_isMobile()?e.changedTouches[0].pageX:e.clientX;
		var ey = this.g.get_isMobile()?e.changedTouches[0].pageY:e.clientY;
		if(this.sx == null) this.sx = ex;
		if(this.sy == null) this.sy = ey;
		this.x = ex - this.sx;
		this.y = ey - this.sy;
		this.onMouseMove(this);
		this.top.dispatch(new apix.common.event.StandardEvent(this));
	}
	,remove: function() {
		var ev = this.g.get_isMobile()?"touchmove":"mousemove";
		js.Browser.document.removeEventListener(ev,$bind(this,this.clockRun));
		this.onMouseMove = null;
		this.top = null;
		return null;
	}
	,__class__: apix.common.event.timing.MouseClock
}
apix.common.tools = {}
apix.common.tools.math = {}
apix.common.tools.math.MathX = function() { }
apix.common.tools.math.MathX.__name__ = true;
apix.common.tools.math.MathX.round = function(n,d) {
	if(d == null) d = 2;
	var p = Math.pow(10,d);
	return Math.round(n * p) / p;
}
apix.common.tools.math.Vector = function(vx,vy,vz) {
	this.g = apix.common.util.Global.get();
	this.set_x(vx);
	this.set_y(vy);
	this.set_z(vz);
};
apix.common.tools.math.Vector.__name__ = true;
apix.common.tools.math.Vector.prototype = {
	set_z: function(v) {
		this._z = v;
		return v;
	}
	,set_y: function(v) {
		this._y = v;
		return v;
	}
	,get_y: function() {
		return this._y;
	}
	,set_x: function(v) {
		this._x = v;
		return v;
	}
	,get_x: function() {
		return this._x;
	}
	,__class__: apix.common.tools.math.Vector
}
apix.common.tools.math.Rectangle = function(vx,vy,w,h) {
	apix.common.tools.math.Vector.call(this,vx,vy);
	this.set_width(w);
	this.set_height(h);
};
apix.common.tools.math.Rectangle.__name__ = true;
apix.common.tools.math.Rectangle.__super__ = apix.common.tools.math.Vector;
apix.common.tools.math.Rectangle.prototype = $extend(apix.common.tools.math.Vector.prototype,{
	set_height: function(v) {
		this._height = v;
		return v;
	}
	,get_height: function() {
		return this._height;
	}
	,get_length: function() {
		return Math.max(this.get_width(),this.get_height());
	}
	,set_width: function(v) {
		this._width = v;
		return v;
	}
	,get_width: function() {
		return this._width;
	}
	,__class__: apix.common.tools.math.Rectangle
});
apix.common.util = {}
apix.common.util.ArrayExtender = function() { }
apix.common.util.ArrayExtender.__name__ = true;
apix.common.util.ArrayExtender.objectOf = function(arr,val,key) {
	if(key == null) key = "id";
	var ret = { object : { }, index : null};
	var i = -1;
	var _g = 0;
	while(_g < arr.length) {
		var o = arr[_g];
		++_g;
		i++;
		if(Reflect.field(o,key) == val) {
			ret = { object : o, index : i};
			break;
		}
	}
	return ret;
}
apix.common.util.Global = function() {
};
apix.common.util.Global.__name__ = true;
apix.common.util.Global.get_mouseClock = function() {
	if(apix.common.util.Global._mouseClock == null) haxe.Log.trace("f::Mouse Clock isn't enabled ! ",{ fileName : "Global.hx", lineNumber : 62, className : "apix.common.util.Global", methodName : "get_mouseClock"});
	return apix.common.util.Global._mouseClock;
}
apix.common.util.Global.get = function() {
	if(apix.common.util.Global._instance == null) apix.common.util.Global._instance = new apix.common.util.Global();
	return apix.common.util.Global._instance;
}
apix.common.util.Global.flnetTrace = function(v,i) {
	var str = Std.string(v);
	var len = str.length;
	if(len > 2 && HxOverrides.substr(str,1,2) == "::") {
		if(HxOverrides.substr(str,0,1) == "e" || HxOverrides.substr(str,0,1) == "f") {
			var d = js.Browser.document.getElementById("flnet:error");
			if(d != null) {
				str = "<br/>error " + (i != null?"in " + i.fileName + " line " + i.lineNumber:"") + " : " + HxOverrides.substr(str,3,len - 3) + "<br/>";
				d.innerHTML += str + "<br/>";
				throw "fl.net error. See red message in page.";
			} else if(HxOverrides.substr(str,0,1) == "f") {
				var msg = "";
				v = HxOverrides.substr(str,3,len - 3);
				if(js.Browser.document.getElementById("haxe:trace") != null) msg = "fl.net error. See message in page."; else msg = "fl.net error. See last message above.";
				js.Boot.__trace(v,i);
				throw msg;
			}
		} else if(HxOverrides.substr(str,0,1) == "i") {
			str = "<br/>notice in " + (i != null?i.fileName + ":" + i.lineNumber:"") + "<br/>" + HxOverrides.substr(str,3,len - 3);
			var d = js.Browser.document.getElementById("flnet:info");
			if(d != null) d.innerHTML += str + "<br/>";
		}
	} else {
		str = "<br/>notice in " + (i != null?i.fileName + ":" + i.lineNumber:"") + "<br/>" + str;
		var d = js.Browser.document.getElementById("flnet:info");
		if(d != null) d.innerHTML += str + "<br/>"; else js.Boot.__trace(v,i);
	}
}
apix.common.util.Global.prototype = {
	get_isMobile: function() {
		return new EReg("iPhone|ipad|iPod|Android|opera mini|blackberry|palm os|palm|hiptop|avantgo|plucker|xiino|blazer|elaine|iris|3g_t|opera mobi|windows phone|iemobile|mobile".toLowerCase(),"i").match(apix.common.display.Common.get_userAgent().toLowerCase());
	}
	,setupTrace: function(ctnrId) {
		var ctnr;
		if(this.empty(ctnrId)) ctnr = apix.common.display.Common.get_body(); else ctnr = js.Browser.document.getElementById(ctnrId);
		if(ctnr != null) {
			if(js.Browser.document.getElementById("flnet:error") == null) ctnr.innerHTML += "<div id='flnet:error' style='font-weight:bold;color:#900;' ></div>";
			if(js.Browser.document.getElementById("flnet:info") == null) ctnr.innerHTML += "<div id='flnet:info' style='font-weight:bold;' ></div>";
			haxe.Log.trace = apix.common.util.Global.flnetTrace;
		} else return false;
		return true;
	}
	,strReplace: function(str,from,to) {
		var reg = new RegExp('('+from+')', 'g');;
		str = str.replace(reg,to);;
		return str;
	}
	,empty: function(v) {
		if(v == null) return true;
		if(v.length == 0) return true;
		return false;
	}
	,strVal: function(s,defVal) {
		if(defVal == null) defVal = "";
		if(s == null) return defVal;
		if(s == "") return defVal;
		return s;
	}
	,boolVal: function(b,defVal) {
		if(defVal == null) defVal = false;
		if(b == null) return defVal;
		if(js.Boot.__instanceof(b,String)) {
			if(b == "true") return true; else if(b == "false") return false; else return defVal;
		} else if(js.Boot.__instanceof(b,Float)) {
			if(b == 0) return false; else if(b == 1) return true; else return defVal;
		} else if(js.Boot.__instanceof(b,Bool)) return b;
		return defVal;
	}
	,__class__: apix.common.util.Global
}
apix.common.util.Object = function(o) {
	if(o != null) {
		var arr = Reflect.fields(o);
		var _g1 = 0, _g = arr.length;
		while(_g1 < _g) {
			var i = _g1++;
			var v = Reflect.field(o,arr[i]);
			this.set(arr[i],v);
		}
	}
};
apix.common.util.Object.__name__ = true;
apix.common.util.Object.prototype = {
	forEach: function(f) {
		var len = this.array().length;
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			var k = this.array()[i];
			var v = this.get(k);
			f(k,v,i);
		}
	}
	,empty: function() {
		return this.length() < 1;
	}
	,length: function() {
		return Reflect.fields(this).length;
	}
	,array: function() {
		return Reflect.fields(this);
	}
	,get: function(k) {
		return Reflect.field(this,k);
	}
	,set: function(k,v) {
		this[k] = v;
	}
	,__class__: apix.common.util.Object
}
apix.common.util.StringExtender = function() { }
apix.common.util.StringExtender.__name__ = true;
apix.common.util.StringExtender.all = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = js.Browser.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelectorAll(v);
}
apix.common.util.StringExtender.get = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = js.Browser.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelector(v);
}
apix.common.util.StringExtender.slider = function(v,p) {
	if(p == null) p = { };
	p.into = v;
	return new apix.ui.slider.Slider(p);
}
apix.ui = {}
apix.ui.UICompo = function() {
	this.g = apix.common.util.Global.get();
	this.compoProp = new apix.common.util.Object();
	this.compoProp.skin = "default";
	this.compoProp.auto = true;
	this.enabled = false;
};
apix.ui.UICompo.__name__ = true;
apix.ui.UICompo.loadInit = function(f) {
	apix.ui.UICompoLoader.__loadInit(f);
}
apix.ui.UICompo.prototype = {
	get_auto: function() {
		return this.g.boolVal(this.compoProp.auto);
	}
	,get_into: function() {
		return this.compoProp.into;
	}
	,get_ctnr: function() {
		if(this.isCreated()) return apix.common.display.ElementExtender.parent(this.element); else if(this.g.strVal(this.get_into()) != "") return apix.common.util.StringExtender.get(this.get_into()); else return null;
	}
	,get_id: function() {
		var v;
		if(this.isCreated()) v = this.element.id; else v = this.g.strVal(this.compoProp.id);
		return v;
	}
	,get_skin: function() {
		return this.g.strVal(this.compoProp.skin);
	}
	,setCompoProp: function(p) {
		var _g = this;
		var o = new apix.common.util.Object(p);
		if(!o.empty()) o.forEach(function(k,v,i) {
			_g.compoProp.set(k,v);
		});
		if(this.isCreated() && this.compoProp.id != this.get_id()) this.element.id = this.compoProp.id;
	}
	,getCompoSkins: function(v) {
		var ret = null;
		var _g = 0, _g1 = this.compoSkinList;
		while(_g < _g1.length) {
			var o = _g1[_g];
			++_g;
			if(o.skinName == v) {
				ret = o;
				break;
			}
		}
		return ret;
	}
	,isInitialized: function() {
		return this.getCompoSkins(this.get_skin()) != null && this.get_ctnr() != null;
	}
	,isCreated: function() {
		return this.element != null && this.g.strVal(this.element.id) != "";
	}
	,create: function() {
		this.element = js.Browser.document.createElement("div");
		if(this.get_id() == "") this.element.id = apix.common.display.Common.get_newSingleId(); else this.element.id = this.get_id();
		apix.common.display.ElementExtender.inner(this.element,this.getCompoSkins(this.get_skin()).skinContent);
		apix.common.util.StringExtender.get(this.get_into()).appendChild(this.element);
		return this;
	}
	,__class__: apix.ui.UICompo
}
apix.ui.UICompoLoader = function() { }
apix.ui.UICompoLoader.__name__ = true;
apix.ui.UICompoLoader.__loadInit = function(f) {
	apix.ui.UICompoLoader.__callBack = f;
	var tmp = js.Browser.document.createElement("div");
	tmp.id = "apix_tmp_ctnr";
	apix.common.display.Common.get_body().appendChild(tmp);
	apix.ui.UICompoLoader.__loadNext();
}
apix.ui.UICompoLoader.__push = function(f,url,skinName) {
	apix.ui.UICompoLoader.__stk.push({ f : f, url : url, skinName : skinName});
}
apix.ui.UICompoLoader.__loadNext = function() {
	if(apix.ui.UICompoLoader.__stk.length > 0) {
		var o = apix.ui.UICompoLoader.__stk.pop();
		o.f(o.url,o.skinName);
	} else {
		apix.common.display.Common.get_body().removeChild(apix.common.util.StringExtender.get("#" + "apix_tmp_ctnr"));
		apix.ui.UICompoLoader.__callBack();
	}
}
apix.ui.UICompoLoader.__onEndLoad = function() {
	apix.ui.UICompoLoader.__loadNext();
}
apix.ui.UICompoLoader.__storeData = function(result) {
	var tmpCtnr = js.Browser.document.getElementById("apix_tmp_ctnr");
	result = apix.common.util.Global.get().strReplace(result,"././././",apix.ui.UICompoLoader.__tmpFromPath);
	apix.common.display.ElementExtender.inner(tmpCtnr,result);
	var tmpStyleEl = tmpCtnr.getElementsByTagName("style")[0];
	var styleContent = tmpStyleEl.textContent;
	tmpCtnr.removeChild(tmpStyleEl);
	var styleElArr = js.Browser.document.getElementsByTagName("style");
	if(styleElArr.length == 0) {
		tmpStyleEl.textContent = styleContent;
		apix.common.display.Common.get_head().appendChild(tmpStyleEl);
	} else {
		var styleEl = styleElArr[0];
		styleEl.textContent += styleContent;
	}
	var el = tmpCtnr.getElementsByClassName("apix_loader_ctnr")[0];
	var skinContent = apix.common.display.ElementExtender.inner(el);
	apix.common.display.ElementExtender.inner(tmpCtnr,"");
	return skinContent;
}
apix.ui.progressBar = {}
apix.ui.progressBar.ProgressBar = function(p) {
	apix.ui.UICompo.call(this);
	this.compoSkinList = apix.ui.progressBar.ProgressBarLoader.__compoSkinList;
	this.setup(p);
	this.pnum = 0;
};
apix.ui.progressBar.ProgressBar.__name__ = true;
apix.ui.progressBar.ProgressBar.init = function(skinName,pathStr) {
	if(skinName == null) skinName = "default";
	apix.ui.progressBar.ProgressBarLoader.__init(skinName,pathStr);
}
apix.ui.progressBar.ProgressBar.__super__ = apix.ui.UICompo;
apix.ui.progressBar.ProgressBar.prototype = $extend(apix.ui.UICompo.prototype,{
	set_into: function(v) {
		this.setup({ into : v});
		return v;
	}
	,onClock: function(c) {
		this.pnum++;
		if(this.pnum == 100) this.clk.stop(); else {
			var bar = apix.common.util.StringExtender.get("#" + this.get_id() + " ." + ("apix_" + "bar"),this.element);
			apix.common.display.ElementExtender.width(bar,this.pnum * 2);
		}
	}
	,enable: function() {
		this.enabled = true;
		this.clk = new apix.common.event.timing.Clock($bind(this,this.onClock));
		return this;
	}
	,setup: function(p) {
		this.setCompoProp(p);
		if(this.isInitialized()) {
			if(!this.isCreated()) this.create();
			if(this.get_auto() && !this.enabled) this.enable();
		}
		return this;
	}
	,__class__: apix.ui.progressBar.ProgressBar
});
apix.ui.progressBar.ProgressBarLoader = function() { }
apix.ui.progressBar.ProgressBarLoader.__name__ = true;
apix.ui.progressBar.ProgressBarLoader.__init = function(skinName,pathStr) {
	if(skinName == null) skinName = "default";
	if(pathStr != null && skinName == "default") haxe.Log.trace("f::Invalid skinName '" + skinName + "' when a custom path is given ! ",{ fileName : "ProgressBar.hx", lineNumber : 123, className : "apix.ui.progressBar.ProgressBarLoader", methodName : "__init"}); else true;
	pathStr = pathStr == null?"apix/default/" + "ProgressBar/":pathStr;
	apix.ui.UICompoLoader.__push(apix.ui.progressBar.ProgressBarLoader.__load,apix.ui.UICompoLoader.baseUrl + pathStr,skinName);
}
apix.ui.progressBar.ProgressBarLoader.__load = function(fromPath,sk) {
	var h = new haxe.Http(fromPath + ("skin." + "html"));
	h.onData = apix.ui.progressBar.ProgressBarLoader.__onData;
	h.request(false);
	apix.ui.UICompoLoader.__tmpSkinName = sk;
	apix.ui.UICompoLoader.__tmpFromPath = fromPath;
}
apix.ui.progressBar.ProgressBarLoader.__onData = function(result) {
	var skinContent = apix.ui.UICompoLoader.__storeData(result);
	apix.ui.progressBar.ProgressBarLoader.__compoSkinList.push({ skinName : apix.ui.UICompoLoader.__tmpSkinName, skinContent : skinContent, skinPath : apix.ui.UICompoLoader.__tmpFromPath});
	apix.ui.UICompoLoader.__onEndLoad();
}
apix.ui.progressBar.ProgressBarLoader.__super__ = apix.ui.UICompoLoader;
apix.ui.progressBar.ProgressBarLoader.prototype = $extend(apix.ui.UICompoLoader.prototype,{
	__class__: apix.ui.progressBar.ProgressBarLoader
});
apix.ui.slider = {}
apix.ui.slider.Slider = function(p) {
	apix.ui.UICompo.call(this);
	this.change = new apix.common.event.EventSource();
	this.selectors = new Array();
	this.compoSkinList = apix.ui.slider.SliderLoader.__compoSkinList;
	this.setup(p);
};
apix.ui.slider.Slider.__name__ = true;
apix.ui.slider.Slider.init = function(skinName,pathStr) {
	if(skinName == null) skinName = "default";
	apix.ui.slider.SliderLoader.__init(skinName,pathStr);
}
apix.ui.slider.Slider.__super__ = apix.ui.UICompo;
apix.ui.slider.Slider.prototype = $extend(apix.ui.UICompo.prototype,{
	get_mouseScaleVector: function() {
		if(this.mouseScaleVector == null) this.mouseScaleVector = new apix.common.tools.math.Vector(this.get_mouseScale(),this.get_mouseScale());
		return this.mouseScaleVector;
	}
	,updateSelector: function(o) {
		var sc = this.get_length() / this.get_bounds().get_length();
		o.pos = !this.get_vertical()?o.xpos:o.ypos;
		o.value = this.get_start() + (o.pos - (!this.get_vertical()?this.get_bounds().get_x():this.get_bounds().get_y())) * sc;
		o.round = function(n) {
			if(n == null) n = 0;
			return apix.common.tools.math.MathX.round(o.value,n);
		};
		return o;
	}
	,get_vertical: function() {
		return this.get_bounds().get_length() == this.get_bounds().get_height();
	}
	,get_multiple: function() {
		return this.selectors.length > 1;
	}
	,get_gap: function() {
		var v;
		if(this.compoProp.gap != null) v = this.compoProp.gap; else v = 5;
		this.compoProp.gap = v;
		return v;
	}
	,get_overlay: function() {
		var v = null;
		if(this.get_multiple()) {
			if(this.compoProp.overlay != null) v = this.compoProp.overlay; else v = false;
			this.compoProp.overlay = v;
		}
		return v;
	}
	,get_length: function() {
		return this.get_end() - this.get_start();
	}
	,get_end: function() {
		var v = null;
		if(this.compoProp.end != null) v = this.compoProp.end; else v = this.get_start() + this.get_bounds().get_length();
		this.compoProp.end = v;
		return v;
	}
	,get_start: function() {
		var v = null;
		if(this.compoProp.start != null) v = this.compoProp.start; else v = !this.get_vertical()?this.get_bounds().get_x():this.get_bounds().get_y();
		this.compoProp.start = v;
		return v;
	}
	,getSelectorBounds: function() {
		var v = this.get_bounds();
		if(this.get_multiple()) {
			if(!this.get_overlay()) {
				var vx = 0.;
				var vy = 0.;
				var w = 0.;
				var h = 0.;
				var prev = this.lastSelectorIndex - 1;
				var next = this.lastSelectorIndex + 1;
				if(this.lastSelectorIndex == 0) {
					vx = this.get_bounds().get_x();
					vy = this.get_bounds().get_y();
					w = this.selectors[next].xpos - vx - (!this.get_vertical()?this.get_gap():0);
					h = this.selectors[next].ypos - vy - (this.get_vertical()?this.get_gap():0);
				} else if(this.lastSelectorIndex == this.selectors.length - 1) {
					vx = this.selectors[prev].xpos + (!this.get_vertical()?this.get_gap():0);
					vy = this.selectors[prev].ypos + (this.get_vertical()?this.get_gap():0);
					w = this.get_bounds().get_x() + this.get_bounds().get_width() - vx;
					h = this.get_bounds().get_y() + this.get_bounds().get_height() - vy;
				} else if(this.lastSelectorIndex > 0 && this.lastSelectorIndex < this.selectors.length - 1) {
					vx = this.selectors[prev].xpos + (!this.get_vertical()?this.get_gap():0);
					vy = this.selectors[prev].ypos + (this.get_vertical()?this.get_gap():0);
					w = this.selectors[next].xpos - vx - (!this.get_vertical()?this.get_gap():0);
					h = this.selectors[next].ypos - vy - (this.get_vertical()?this.get_gap():0);
				} else haxe.Log.trace("f:: Selector index error ! ",{ fileName : "Slider.hx", lineNumber : 278, className : "apix.ui.slider.Slider", methodName : "getSelectorBounds"});
				v = new apix.common.tools.math.Rectangle(vx,vy,w,h);
			}
		}
		return v;
	}
	,get_bounds: function() {
		var r = null;
		if(this.compoProp.bounds != null) r = this.compoProp.bounds; else {
			var b = apix.common.util.StringExtender.get("#" + this.get_id() + " ." + ("apix_" + "bounds"));
			if(b != null) r = new apix.common.tools.math.Rectangle(apix.common.display.ElementExtender.posx(b),apix.common.display.ElementExtender.posy(b),apix.common.display.ElementExtender.width(b),apix.common.display.ElementExtender.height(b)); else if(apix.common.display.ElementExtender.width(this.element) > apix.common.display.ElementExtender.height(this.element)) r = new apix.common.tools.math.Rectangle(0,0,apix.common.display.ElementExtender.width(this.element),0); else r = new apix.common.tools.math.Rectangle(0,0,0,apix.common.display.ElementExtender.height(this.element));
		}
		this.compoProp.bounds = r;
		return r;
	}
	,get_mouseScale: function() {
		if(this.compoProp.mouseScale == null) this.compoProp.mouseScale = 1;
		return this.compoProp.mouseScale;
	}
	,set_into: function(v) {
		this.setup({ into : v});
		return v;
	}
	,onClock: function(e) {
		var elem = e.data.elem;
		this.lastSelector.xpos = apix.common.display.ElementExtender.posx(elem);
		this.lastSelector.ypos = apix.common.display.ElementExtender.posy(elem);
		this.updateSelector(this.lastSelector);
		e = new apix.common.event.StandardEvent(this);
		e.currentSelector = this.lastSelector;
		this.change.dispatch(e);
	}
	,stopDrag: function(e) {
		var el = e.currentTarget;
		if(this.g.get_isMobile()) apix.common.display.ElementExtender.doOnTouchEnd(el);
		apix.common.display.ElementExtender.stopDrag(el);
	}
	,startDrag: function(e) {
		e.preventDefault();
		var el = e.currentTarget;
		if(this.g.get_isMobile()) apix.common.display.ElementExtender.doOnTouchStart(el);
		var o = apix.common.util.ArrayExtender.objectOf(this.selectors,el,"elem");
		this.lastSelector = o.object;
		this.lastSelectorIndex = o.index;
		apix.common.display.ElementExtender.startDrag(el,this.getSelectorBounds(),this.get_mouseScaleVector());
		apix.common.util.Global.get_mouseClock().top.on($bind(this,this.onClock),{ elem : el});
	}
	,enable: function() {
		var arr = apix.common.util.StringExtender.all("#" + this.get_id() + " ." + ("apix_" + "selector"),this.element);
		if(arr.length > 0) {
			var _g = 0;
			while(_g < arr.length) {
				var el = arr[_g];
				++_g;
				this.selectors.push(this.updateSelector({ elem : el, value : null, pos : null, xpos : apix.common.display.ElementExtender.posx(el), ypos : apix.common.display.ElementExtender.posy(el), round : null}));
				apix.common.display.ElementExtender.addLst(el,apix.common.display.ElementExtender.convertEventType("mousedown"),$bind(this,this.startDrag),false,null);
				apix.common.display.ElementExtender.addLst(el,apix.common.display.ElementExtender.convertEventType("mouseup"),$bind(this,this.stopDrag),false,null);
			}
			this.lastSelector = this.selectors[0];
		}
		this.enabled = true;
		return this;
	}
	,setup: function(p) {
		this.setCompoProp(p);
		if(this.isInitialized()) {
			if(!this.isCreated()) this.create();
			if(this.get_auto() && !this.enabled) this.enable();
		}
		return this;
	}
	,round: function(n) {
		if(n == null) n = 0;
		return this.lastSelector.round(n);
	}
	,__class__: apix.ui.slider.Slider
});
apix.ui.slider.SliderLoader = function() { }
apix.ui.slider.SliderLoader.__name__ = true;
apix.ui.slider.SliderLoader.__init = function(skinName,pathStr) {
	if(skinName == null) skinName = "default";
	if(pathStr != null && skinName == "default") haxe.Log.trace("f::Invalid skinName '" + skinName + "' when a custom path is given ! ",{ fileName : "Slider.hx", lineNumber : 378, className : "apix.ui.slider.SliderLoader", methodName : "__init"}); else true;
	pathStr = pathStr == null?"apix/default/" + "Slider/":pathStr;
	apix.ui.UICompoLoader.__push(apix.ui.slider.SliderLoader.__load,apix.ui.UICompoLoader.baseUrl + pathStr,skinName);
}
apix.ui.slider.SliderLoader.__load = function(fromPath,sk) {
	var h = new haxe.Http(fromPath + ("skin." + "html"));
	h.onData = apix.ui.slider.SliderLoader.__onData;
	h.request(false);
	apix.ui.UICompoLoader.__tmpSkinName = sk;
	apix.ui.UICompoLoader.__tmpFromPath = fromPath;
}
apix.ui.slider.SliderLoader.__onData = function(result) {
	var skinContent = apix.ui.UICompoLoader.__storeData(result);
	apix.ui.slider.SliderLoader.__compoSkinList.push({ skinName : apix.ui.UICompoLoader.__tmpSkinName, skinContent : skinContent, skinPath : apix.ui.UICompoLoader.__tmpFromPath});
	apix.ui.UICompoLoader.__onEndLoad();
}
apix.ui.slider.SliderLoader.__super__ = apix.ui.UICompoLoader;
apix.ui.slider.SliderLoader.prototype = $extend(apix.ui.UICompoLoader.prototype,{
	__class__: apix.ui.slider.SliderLoader
});
haxe.Http = function(url) {
	this.url = url;
	this.headers = new haxe.ds.StringMap();
	this.params = new haxe.ds.StringMap();
	this.async = true;
};
haxe.Http.__name__ = true;
haxe.Http.prototype = {
	onStatus: function(status) {
	}
	,onError: function(msg) {
	}
	,onData: function(data) {
	}
	,request: function(post) {
		var me = this;
		me.responseData = null;
		var r = js.Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if(r.readyState != 4) return;
			var s = (function($this) {
				var $r;
				try {
					$r = r.status;
				} catch( e ) {
					$r = null;
				}
				return $r;
			}(this));
			if(s == undefined) s = null;
			if(s != null) me.onStatus(s);
			if(s != null && s >= 200 && s < 400) me.onData(me.responseData = r.responseText); else if(s == null) me.onError("Failed to connect or resolve host"); else switch(s) {
			case 12029:
				me.onError("Failed to connect to host");
				break;
			case 12007:
				me.onError("Unknown host");
				break;
			default:
				me.responseData = r.responseText;
				me.onError("Http Error #" + r.status);
			}
		};
		if(this.async) r.onreadystatechange = onreadystatechange;
		var uri = this.postData;
		if(uri != null) post = true; else {
			var $it0 = this.params.keys();
			while( $it0.hasNext() ) {
				var p = $it0.next();
				if(uri == null) uri = ""; else uri += "&";
				uri += StringTools.urlEncode(p) + "=" + StringTools.urlEncode(this.params.get(p));
			}
		}
		try {
			if(post) r.open("POST",this.url,this.async); else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question?"?":"&") + uri,this.async);
				uri = null;
			} else r.open("GET",this.url,this.async);
		} catch( e ) {
			this.onError(e.toString());
			return;
		}
		if(this.headers.get("Content-Type") == null && post && this.postData == null) r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var $it1 = this.headers.keys();
		while( $it1.hasNext() ) {
			var h = $it1.next();
			r.setRequestHeader(h,this.headers.get(h));
		}
		r.send(uri);
		if(!this.async) onreadystatechange(null);
	}
	,__class__: haxe.Http
}
haxe.Log = function() { }
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
}
haxe.ds = {}
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = true;
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,__class__: haxe.ds.StringMap
}
var js = {}
js.Boot = function() { }
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = i != null?i.fileName + ":" + i.lineNumber + ": ":"";
	msg += js.Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0, _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js.Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof(console) != "undefined" && console.log != null) console.log(msg);
}
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0, _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
}
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) {
					if(cl == Array) return o.__enum__ == null;
					return true;
				}
				if(js.Boot.__interfLoop(o.__class__,cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
}
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
}
js.Browser = function() { }
js.Browser.__name__ = true;
js.Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") return new XMLHttpRequest();
	if(typeof ActiveXObject != "undefined") return new ActiveXObject("Microsoft.XMLHTTP");
	throw "Unable to create XMLHttpRequest object.";
}
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; };
Math.__name__ = ["Math"];
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i) {
	return isNaN(i);
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.prototype.__class__ = Array;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
apix.common.display.Common.__nextSingleId = -1;
apix.common.display.ElementExtender.dragArray = [];
apix.ui.UICompoLoader.__stk = new Array();
apix.ui.UICompoLoader.baseUrl = "./";
apix.ui.progressBar.ProgressBarLoader.__compoSkinList = new Array();
apix.ui.slider.SliderLoader.__compoSkinList = new Array();
js.Browser.window = typeof window != "undefined" ? window : null;
js.Browser.document = typeof window != "undefined" ? window.document : null;
js.Browser.navigator = typeof window != "undefined" ? window.navigator : null;
Main.main();
})();
