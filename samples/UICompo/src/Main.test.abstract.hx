/**
 * Copyright (c) jm Delettre.
 */
/**
* app root package
*/
package;
/**
* classes imports
*/

/**
* root class
*/
import apix.common.event.StandardEvent;
class Main {

	function new () {
		
	}
	
	//	
	static function main() {  
		var s:StringX = new StringX("toto ");
		trace(s);
		trace(s++); 
		trace(s * 3);
		trace(3 * s);
		
		//
		var a = new StringOrInt("foo");
		trace(a.getString());
		var b = new StringOrInt(1);
		trace(b.getInt());
		//
		 var a:Array<Dynamic> = [1, "foo"];
	}	
}





abstract StringX(String) {
	
	  public inline function new(s:String) {
		  this = s; 
	  }
	
	  @:op(A++) public inline function plusplus() {
		  this = this + this;
		return  this;
   }
	
  @:commutative @:op(A * B)
  public function repeat(rhs:Int):StringX {
    var s:StringBuf = new StringBuf();
    for (i in 0...rhs)
      s.add(this);
    return new StringX(s.toString());
  }  
}

abstract StringOrInt<T>(T) from T {
  public function new(t:T) this = t;

  function get() return this;

  static public function getString(v:StringOrInt<String>):String {
    return v.get();
  }
  static public function getInt(v:StringOrInt<Int>):Int {
    return v.get();
  }
  
}
