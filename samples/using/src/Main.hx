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
import apix.common.util.Global;
import js.html.Element;
import js.html.Event;
// ************
using StringX;
//import apix.common.util.StringExtender ;
using apix.common.util.StringExtender ;
// ************
class Main {
	function new () {	
		Global.get().setupTrace();
		//
		// Principe
		//
		var i = 5;
		var s:String;
		//show
		s = "Hello les "+i+" gars";
		s.show();
		//toFloat
		s = "1.12e-5";
		(s+"=" + s.toFloat()).trace();		
		s = "0xFF";
		(s + "=" + s.toFloat()).trace();		
		s = "f";
		(s+" hexa =" + s.toFloat(16)).trace();		
		//splitx
		trace("bateau,ciseaux,torro,sacramento".splitx(",") ); 
		//
		//
		//
		//
		//
		// Exemples r�els
		// all()
		for (el in ".toto".all()) { el.innerHTML="FOO"; }
		// on() 
		".toto".on("click", onClick, { txt:"TOTO" } );
		
	}
	function onClick (e:Event,data:Dynamic) {  
		var elem:Element = cast(e.currentTarget, Element);
		elem.innerHTML = data.txt;
	}	
	static function main() {  
		new Main();
	}	
	
}
