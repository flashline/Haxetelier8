(function () { "use strict";
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
var Main = function() {
	apix.common.util.Global.get().setupTrace();
	var i = 5;
	var s;
	"Hello les " + i + Std.string(js.Lib.alert(" gars"));
	haxe.Log.trace("1.12e-5=" + StringX.toFloat("1.12e-5"),{ fileName : "StringX.hx", lineNumber : 12, className : "StringX", methodName : "trace"});
	s = "0xFF";
	haxe.Log.trace(s + "=" + StringX.toFloat(s),{ fileName : "StringX.hx", lineNumber : 12, className : "StringX", methodName : "trace"});
	haxe.Log.trace("f hexa =" + StringX.toFloat("f",16),{ fileName : "StringX.hx", lineNumber : 12, className : "StringX", methodName : "trace"});
	haxe.Log.trace(StringX.splitx("bateau,ciseaux,torro,sacramento",","),{ fileName : "Main.hx", lineNumber : 41, className : "Main", methodName : "new"});
	var _g = 0, _g1 = apix.common.util.StringExtender.all(".toto");
	while(_g < _g1.length) {
		var el = _g1[_g];
		++_g;
		el.innerHTML = "FOO";
	}
	apix.common.util.StringExtender.on(".toto","click",$bind(this,this.onClick),null,{ txt : "TOTO"});
};
Main.__name__ = true;
Main.main = function() {
	new Main();
}
Main.prototype = {
	onClick: function(e,data) {
		var elem = js.Boot.__cast(e.currentTarget , Element);
		elem.innerHTML = data.txt;
	}
	,__class__: Main
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
var StringX = function() { }
StringX.__name__ = true;
StringX.toFloat = function(s,base) {
	if(base == null) base = 10;
	if(s.substring(0,2) == "0x") return Number(s) ;
	if(base == 16) return Number('0x'+s) ;
	return Std.parseFloat(s);
}
StringX.splitx = function(s,delim) {
	var arr = s.split(delim);
	arr.splice(0,0,"--- Choix d'un texte ---");
	return arr;
}
var apix = {}
apix.common = {}
apix.common.display = {}
apix.common.display.Common = function() { }
apix.common.display.Common.__name__ = true;
apix.common.display.Common.get_body = function() {
	return js.Browser.document.body;
}
apix.common.display.Common.get_userAgent = function() {
	return js.Browser.navigator.userAgent;
}
apix.common.display.ElementExtender = function() { }
apix.common.display.ElementExtender.__name__ = true;
apix.common.display.ElementExtender.handCursor = function(el,v) {
	if(v == null) v = true;
	var str;
	if(v) str = "pointer"; else str = "auto";
	el.style.cursor = str;
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
apix.common.event = {}
apix.common.event.StandardEvent = function() { }
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
apix.common.util = {}
apix.common.util.Global = function() {
};
apix.common.util.Global.__name__ = true;
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
	,empty: function(v) {
		if(v == null) return true;
		if(v.length == 0) return true;
		return false;
	}
	,__class__: apix.common.util.Global
}
apix.common.util.StringExtender = function() { }
apix.common.util.StringExtender.__name__ = true;
apix.common.util.StringExtender.on = function(v,type,listenerFunction,b,data,parent) {
	if(b == null) b = false;
	var nl;
	nl = apix.common.util.StringExtender.all(v,parent);
	var _g = 0;
	while(_g < nl.length) {
		var el = nl[_g];
		++_g;
		apix.common.display.ElementExtender.addLst(el,apix.common.display.ElementExtender.convertEventType(type),listenerFunction,b,data);
	}
}
apix.common.util.StringExtender.all = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = js.Browser.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelectorAll(v);
}
var haxe = {}
haxe.Log = function() { }
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
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
js.Lib = function() { }
js.Lib.__name__ = true;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
}
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; };
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
js.Browser.document = typeof window != "undefined" ? window.document : null;
js.Browser.navigator = typeof window != "undefined" ? window.navigator : null;
Main.main();
})();
