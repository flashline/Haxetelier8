// Exemple pour étendre String.
//
// 1 - Créer une classe standard haxe
// 2 - Usage pour le nom : on ajoute toujours le même suffixe. Ex: ...Helper, ...Extender ou X
// 3 - Créer des fonctions static (méthodes de classes) et public ; dont le 1er paramètre est du type de la classe qu’on souhaite étendre.

class StringX {		
	public static inline function show (s:String) {
		js.Lib.alert(s);
	}
	public static inline function trace (s:String) {
		trace(s);
	}
	// fonction avec parametre supplémentaire
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
	// REMARQUE : On ne peut pas avec "using" surcharger une méthode existante.
	// 			  on peut juste ajouter une méthode similaire. Ex: s.splitx() pour split
	public static function splitx (s:String,delim:String) :Array<String> {				
		var arr:Array<String>=s.split(delim);
		arr.insert(0, "--- Choix d'un texte ---");
		return arr;
	}
}
// 4 - VOIR:  ./Main.hx pour "using StringX" dans le prog appelant.
// 
