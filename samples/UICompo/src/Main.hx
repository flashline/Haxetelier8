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

import apix.common.event.StandardEvent;
import apix.common.util.Global;
import apix.ui.slider.Slider.Selector;
import js.html.Element;
import apix.ui.progressBar.ProgressBar;
import apix.ui.slider.Slider;
import apix.ui.UICompo;
/**
* root class
*/
import apix.common.util.StringExtender ; using apix.common.util.StringExtender;
import apix.common.display.ElementExtender ; using apix.common.display.ElementExtender;
class Main {
	var mySlider:Slider;var sliderVerti:Slider;var slider3:Slider;
	var g:Global;
	function new () {
		g=Global.get();
		g.setupTrace();
		trace("i::Component loaded !!");
		//g.alert("test alert");
		start();
	}
	function start () {
		var s:Slider = new Slider	({
								id:"mySlider"
								,auto:false
								,start: -10.5
								,end:12.25	
								,gap:8	
								//,mouseScale:.8
								//,overlay:true
							});
		s.into = "#slidersCtnrId";
		s.enable();
		s.change.on(onSliderChange);
		mySlider = s;
		// must using apix.common.util.StringExtender; to use this syntax//
		// same as new Slider:
		// "#slidersCtnrId".slider() ;	
		
		"#sliderVertiCtnrId".slider( { skin:"skinVerti"  } ).change.on(onSliderVertiChange);	
		// or
		slider3 = "#slider3CtnrId".slider( { skin:"skin3" ,start: -1,end:1} ) ; //  .change.on(onSliderChange);		
		slider3.change.on(onSlider3Change);
		
		// ctnr is already into index.html then no extern skin is necessary !
		"#sliderToBeAttachedId".get().visible(false) ;
		//"#sliderToBeAttachedId".get().visible(true); new Slider().attach("#sliderToBeAttachedId".get()).enable();
		
		var p = new ProgressBar(); p.into = "#progressCtnrId";
	}	
	function onSliderChange (e:StandardEvent) {
		//var s:Selector = e.currentSelector;
		//"#mySlider-sel-0".get().textContent = (Std.string(s.value));
		//"#mySlider-sel-2".get().textContent = (Std.string(s.round(4)));		
		//or		
		//"#mySlider-sel-0".get().textContent = (Std.string(mySlider.value));
		//"#mySlider-sel-1".get().textContent = (Std.string(mySlider.round(2)));
		
		
		"#mySlider-sel-0".get().textContent = (Std.string(mySlider.selectors[0].round(2)));
		"#mySlider-sel-1".get().textContent = (Std.string(mySlider.selectors[1].round(4)));
		"#mySlider-sel-2".get().textContent = (Std.string(mySlider.selectors[2].round(6)));
		
	}
	function onSliderVertiChange (e:StandardEvent) {
		var s:Slider = e.target; // don't change if DCE full
		"#sliderVerti-round".get().textContent = (Std.string(s.round(2)));
	}
	function onSlider3Change (e:StandardEvent) {
		"#slider3-round2".get().textContent = (Std.string(e.target.round(2)));
	}
	//	
	static function main() {  
		Slider.init(); // default skin
		Slider.init("skinVerti", "apix/skinVerti/Slider/");
		Slider.init("skin3", "apix/skin3/Slider/");
		ProgressBar.init();
		UICompo.loadInit( function () { new Main(); } );
	}	
	
}