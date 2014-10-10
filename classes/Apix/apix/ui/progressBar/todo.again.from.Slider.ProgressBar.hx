package apix.ui.progressBar;
//
import apix.ui.UICompo.UICompoLoader;
//
import apix.ui.UICompo.CompoProp;
import apix.ui.UICompo;
import haxe.Http; 
import js.Browser;
import js.html.Element;
//
typedef ProgressBarProp = { 
	> CompoProp ,
	?autoStart:Bool, 		//=false
	?vertical:Bool, 		//=false
} 
//
class ProgressBar extends UICompo    { 
	//
	/**
	* constructor
	*/
	public function new (?p:ProgressBarProp) {
		super(); 
		htmlCompoList = ProgressBarLoader.__htmlCompoList;
		setProp(p);		
		if (isInitialized()) create();
	}
	public function setProp (?p:ProgressBarProp) {	
		setCompoProp(p);
	}
	//
	//
	//
	/**
	 * static public  
	 */
	public static function init (?skinName = "default", ?pathStr:String)  {
		ProgressBarLoader.__init(skinName,pathStr);
	}
	
}
//
//
//
//
//
//
/**
 * static class to loadinit ProgressBar
 */


class ProgressBarLoader extends UICompoLoader   { 
	static public	var __htmlCompoList:Array<CompoSkin> = new Array() ;
	//
	static  		var path:String = "ProgressBar/" ;	
	//
	static 			var __tmpSkinName:String  ;
	static 			var __tmpFromPath:String  ;	
	//
	/**
	 * public static 
	 */
	static public function __init (?skinName = "default", ?pathStr:String)  {
		pathStr != null && skinName == "default" ? trace("f::Invalid skinName '" + skinName + "' when a custom path is given ! ") : true ;
		pathStr= pathStr==null ? UICompoLoader.defaultPath + ProgressBarLoader.path : pathStr ; 
		UICompoLoader._push( ProgressBarLoader.__load,UICompoLoader.baseUrl+pathStr,skinName) ;
	}
	/**
	 * private static
	 */
	static function __load (fromPath:String,sk:String)  {
		var h:Http = new Http(fromPath + "skin.html");
		h.onData = __onData;	
		h.request(false);
		ProgressBarLoader.__tmpSkinName = sk;
		ProgressBarLoader.__tmpFromPath = fromPath;		
	}
	static function __onData (result:String)  {
		var tmpCtnr=Browser.document.getElementById("apix_tmp_ctnr");
		tmpCtnr.innerHTML = result;
		var tmpStyleEl = tmpCtnr.getElementsByTagName("style")[0];
		var styleContent = tmpStyleEl.textContent ;
		styleContent = __strReplace(styleContent, UICompoLoader.TMP_IMG_URL_PREFIX, ProgressBarLoader.__tmpFromPath ) ;
		tmpCtnr.removeChild(tmpStyleEl);
		var styleElArr = Browser.document.getElementsByTagName("style");
		if (styleElArr.length == 0) {
			tmpStyleEl.textContent = styleContent ;
			Browser.document.head.appendChild(tmpStyleEl);
		} else {
			var styleEl = styleElArr[0];
			styleEl.textContent+=styleContent;		
		}
		var htmlContent=cast(tmpCtnr.getElementsByClassName("apix_loader_ctnr")[0],Element).innerHTML;
		ProgressBarLoader.__htmlCompoList.push({skinName:ProgressBarLoader.__tmpSkinName,skinContent:htmlContent,skinPath:ProgressBarLoader.__tmpFromPath}); 		
		tmpCtnr.innerHTML = "";		
		/*for (i in ProgressBarLoader.__htmlCompoList) {trace("skin=\n" + i.skinName);trace("html=\n" + i.skinContent);}}*/
		UICompoLoader.__onEndLoad();		
	}
	static function __strReplace (str:String,from:String,to:String ) :String {
		var reg = untyped __js__ ("new RegExp('('+from+')', 'g');");
		str = untyped __js__ ("str.replace(reg,to);");
		return str;
	}
}
