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
//
// ***********
using StringX;
// ***********
//
//
using apix.common.display.ElementExtender ;
using apix.common.util.StringExtender ;
// ************
class Main {
	function new () {	
		Global.get().setupTrace();
		//
		// Principe		
		//
		//
		// Exemples réels
		// VOIR sample/using/bin/index.html avant exécution. Puis Chrome dev tool.
		//
		// get()
		"#appliEmbedCtnr".get().addChild(Browser.document.createDivElement()).setAttribute("class", "title");
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
		//
		// Exemples haxetelier 8
		//
		var i = 5;
		var s:String;
		//show
		("Hello les "+i+" gars").trace();
		//toFloat
		("1.12e-5=" + "1.12e-5".toFloat()).trace();	
		//
		s = "0xFF"; (s + "=" + s.toFloat()).trace();	
		//
		("F hexa =" + "f".toFloat(16)).trace();		
		//
		//splitx
		trace("bateau,ciseaux,torro,sacramento".splitX(",")); 
		//
		//
		// Retour sur .odp
		/**/
	}
	function onClick (e:Event,data:Dynamic) {  
		var elem:Element = cast(e.currentTarget, Element);
		elem.innerHTML = data.txt;
	}	
	static function main() {  
		new Main();
	}	
	
}
