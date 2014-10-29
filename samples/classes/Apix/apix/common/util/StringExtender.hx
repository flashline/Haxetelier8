/**
* Exemple pour "�tendre" String.
* Syntaxe:
* 1 - Cr�er une classe standard haxe
* 2 - Usage : nom de la class native auquel on ajoute toujours le m�me suffixe. 
* 		Ex: ...Helper, ...Extender 
* 3 - Cr�er des fonctions static (m�thodes de classes) et public ; 
*     dont le 1er param�tre est du type de la classe qu�on souhaite �tendre. 
*/
package apix.common.util ;
import apix.ui.slider.Slider;
import apix.ui.slider.Slider.SliderProp;
import js.Browser;
import js.html.Element;
import js.html.NodeList;
using apix.common.display.ElementExtender;
using apix.common.util.StringExtender;
/**
 * extends String usage in caller : using apix.common.util.StringExtender;
 */
class StringExtender  {
	static public var rootHtmlElement:Element;
	/**
	 *
	 * Si on consid�re que la String contient de la syntaxe CSS (syst�me utilis� par jQuery ...et JS � pr�sent) :
	 * 
	 * on() est un alias d'un addEventListener s'appliquant � tous les "Element" correspondant � la String CSS.
	 * 
	 * un objet Dynamic ou typ� (typDef) peut �tre pass� en param�tre, qui sera transmis � la fonction "listener".
	 * (N'existe pas en JS ni en As3. Existe en jQuery)
	 * 
	 *
	 *  "div.menu".on("click",onClick,false,data) ; 
	 *   // pose le listener "onClick" sur toutes les div de classe CSS "menu" // en passant un objet dynamic "data"
	 *  ...
	 *  function onClick (e:Event,data:Dynamic) {...}
	 * 
	 * Le corps de la fonction est assez court car  
	 * une m�thode on() a aussi �t� ajout�e � Element ;
	 * 
	 * @param	v					String instance -css syntax
	 * @param	type							Event type
	 * @param	listenerFunction				listener function
	 * @param	?b								use capture true/false
	 * @param	?data				Dynamic or typdef parameter to listener
	 * @param	?parent=null		[Root Element] used to embed app in any html pages.
	 * 
	 * @usage 	"div.menu".on("click",onClick,false,data) ; 	 
	 */
	public static function on (v:String,type:String, listenerFunction:Dynamic, ?b:Bool = false, ?data:Dynamic = null,?parent=null) {
		var arr:Array<Element>;	
		arr = all (v, parent);	// arr = v.all(parent) ; // 
		for (el in arr) {
			el.on(type, listenerFunction, b, data);
		}
	}
	/**
	 * off() est l'alias de removeEventListener et le pendant de on()
	 * NB: Doit imp�rativement �tre utilis� si le param�tre "data" a �t� utilis�. 
	 *     Sinon on() est compatible avec removeEventListener()
	 * 
	 * @param	v					String instance -css syntax
	 * @param	type							Event type
	 * @param	listenerFunction				listener function
	 * @param	?b								use capture true/false
	 * @param	?parent=null		[Root Element] used to embed app in any html pages.
	 * 
	 * @usage 	"div.menu".off("click",onClick,false) ; 
	 */
	public static function off (v:String,type:String, listenerFunction:Dynamic, ?b:Bool = false, ?parent=null) {
		var arr:Array<Element>;
		arr = all (v, parent);	
		for (el in arr) {
			el.off(type, listenerFunction, b);
		}
	}
	/**
	 * Renvoie un tableau d'�lements "HtmlElement" correspondant � la String CSS.
	 * Cette m�thode est public mais sera plut�t utilis�e en interne -rarement utilis�e par les programmes appelants.
	 *   cf: on() et off()
	 * 
	 * @param	v				String instance -css syntax
	 * @param	?parent = null	[Root Element]
	 * @return					an Array of Element
	 * 
	 * @usage 	for (el in ".toto".all()) { el.innerHTML = "FOO"; }
	 */
	public static function all (v:String, ?parent = null) :Array<Element> {
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;
		//
		return untyped parent.querySelectorAll(v);	
	}
	/**
	 * Renvoie un l'�lement "HtmlElement" correspondant � la String CSS.
	 * 
	 * 
	 * @param	v				String instance -css syntax
	 * @param	?parent = null	[Root Element]
	 * @return					an Element
	 * 
	 * @usage 	"#appliEmbedCtnr .title".get().textContent = "Hello !";	
	 */
	public static function get (v:String,?parent=null):Element{
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;	
		//
		var el:Element = untyped parent.querySelector(v) ;
		//
		if (el == null) trace ("f::Element is null !"); 
		return el ;
	}
	public static inline function alert (s:String) {
		js.Lib.alert(s);
	}
	public static inline function trace (s:String) {
		trace(s);
	}
	//
	//
	// UICompo
	//
	//	
	/**
	 * �quivalent � new Slider()
	 *		ex:  "#sliderCtnrId".slider(); // renvoie l'instance du Slider cr�e dans l'�l�ment d'id "sliderCtnrId"
	 *			remplace :
	 *			var s= new Slider();
	 *			s.into="#sliderCtnrId" ;
	 * 
	 * @param	v	String instance -css syntax
	 * @param	?p 	Slider properties typdef
	 * @return 		instance of Slider
	 * 
	 * @usage	var s:Slider = "#sliderVertiCtnrId".slider() ; ~ var s:Slider = new Slider( { into:"#sliderVertiCtnrId"  } )
	 */
	public static function slider (v:String,?p:SliderProp) :Slider {
		if (p == null) p = { };
		p.into = v;
		return new Slider	(p); 
	}
	/**
	* [ VOIR:  samples/UICompo/src/Main.hx ]
	*/
/**
* REMARQUES
* 
* Cette classe "using" remplace l'essentiel de ce que j'utilisais dans jQuery. - gain important en bytes !!-
* 
* - Une classe Using peut en contenir un autre using ... ! -ou plusieurs.
* 
* - On peut avoir plusieurs classes "using" pour une m�me classe native. 
* 
* - La fonction on() utilise elle-m�me la fonction all()... Attention: arr = v.all(parent); // ERREUR  mais:	arr = all (v, parent); // CORRECT	
		
* 
* - On ne peut pas avec "using", simuler l'override (surcharge) d'une m�thode existante. Ex: l'ajout d'une m�thode split n'aurait aucun effet.
*   on peu juste faire :
*/
	/*
	public static function splitX (s:String,delim:String) :Array<String> {				
		var arr:Array<String>=s.split(delim);
		arr.insert(0, "--- Choix d'un texte ---");
		return arr;
	}
	*/
}

//
//
/**
* RETOUR ODP ...
*/





