// Exemple pour �tendre String.
//
// 1 - Cr�er une classe standard haxe
// 2 - Usage pour le nom : on ajoute toujours le m�me suffixe. Ex: ...Helper, ...Extender ou X
// 3 - Cr�er des fonctions static (m�thodes de classes) et public ; dont le 1er param�tre est du type de la classe qu�on souhaite �tendre.

class StringX {		
	public static inline function show (s:String) {
		js.Lib.alert(s);
	}
	public static inline function trace (s:String) {
		trace(s);
	}
	// fonction avec parametre suppl�mentaire
	public static function toFloat (s:String, ?base:Int = 10) {				
		if (s.substring(0, 2) == "0x" ) {			
			return untyped __js__("Number(s) ") ;
		}
		if (base == 16) {			
			return untyped __js__("Number('0x'+s) ") ;
		}		
		return Std.parseFloat(s);
	}
	// parler de inline si on a le temps.
	//
	// REMARQUE : On ne peut pas avec "using" surcharger une m�thode existante.
	// 			  on peut juste ajouter une m�thode similaire. Ex: s.splitx() pour split
	public static function splitx (s:String,delim:String) :Array<String> {				
		var arr:Array<String>=s.split(delim);
		arr.insert(0, "--- Choix d'un texte ---");
		return arr;
	}
}
// 4 - VOIR:  ./Main.hx pour "using StringX" dans le prog appelant.
// 
