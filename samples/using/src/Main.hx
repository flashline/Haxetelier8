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
import js.Browser;
import js.html.Element;
import js.html.Event;
//
using StringX;
using apix.common.display.NodeExtender;
//using apix.common.display.ElementExtender ;
using apix.common.util.FloatExtender ;
//
//
//
//
/**
 * using de la classe qui "étend" String -même syntaxe qu'un import.
 */
using apix.common.util.StringExtender ;
// 
//
class Main {
	function new () {	
		Global.get().setupTrace();
		//					
		//		
		// Exemples réels dans programme appelant.
		//
		// VOIR sample/using/bin/index.html avant exécution. Ouvrir Chrome dev tools quand démo.
		//
		// get()
		"#appliEmbedCtnr".get().appendChild(Browser.document.createDivElement()).setAttribute("class", "title");
		//
		"#appliEmbedCtnr .title".get().textContent = "SALUT LES HAXEURS FOUS";
		//
		//
		// all()
		for (el in ".toto".all()) { el.innerHTML = "FOO"; }
		//
		//
		// on() 
		".toto".on("click", onClick, { txt:"TOTO" } );
		//
		// Voir rapidement sample/UIComposrc/Main.hx
		//
		//
		// Exemples haxetelier 8
		//
		/*
		var s:String;
		//alert et trace
		"Hello les gars".alert();
		"Hello les gars".trace();
		//toFloat
		("1.12e-5=" 			+ "1.12e-5".toFloat()).trace();	
		//
		("0xFF=" 				+ "0xFF".toFloat()).trace();	
		//
		("F hexa =" 			+ "f".toFloat(16)).trace();		
		//
		//splitx
		trace("bateau,ciseaux,torro,sacramento".splitX(",")) ;
		//
		// transforme un flottant en string de n'importe quelle base.
		var fn:Float = 255.32;
		trace(fn.string(16));
		trace(fn.string(8));
		trace(fn.string(2));
		// VOIR la ligne "using" (ci-dessus). 
		*/ 
		//
		// VOIR samples/classes/Apix/apix/common/util/StringExtender.hx
		//
		//
	}
	function onClick (e:Event,data:Dynamic) {  
		var elem:Element = cast(e.currentTarget, Element);
		elem.innerHTML = data.txt;
	}	
	static function main() {  
		new Main();
	}	
	
}
