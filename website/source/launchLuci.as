#include "mc_tween2.as"
#include "bomb.as"

import flash.external.*;
import TextField.StyleSheet;
import flash.display.*;
import flash.filters.ColorMatrixFilter;

var launchFromWebsite:Boolean;

if(ExternalInterface.available){
	var response:Object;
	response = ExternalInterface.call("jsAvailable", undefined);
	if(response == null){
		launchFromWebsite = false;
	}
	else{
		launchFromWebsite = true;
	}
}
else{
	launchFromWebsite = false;
}

function debugMessage(x:String){
	ExternalInterface.call("jsDebug",x);
	trace(">> Debug: "+x);
}

debugMessage(">> launch From Website is "+launchFromWebsite);


// init site

/* non-working function to scale. You'll need to work on this if you want it.
function onLoadInit():Void {
	function init(movie:MovieClip) {
		_movie = movie;
	}
	Stage.scaleMode = "noScale";
	var stageListener:Object = new Object();
	stageListener.onResize = function() {
		// sort out stage h+w
		var w = Stage.width;
		var h = Stage.height;
		// position and scale site
		_movie._x = (w-970)/2;
		_movie._y = 0;
		_movie.skyline_mc._y = (h-130);
	};
	Stage.addListener(stageListener);
}
*/

//A constant to use for transitions that should happen instantaneously
var noDuration:Number = 0.001;

// Some positions on the screen
var anchorBGmenu_x:Number=17;
var anchorBGmenu_y:Number=115;
var underSkyline_y:Number=473;

//Set up the menu defaults
	var menuItemsURL:String = "websiteContent/menuItems.xml";
	
	//Clear the generic menuItem
	menuItem_mc.menuItemText_tx.text="";

	//Set up formats for active and inactive menuItems
	var menuTextFormatInactive:Number = 0x000000;
	var menuTextFormatActive:Number = 0xFFFFFF;
	var menuTextFormatNotClickable:Number = 0x555555;

	var textBody_styleSheet:StyleSheet = new StyleSheet();
	var styleObj:Object = new Object();
		styleObj.color = "#5A899D";

		textBody_styleSheet.setStyle("a", styleObj);
		delete(styleObj);

	var sidebarBody_styleSheet:StyleSheet = new StyleSheet();
	var styleObj:Object = new Object();
		styleObj.color = "#AAAAAA";
		sidebarBody_styleSheet.setStyle("p", styleObj);
		styleObj.color = "#FFFFFF";
		sidebarBody_styleSheet.setStyle("a", styleObj);
		delete(styleObj);


var isBodyShrunk:Boolean;
var isSidebarShrunk:Boolean;
var clearCurrentTemplate:Object;

function clearAndResetPage()
{
	// Initialize the stage
	image01_mc._visible=false;
	image02_mc._visible=false;
	image03_mc._visible=false;


	BGmenu_mc._visible=false;
	titleBody_mc._visible=false;		
	titleBody_mc.titleBody_tx.text = "";

	textBody_mc._alpha=0;		
	textBody_mc._visible=true;		

	textBody_mc.textBody_tx._alpha=100;
	textBody_mc.textBody_tx._visible=true;		
	textBody_mc.textBody_tx.html = true;
	textBody_mc.textBody_tx.htmlText = "";
	textBody_mc.textBody_tx.embedFonts=true;
	textBody_mc.textBody_tx.wordWrap = true;
	textBody_mc.textBody_tx.multiline = true;
	textBody_mc.textBody_tx.styleSheet = textBody_styleSheet;


	scrollBar1_mc._visible=false;

	BGsidebar_mc._visible=false;
	titleSidebar_mc._visible=false;		
	titleSidebar_mc.titleSidebar_tx.text = "";

	textSidebar_mc._alpha=0;		
	textSidebar_mc._visible=true;	
	textSidebar_mc.textSidebar_tx.htmlText = "";
	textSidebar_mc.textSidebar_tx.wordWrap = true;
	textSidebar_mc.textSidebar_tx.multiline = true;
	textSidebar_mc.textSidebar_tx.html = true;
	textSidebar_mc.textSidebar_tx.styleSheet = sidebarBody_styleSheet;
	textSidebar_mc.textSidebar_tx._x=0;
	textSidebar_mc.textSidebar_tx._y=0;

	scrollBar2_mc._visible=false;
		
	BGBodyMasked_mc._visible=false;
	whiteBlock_mc._visible=false;

	sectionImage_mc._alpha= 0;
	sectionImage_mc._visible= true;

	sectionTitle_mc._alpha = 0;
	sectionTitle_mc._visible = true;

	sectionData_mc._alpha = 0;
	sectionData_mc._visible = false; 
	sectionData_mc.sectionData_tx._alpha = 100;
	sectionData_mc.sectionData_tx.text = "";
	sectionData_mc.sectionData_tx._visible = true;
	sectionData_mc.sectionData_tx.html = true;
	sectionData_mc.sectionData_tx.htmlText = "";
	sectionData_mc.sectionData_tx.embedFonts=true;
	sectionData_mc.sectionData_tx.wordWrap = true;
	sectionData_mc.sectionData_tx.multiline = true;
	sectionData_mc.sectionData_tx.styleSheet = textBody_styleSheet;
	//sectionData_mc.sectionData_tx.autoSize=true;
	//sectionData_mc._visible = true;

	
	sectionListItem_mc._alpha = 0; 
	sectionListItem_mc._visible = false; 
	sectionListItem_mc.sectionListItem_tx.html = true;
	sectionListItem_mc.sectionListItem_tx.htmlText = "";
	sectionListItem_mc.sectionListItem_tx.embedFonts=true;
	sectionListItem_mc.sectionListItem_tx.wordWrap = true;
	sectionListItem_mc.sectionListItem_tx.multiline = true;
	sectionListItem_mc.sectionListItem_tx.styleSheet = textBody_styleSheet;
	sectionListItem_mc.sectionListItem_tx.autoSize="left";

	dividerVert_mc._visible = false;

	logo_mc._alpha=0;
	logo_mc._visible=true;

	skyline_mc._alpha=0;
	skyline_mc._visible=true;

	isBodyShrunk = true;
	isSidebarShrunk = true;
	clearCurrentTemplate = new Object();
	clearCurrentTemplate.clearFunction= function(){debugMessage(">> No template to clear");};

	turnOffActiveMenuStates();
};
// run it immediately
clearAndResetPage();


function sidebarShrink(bomb:MovieClip,duration:Number)
{
	if(duration == undefined){
		duration = 1.0;
	}

	if(isSidebarShrunk == false){
		textSidebar_mc.tween("_alpha",0,0.1,"linear");
		titleSidebar_mc.tween("_alpha",0,0.1,"linear");

		//This is the orange sidebar
		BGsidebar_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");
		scrollBar2_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");

		lightFusePayload(duration,function(){
			isSidebarShrunk=true;

			textSidebar_mc._visible = false;
			textSidebar_mc.enabled=false;

			titleSidebar_mc._visible = false;
			titleSidebar_mc.enabled=false;

			BGsidebar_mc._visible = false;
			BGsidebar_mc.enabled=false;

			scrollBar2._visible = false;
			scrollBar2.enabled = false;
		});
	}
	else{
		duration = noDuration;
	}

	lightFuseBomb(duration,bomb);
}

function sidebarExpand(bomb:MovieClip,duration:Number)
{
	if(duration == undefined){
		duration = 1.0;
	}

	if(isSidebarShrunk == true){

		//This is the orange sidebar
		BGsidebar_mc._alpha = 0;
		BGsidebar_mc._visible = true;
		BGsidebar_mc.enabled = true;
		BGsidebar_mc.tween(["_y", "_alpha"], [17, 100], duration, "easeOutSine");
	
		scrollBar2._alpha = 0;
		scrollBar2._visible = true;
		scrollBar2.enabled = true;
		scrollBar2_mc.tween(["_y", "_alpha"], [17, 100], duration, "easeOutSine");

		lightFusePayload(duration,function(){
			textSidebar_mc._visible = true;
			textSidebar_mc.enabled=true;

			titleSidebar_mc._visible = true;
			titleSidebar_mc.enabled=true;

			textSidebar_mc.tween("_alpha",100,0.1,"linear");
			titleSidebar_mc.tween("_alpha",100,0.1,"linear");

			isSidebarShrunk=false;
		});
	}
	else{
		duration = noDuration;
	}

	lightFuseBomb(duration,bomb);
}


function initialBuildMenu(bomb:MovieClip,d:Number)
{

var duration:Number = 1.0;

	if(d == undefined){
		duration = 1.0;
	}
	else{
		duration = d;
	}

	//This is the menu on the left
	BGmenu_mc._visible=false;
	BGmenu_mc._alpha=0;
	BGmenu_mc._x=anchorBGmenu_x;
	BGmenu_mc._y=underSkyline_y;
	BGmenu_mc._visible=true;
	BGmenu_mc.tween(["_y", "_alpha"], [anchorBGmenu_y, 100], duration, "easeOutSine");

	BGmenu_mc.menuActive_mc.menuActiveGray_mc._alpha= 0;
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._x= 0;
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._y= underSkyline_y;
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._width= BGmenu_mc._width;
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height= 100;
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._visible= true;

	BGmenu_mc.menuActive_mc.menuActiveOrange_mc._alpha= 0;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc._x= 0;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc._y= underSkyline_y;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc._width= BGmenu_mc._width;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc._visible= true;

	lightFuseBomb(duration, bomb);
}

function initialBuildOrangeSidebar(bomb:MovieClip,duration:Number)
{
	titleSidebar_mc._alpha = 0;
	titleSidebar_mc.titleSidebar_tx._alpha = 100;
	titleSidebar_mc._visible = true;
	titleSidebar_mc.titleSidebar_tx._visible = true;

	textSidebar_mc._alpha = 0;
	textSidebar_mc.textSidebar_tx._alpha = 100;
	textSidebar_mc._visible = true;
	textSidebar_mc.textSidebar_tx._visible = true;

	BGsidebar_mc._visible=false;
	BGsidebar_mc._alpha=0;
	BGsidebar_mc._x=785;
	BGsidebar_mc._y=underSkyline_y;
	BGsidebar_mc._visible=true;

	scrollBar2_mc._visible=false;
	scrollBar2_mc._alpha=0;
	scrollBar2_mc._x=931;
	scrollBar2_mc._y=underSkyline_y;
	scrollBar2_mc._visible=true;

	//Construct scroll bar functionality
	// Click on scoll bar but not on buttons
	scrollBar2_mc.scrollBackground_mc.onRelease=function(){
		var x:Number;

		x= scrollBar2_mc.scrollThumb_mc._y;
		x= (_ymouse -scrollBar2_mc._y) - x;
		textSidebar_mc.textSidebar_tx.onScroller(x);
	}

	textSidebar_mc.textSidebar_tx.onScroller= function(delta)
		{
			var base:Number;
			var step:Number;

			base = scrollBar2_mc.scrollUp_but._y+ scrollBar2_mc.scrollUp_but._height;
			step = (scrollBar2_mc.scrollDown_but._y - base)/(textSidebar_mc.textSidebar_tx.maxscroll+1);

			if(typeof(delta) == typeof(0)){
				var x:Number= textSidebar_mc.textSidebar_tx.scroll + Math.floor(delta/step);
				if(x<1){
					textSidebar_mc.textSidebar_tx.scroll = 1;
				}
				else if(x> textSidebar_mc.textSidebar_tx.maxscroll) {
					textSidebar_mc.textSidebar_tx.scroll = textSidebar_mc.textSidebar_tx.maxscroll;
				}
				else{
					textSidebar_mc.textSidebar_tx.scroll=x;
				}
			}
			else{
				var current:Number;
				current = textSidebar_mc.textSidebar_tx.scroll;
				scrollBar2_mc.scrollThumb_mc.tween(["_y"],[(current-1)*step+base],0.5,"easeOutSine");
			}

			if(textSidebar_mc.textSidebar_tx.maxscroll == 1){
				scrollBar2_mc.scrollUp_but.enabled =false;
	 			scrollBar2_mc.scrollUp_but._alpha=0;
				scrollBar2_mc.scrollThumb_mc.enabled=false;
				scrollBar2_mc.scrollThumb_mc._alpha=0;
				scrollBar2_mc.scrollDown_but.enabled =false;
				scrollBar2_mc.scrollDown_but._alpha=0;
			}
			else{
				scrollBar2_mc.scrollUp_but.enabled =true;
				scrollBar2_mc.scrollUp_but._alpha=100;
				scrollBar2_mc.scrollThumb_mc.enabled=true;
				scrollBar2_mc.scrollThumb_mc._alpha=100;
				scrollBar2_mc.scrollDown_but.enabled =true;
				scrollBar2_mc.scrollDown_but._alpha=100;
			}
	};

	scrollBar2_mc.scrollUp_but.onRelease = function() {
	    textSidebar_mc.textSidebar_tx.scroll--;
	};

	scrollBar2_mc.scrollThumb_mc.onPress = function() {
		scrollBar2_mc.scrollThumb_mc._press_y = _ymouse; 
	};
	scrollBar2_mc.scrollThumb_mc.onReleaseOutside = function() {
		textSidebar_mc.textSidebar_tx.onScroller(_ymouse- scrollBar2_mc.scrollThumb_mc._press_y);
	};
	scrollBar2_mc.scrollDown_but.onRelease = function() {
	    textSidebar_mc.textSidebar_tx.scroll++;
	};

	//Initialize
    textSidebar_mc.textSidebar_tx.onScroller(0);



	sidebarExpand(bomb,duration);
}

function initialBuildCenterPane(bomb:MovieClip,d:Number)
{
	var duration:Number = 2.0;

	if(d == undefined){
		duration = 2.0;
	}
	else{
		duration = d;
	}


	//This is the center pane frame
	BGBodyMasked_mc._visible=false;
	BGBodyMasked_mc._alpha=0;
	BGBodyMasked_mc._x=208;
	BGBodyMasked_mc._y=underSkyline_y;
	BGBodyMasked_mc._visible=true;

	whiteBlock_mc._visible=false;
	whiteBlock_mc._alpha=100;
	whiteBlock_mc._x=208+548;
	whiteBlock_mc._y=underSkyline_y;
	whiteBlock_mc._visible=true;
	whiteBlock_mc.tween(["_y"],[17],duration, "easeOutSine");
	BGBodyMasked_mc.tween([ "_y","_alpha"], [17,100], duration, "easeOutSine");


	//This is the center pane's scrollbar
	isBodyShrunk = true;

	scrollBar1_mc._visible=false;
	scrollBar1_mc._alpha=0;
	scrollBar1_mc._x=757;
	scrollBar1_mc._y=underSkyline_y;
	scrollBar1_mc._visible=true;
	scrollBar1_mc.tween(["_y", "_alpha"], [17, 100], duration, "easeOutSine");

	titleBody_mc._visible=true;		
	titleBody_mc.textBody_tx._visible=true;		
	titleBody_mc._alpha=0;		
	titleBody_mc.textBody_tx._alpha=100;		

	textBody_mc._x=216;
	textBody_mc._y=80;

	textBody_mc.textBody_tx._x=0;
	textBody_mc.textBody_tx._y=0;
	textBody_mc.textBody_tx._width=534;
	textBody_mc.textBody_tx._height=300;

	//Construct scroll bar functionality
	// Click on scoll bar but not on buttons
	scrollBar1_mc.scrollBackground_mc.onRelease=function(){
		var x:Number;

		x= scrollBar1_mc.scrollThumb_mc._y;
		x= (_ymouse -scrollBar1_mc._y) - x;
		textBody_mc.textBody_tx.onScroller(x);
	}

	textBody_mc.textBody_tx.onScroller= function(delta)
		{
			var base:Number;
			var step:Number;

			base = scrollBar1_mc.scrollUp_but._y+ scrollBar1_mc.scrollUp_but._height;
			step = (scrollBar1_mc.scrollDown_but._y - base)/(textBody_mc.textBody_tx.maxscroll+1);

			if(typeof(delta) == typeof(0)){
				var x:Number = textBody_mc.textBody_tx.scroll + Math.floor(delta/step);
				if(x<1){
					textBody_mc.textBody_tx.scroll = 1;
				}
				else if(x> textBody_mc.textBody_tx.maxscroll) {
					textBody_mc.textBody_tx.scroll = textBody_mc.textBody_tx.maxscroll;
				}
				else{
					textBody_mc.textBody_tx.scroll=x;
				}
			}
			else{
				var current:Number;
				current = textBody_mc.textBody_tx.scroll;
				scrollBar1_mc.scrollThumb_mc.tween(["_y"],[(current-1)*step+base],0.5,"easeOutSine");
			}

			if(textBody_mc.textBody_tx.maxscroll == 1){
				scrollBar1_mc.scrollUp_but.enabled =false;
	 			scrollBar1_mc.scrollUp_but._alpha=0;
				scrollBar1_mc.scrollThumb_mc.enabled=false;
				scrollBar1_mc.scrollThumb_mc._alpha=0;
				scrollBar1_mc.scrollDown_but.enabled =false;
				scrollBar1_mc.scrollDown_but._alpha=0;
			}
			else{
				scrollBar1_mc.scrollUp_but.enabled =true;
				scrollBar1_mc.scrollUp_but._alpha=100;
				scrollBar1_mc.scrollThumb_mc.enabled=true;
				scrollBar1_mc.scrollThumb_mc._alpha=100;
				scrollBar1_mc.scrollDown_but.enabled =true;
				scrollBar1_mc.scrollDown_but._alpha=100;
			}
					
	};

	scrollBar1_mc.scrollUp_but.onRelease = function() {
	    textBody_mc.textBody_tx.scroll--;
	};

	scrollBar1_mc.scrollThumb_mc.onPress = function() {
		scrollBar1_mc.scrollThumb_mc._press_y = _ymouse; 
	};
	scrollBar1_mc.scrollThumb_mc.onReleaseOutside = function() {
		textBody_mc.textBody_tx.onScroller(_ymouse- scrollBar1_mc.scrollThumb_mc._press_y);
	};
	scrollBar1_mc.scrollDown_but.onRelease = function() {
	    textBody_mc.textBody_tx.scroll++;
	};

    textBody_mc.textBody_tx.onScroller(0);

	//When animation is complete
	lightFuseBomb(duration, bomb);
}


//ExternalInterface.call("jsDebug","Adding callback was successful : "+ExternalInterface.addCallback("animateOpen", this, animateOpen));
ExternalInterface.addCallback("animateOpen", this, animateOpen);
// site opening animation

function launchMainMenuFromDeepLink(deepLink:String,duration:Number):Boolean
{
	var launched:Boolean = false;
	if(deepLink != undefined){
		var first:String;							
		var last:String;

		if(deepLink.indexOf("&") == -1){
			first = deepLink;
			last = undefined;
		}
		else{
			first = deepLink.substring(0,deepLink.indexOf("&"))
			last = deepLink.substring(deepLink.indexOf("&")+1,deepLink.length);
		}
		for(var i in mainMenu){
			if(mainMenu[i].deepLink == first){
				mainMenu[i].onRelease(last,duration);
				launched = true;
			}
		}
		//If we couldn't find a target for the deepLink, just load
		//up the order 0 item
	}
	return(launched);

}

function animateOpen(deepLink:String)
{
	//ExternalInterface.call("jsDebug", "From inside animateOpen");
	//If we are deepLinking in, make the initial Build Fast!
	var duration:Number;
	//Got to check lots of possibilities based on what any container
	//(Javascript, FlashPlayer) might send
	if((deepLink == undefined)||(deepLink == null) || (deepLink == "null")){
		duration = 1.0;
		//	loadTitle(":"+deepLink+":"+true,false,duration);
	}
	else{
		duration = noDuration;		
		//	loadTitle("^"+deepLink+"^"+false,false,duration);
	}

	logo_mc.tween(["_alpha"],[100],duration,"linear");
	skyline_mc.tween("_alpha",100,duration,"linear");

	initialBuildOrangeSidebar(undefined,duration);

	initialBuildMenu(undefined,duration);

	//When the center pane is done, load the menuitems and fire off the first
	//one
	initialBuildCenterPane(loadBomb(function(){
		loadMenuItems(menuItemsURL,loadBomb(function()
			{
				//Once menuItems are loaded, launch the appropriate section

				for(var i in mainMenu){
					//ExternalInterface.call("jsDebug","Making menu items visible");
					mainMenu[i].menuItemText_tx._alpha=100;
					mainMenu[i].tween("_alpha",100,duration,"linear");
				}
				if(launchMainMenuFromDeepLink(deepLink) == false){
					for(var i in mainMenu){
						if(mainMenu[i].order == 0){
							mainMenu[i].onRelease(undefined,duration);
						}
					}
				}
			}
		));
	}), duration);
}

function jumpToDeepLink(deepLink:String)
{
	launchMainMenuFromDeepLink(deepLink);
}

function jumpToURLSameWindow(URL:String)
{
	debugMessage("Jumping to URL In the Same Window "+URL);
	finalBuild(loadBomb(function(){
		getURL(URL,"_self");
	}));
}

function jumpToURLSameWindowNoFinal(URL:String)
{
	debugMessage("Jumping to URL In the Same Window with no final build out "+URL);
	finalBuild(loadBomb(function(){
		getURL(URL,"_self");
	}),0.05);
}

function jumpToURLNewWindow(URL:String)
{
	debugMessage("Jumping to URL in New Window "+URL);
	getURL(URL,"_blank");
}

function finalBuildMenu(bomb:MovieClip,duration:Number)
{
	if(duration == undefined){
		duration = 0.5;
	}

	BGmenu_mc.menuActive_mc.menuActiveGray_mc.tween("_alpha",0,duration,"linear");
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween("_alpha",0,duration,"linear");
	for(var i in mainMenu){
		mainMenu[i].tween("_alpha",0,duration,"linear");
	}

	//When animation is complete, load menu items, when that's done reveal them
	lightFusePayload(duration, function(){
		BGmenu_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");
		lightFuseBomb(duration,bomb);
	});
}


function finalBuildCenterPane(bomb:MovieClip,duration:Number)
{
	if(duration == undefined){
		duration = 1.0;
	}

	loadTitle("",true,duration);
	loadHTMLText(textBody_mc,textBody_mc.textBody_tx,"",true,duration);

	lightFusePayload(duration, function(){
		scrollBar1_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");
		whiteBlock_mc.tween(["_y"],[underSkyline_y],duration, "easeInSine");
		BGBodyMasked_mc.tween([ "_y","_alpha"], [underSkyline_y,0], duration, "easeInSine");
		image01_mc.tween([ "_y","_alpha"], [underSkyline_y,0], duration, "easeInSine");
		image02_mc.tween([ "_y","_alpha"], [underSkyline_y,0], duration, "easeInSine");
		image03_mc.tween([ "_y","_alpha"], [underSkyline_y,0], duration, "easeInSine");

		//When animation is complete
		lightFuseBomb(duration, bomb);
	});

}

function finalBuildOrangeSidebar(bomb:MovieClip,duration:Number)
{
	sidebarShrink(bomb,duration);
}


function finalBuild(bomb:MovieClip,duration:Number)
{
	if(duration == undefined){
		duration = 0.40;
	}
	
	clearCurrentTemplate.clearFunction();
	finalBuildOrangeSidebar(null,duration);			
	finalBuildMenu(null,duration);
	finalBuildCenterPane(loadBomb(function(){
		logo_mc.tween(["_alpha"],[0],duration,"linear");
		skyline_mc.tween("_alpha",0,duration,"linear");
		lightFuseBomb(duration,bomb);
	}),duration);
}

// parallax
var mouseListener:Object = new Object();
mouseListener.onMouseMove = function() {
	var myX = _xmouse;
	if(myX < 0){
		myX=0;
	}
	if(myX > 1024){
		myX = 1024;
	}
	skyline_mc.skyline1_mc._x = 0-(myX/10);
	skyline_mc.skyline2_mc._x = 0-(myX/20);
	skyline_mc.skyline3_mc._x = 0-(myX/50);
};
Mouse.addListener(mouseListener);


function deSandboxURL(URL:String):String
{
	if(launchFromWebsite == true){
		if(URL.indexOf("myProxy")== -1){
				if(URL.indexOf("http")!= -1){
					//debugMessage("deSandbox returned "+"http://luci.ics.uci.edu/myProxy.php?"+URL);
					return("http://luci.ics.uci.edu/myProxy.php?"+URL);
				}
		}
	}
	//debugMessage("deSandbox returned "+URL);
	return(URL);
}









function turnOffActiveMenuStates(){
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
}

function relocateActiveMenuIndicator(baseY,grayHeight,orangeX,orangeY,orangeWidth)
{
var moveDuration:Number;

	moveDuration = Math.abs(BGmenu_mc.menuActive_mc._y - baseY)/100;
	if(moveDuration > 2.0){
			moveDuration = 2.0;
	}

	BGmenu_mc.menuActive_mc._visible=true;
	BGmenu_mc.menuActive_mc._x=0;

	BGmenu_mc.menuActive_mc.tween(["_alpha","_y"],[100, baseY], moveDuration, "easeInOutSine");

	BGmenu_mc.menuActive_mc.menuActiveGray_mc.tween(["_alpha","_y","_height"],[100,0,grayHeight],moveDuration,"easeInOutSine");

	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_alpha","_x", "_y", "_width"], [100,orangeX, orangeY, orangeWidth],moveDuration , "easeInOutSine");
}



var mainMenu:Array = new Array();
function disableAllMenuItems()
{
	for (i in mainMenu){
		mainMenu[i].enabled=false;
	}
}

function enableAllMenuItems()
{
	for (i in mainMenu){
		mainMenu[i].enabled=true;
	}
}

function enableAllButOneMenuItems()
{
	enableAllMenuItems();
	clearCurrentTemplate.dontEnableMe.enabled=false;
}


function loadMenuItems(url:String,bomb:MovieClip)
{
	debugMessage(">> loaded Menu Items "+mainMenu.length);
	if(mainMenu.length == 0){

		var menuItems:XML = new XML();

		menuItems.ignoreWhite = true;
		menuItems.onLoad = function(success:Boolean){
				if(success){
					//ExternalInterface.call("jsDebug","In menuItems.onLoad with success");
					var uniqueID = 0;
					if(menuItems.firstChild.nodeName == "menuItems"){
						var i:String;
						var myArray:Array = menuItems.childNodes;
						myArray = menuItems.firstChild.childNodes;
						for (i in myArray){
	
							if(myArray[i].nodeName == "menuItem"){
								//ExternalInterface.call("jsDebug","In menuItems.onLoad: menuItem");
	
								//Create a new menu item
								var tempMenuItem_mc = _root.attachMovie("menuItem","menuItem_"+uniqueID.toString()+"_mc", _root.getNextHighestDepth());
								/*if(tempMenuItem_mc == null){
									ExternalInterface.call("jsDebug","In menuItems.onLoad tempMenuItem_mc is null");
								}else{
									ExternalInterface.call("jsDebug","In menuItems.onLoad tempMenuItem_mc is not null");
								}*/
								tempMenuItem_mc._uniqueID = uniqueID++;
								mainMenu.push(tempMenuItem_mc);
	
								tempMenuItem_mc.menuItemText_tx.textColor=menuTextFormatNotClickable;
								tempMenuItem_mc._visible=true;
								tempMenuItem_mc._alpha=0;
								tempMenuItem_mc._x=anchorBGmenu_x + 15;
								tempMenuItem_mc._y=underSkyline_y;
								tempMenuItem_mc.order=99;
								tempMenuItem_mc._indent=0;
	
								var breakBelow:Boolean = false;
								var clickable:Boolean = false;
								tempMenuItem_mc.templateType = "";
								tempMenuItem_mc.templateTitle = "";
								tempMenuItem_mc.templateURL = "";
								tempMenuItem_mc.deepLink = "";
								tempMenuItem_mc.sidebar = false;
								tempMenuItem_mc.sidebarTemplateType = "";
								tempMenuItem_mc.sidebarTemplateTitle = "";
								tempMenuItem_mc.sidebarTemplateURL = "";
								tempMenuItem_mc.enabled = false;
	
								var j:String;
								var myArray2:Array = myArray[i].childNodes;
								for (j in myArray2){
									if(myArray2[j].nodeName == "title"){
										tempMenuItem_mc.menuItemText_tx.embedFonts=true;
										tempMenuItem_mc.menuItemText_tx.autoSize="left";
	
										tempMenuItem_mc.menuItemText_tx.text= myArray2[j].firstChild.nodeValue;
									}
									else if(myArray2[j].nodeName == "order"){
										var index=Number(myArray2[j].firstChild.nodeValue);
										tempMenuItem_mc.order=index;
										tempMenuItem_mc._y=anchorBGmenu_y + 25*index+12;
									}
									else if(myArray2[j].nodeName == "clickable"){
										clickable = true;
										var k:String;
										var myArray3:Array = myArray2[j].childNodes;
										for (k in myArray3){
												if(myArray3[k].nodeName == "template"){
													var l:String;
													var myArray4:Array = myArray3[k].childNodes;
													for (l in myArray4){
														if(myArray4[l].nodeName == "type"){
															tempMenuItem_mc.templateType=myArray4[l].firstChild.nodeValue;
															//debugMessage("Clickable template read from xml "+tempMenuItem_mc.templateType);
														}
														else if(myArray4[l].nodeName == "url"){
															tempMenuItem_mc.templateURL=myArray4[l].firstChild.nodeValue;
														}
														else if(myArray4[l].nodeName == "title"){
															tempMenuItem_mc.templateTitle=myArray4[l].firstChild.nodeValue;
														}
														else{
															trace(">> Unknown XML "+myArray4[l].nodeName) ;
														}
	
													}
												}
												else if(myArray3[k].nodeName == "sidebar"){
													tempMenuItem_mc.sidebar = true;
													var l:String;
													var myArray4:Array = myArray3[k].childNodes;
													for (l in myArray4){
														if(myArray4[l].nodeName == "type"){
															tempMenuItem_mc.sidebarTemplateType=myArray4[l].firstChild.nodeValue;
															//trace(">> sidebarTemplateType "+ tempMenuItem_mc.sidebarTemplateType);
														}
														else if(myArray4[l].nodeName == "url"){
															tempMenuItem_mc.sidebarTemplateURL=myArray4[l].firstChild.nodeValue;
															//trace(">> sidebarTemplateURL "+ tempMenuItem_mc.sidebarTemplateURL);
														}
														else if(myArray4[l].nodeName == "title"){
															tempMenuItem_mc.sidebarTemplateTitle=myArray4[l].firstChild.nodeValue;
															//trace(">> sidebarTemplateTitle "+ tempMenuItem_mc.sidebarTemplateTitle);
														}
														else{
															trace(">> Unknown XML "+myArray4[l].nodeName) ;
														}
													}
												}
												else if(myArray3[k].nodeName == "deepLink"){
													tempMenuItem_mc.deepLink=myArray3[k].firstChild.nodeValue;
												}
												else{
													trace(">> Unknown XML "+myArray3[k].nodeName) ;
												}
										}
									}
									else if(myArray2[j].nodeName == "indent"){
										var howMuch:Number = 10* myArray2[j].firstChild.nodeValue;
										tempMenuItem_mc._indent=howMuch;
										tempMenuItem_mc._x=anchorBGmenu_x + 15+howMuch;
									}	
									else if(myArray2[j].nodeName == "breakBelow"){
										breakBelow=true;
									}	
									else{
									 	trace(">>unknown XML tag:"+ myArray2[j].nodeName);
									}
								}
								if(breakBelow) {
									//Create a new menu item to be the line
									var line_mc = _root.attachMovie("menuItem","menuItem_"+uniqueID.toString()+"_mc", _root.getNextHighestDepth());
									line_mc._uniqueID = uniqueID++;
									line_mc.menuItemText_tx.text= "";
									line_mc._visible=true;
									line_mc._alpha=0;
									line_mc._x=anchorBGmenu_x + 15;
									line_mc._y=anchorBGmenu_y+25*tempMenuItem_mc.order+30;
									line_mc._height=3;
									line_mc.order = tempMenuItem_mc.order+0.5;
									var h:Number = 20;
									line_mc.lineStyle(2.0, 0xFFFFFF, 100);
									line_mc.moveTo(-15, h);
									line_mc.lineTo(BGmenu_mc._width-75,h);
									mainMenu.push(line_mc);
								}
								if(clickable){
										tempMenuItem_mc.menuItemText_tx.textColor=menuTextFormatInactive;
										tempMenuItem_mc.onRelease=function(deepLinkEntry:String,duration:Number){
												debugMessage(">> clicked on:"+ this.templateTitle +" loadingTemplates "+_global.loadingTemplates);
												if(duration == undefined){
													duration = 1.0;
												}

												disableAllMenuItems();
	
	
												////////////////////////////////////////////////////
												//Set up to clear last function and then us later
												////////////////////////////////////////////////////
												clearCurrentTemplate.clearFunction();
	
												var xx = this.templateType;
												var yy:Boolean = this.sidebar;
												var zz = this.sidebarTemplateType;
												var clearDuration:Number = 0.25;
												clearCurrentTemplate.clearFunction = function(){
													debugMessage(">> Clearing Template "+xx+":"+yy+":"+zz);
													if(yy){
														undispatchTemplate(zz,clearDuration);
													}
													undispatchTemplate(xx,clearDuration);
												};
												clearCurrentTemplate.dontEnableMe=this;
												////////////////////////////////////////////////////
	
	
												////////////////////////////////////////////////////
												//Move the menu indicator
												if(this.order == 0){
													relocateActiveMenuIndicator(25*this.order,25+5,17+this._indent,25+3,this._width-1);
												}
												else{
													relocateActiveMenuIndicator(25*this.order+6,25,17+this._indent,25-2,this._width-1);
												}
	
												////////////////////////////////////////////////////
												//Bring in the sidebar and content as necessary
												var a = this.templateType;
												var b = this.templateTitle;
												var c = this.templateURL;
												debugMessage("Setting up click function "+a+":"+b+":"+c+":"+duration+":"+this.sidebar);
												var mainTemplateFunction:Function=function(){
													//Load main content
													dispatchTemplate(a,b,c,undefined,deepLinkEntry,duration);
												};
	
												if(this.sidebar == true){
													var x = this.sidebarTemplateType;
													var y = this.sidebarTemplateTitle;
													var z = this.sidebarTemplateURL;
													var function04= function(){
														dispatchTemplate(x,y,z,undefined,deepLinkEntry,duration);
														unlockMenuChoices();
													};
	
													var function03=function(){
														mainTemplateFunction();
														sidebarExpand(loadBomb(function04),duration);
													};

													//Make this process atomic
													//before a new choice can be
													//made
													lockMenuChoices();

													lightFusePayload(clearDuration,function(){
															bodyShrink(loadBomb(function03));
													});
												}
												else{
													var function03=function(){
														bodyExpand(loadBomb(mainTemplateFunction));
													}
													lightFusePayload(clearDuration,function(){
														sidebarShrink(loadBomb(function03),duration);
													});
												}

												//update the web page address
												// For some reason this call
												// never returns so we put it
												// last.
												if(launchFromWebsite == true){
	    											debugMessage(">>> "+ExternalInterface.call("jsUpdateLocation", this.deepLink,1));
												}
										};
								}
								tempMenuItem_mc = undefined;
							}
							else{
								trace(">> Didn't find menuItems:item " + i);
							}
						}
					}
					else{
							trace(">> Didn't find menuItems as root tag :" + menuItems.firstChild.nodeName);
					}
				}
				else{
					trace(">> error with Menu Items XML");
					//menuItems.parseXML(defaultMenu);
				}
				triggerBomb(bomb);
		}
		menuItems.load(url);
	}
}



// luci nav functions

function bodyShrink(bomb1:MovieClip,bomb2:MovieClip)
{
var duration:Number;

	if(isBodyShrunk == false){
		duration = 0.5;
		textBody_mc._alpha=0;

		//shorten body section
		scrollBar1_mc.tween("_x", 757, duration, "easeInOutSine");
		whiteBlock_mc.tween("_x", 208+548, duration, "easeInOutSine");
	}
	else{
		duration = noDuration;
	}
	isBodyShrunk = true;


	lightFuseBomb(duration,bomb1);
	lightFuseBomb(duration,bomb2);
}

function bodyExpand(bomb1:MovieClip,bomb2:MovieClip)
{
var duration:Number;

	if(isBodyShrunk == true){
		duration = 0.5;
		textBody_mc._alpha=0;

		//expand body section
		scrollBar1_mc.tween("_x", 931,duration , "easeInOutSine");
		whiteBlock_mc.tween("_x", 208+722, duration, "easeInOutSine");
	}
	else{
		duration = noDuration;
	}
	isBodyShrunk= false;

	lightFuseBomb(duration,bomb1);
	lightFuseBomb(duration,bomb2);
}


function loadTitle(myText:String,fadeOut:Boolean,duration:Number)
{
	if(fadeOut){
		titleBody_mc.tween("_alpha",0,duration,"linear");
		lightFusePayload(duration,function(){
			titleBody_mc.titleBody_tx.text = myText;
			titleBody_mc.tween("_alpha",100,duration,"linear");
		});
	}
	else{
		titleBody_mc.titleBody_tx.text = myText;
		titleBody_mc.tween("_alpha",100,duration,"linear");
	}
}

function loadSidebarTitle(myText:String,fadeOut:Boolean,duration:Number)
{
	if(fadeOut){
		titleSidebar_mc.tween("_alpha",0,duration,"linear");
		lightFusePayload(duration,function(){
			titleSidebar_mc.titleSidebar_tx.text = myText;
			titleSidebar_mc.tween("_alpha",100,duration,"linear");
		});
	}
	else{
		titleSidebar_mc.titleSidebar_tx.text = myText;
		titleSidebar_mc.tween("_alpha",100,duration,"linear");
	}
}


function loadSidebarText(myText:String,fadeOut:Boolean,duration:Number)
{
	if(fadeOut){
		textSidebar_mc.tween("_alpha",0,duration,"linear");
		lightFusePayload(duration,function(){
			textSidebar_mc.textSidebar_tx.text = myText;
			textSidebar_mc.tween("_alpha",100,duration,"linear");
		});
	}
	else{
		textSidebar_mc.textSidebar_tx.text = myText;
		textSidebar_mc.tween("_alpha",100,duration,"linear");
	}
}


function loadHTMLURL(myURL:String,duration:Number,myMovieClip:MovieClip,myTextField:TextField)
{
var document:XML = new XML();
	
	//debugMessage(">> loading HTML URL "+myURL+":"+duration+":"+myMovieClip+":"+myTextField);

	if(duration == undefined){
		duration = 0.5;
	}
	if(myMovieClip == undefined){
		myMovieClip = textBody_mc;
	}
	if(myTextField == undefined){
		myTextField = textBody_mc.textBody_tx;
	}

	document.ignoreWhite = true;
	document.onData = function(src:String){
		loadHTMLText(myMovieClip,myTextField,src,true,duration);
	}
	document.load(deSandboxURL(myURL));
}

function loadHTMLText(myMovieClip:MovieClip,myTextField:TextField,myText:String,fadeOut:Boolean,duration:Number)
{
	var myFunction:Function = function(){
		myTextField.htmlText = myText;
		myMovieClip.tween("_alpha",100,duration,"linear");
	};

	if(fadeOut){
		myMovieClip.tween("_alpha",0,duration,"linear");
		lightFusePayload(duration,myFunction);
	}
	else{
		myFunction();
		//textBody_mc.textBody_tx.htmlText = myText;
		//textBody_mc.tween("_alpha",100,duration,"linear");
	}
}



function templateA(title:String,URL:String,bomb:MovieClip,deepLink:String,duration:Number)
{
var document:XML = new XML();

	if(deepLink != undefined){
		// Update the browser
		ExternalInterface.call("jsUpdateLocation", deepLink,2);
	}
	if(duration ==undefined){
		duration = 1.0;
	}

	//These should be alpha = 0 from the last clear
	titleBody_mc._visible=true;
	textBody_mc._visible=true;

	loadTitle(title,false,duration);

	document.ignoreWhite = true;
	document.onData = function(src:String){
		textBody_mc._x=216;
		textBody_mc._y=80;
		textBody_mc.textBody_tx._x = 0;
		textBody_mc.textBody_tx._y = 0;
		textBody_mc.textBody_tx._width = 534;
		textBody_mc.textBody_tx._height = 300;
		loadHTMLText(textBody_mc,textBody_mc.textBody_tx,src,false,duration);

		//Cause scrollBar1._x is in the middle of the scrollbar somewhere
		var scrollBar1Pad:Number = 18;
		var gap:Number = ((scrollBar1_mc._x - scrollBar1Pad) - BGBodyMasked_mc._x)/3;

		var image01_pad:Number = (gap - image01_mc._width)/2; 
		image01_mc._x= BGBodyMasked_mc._x+0*gap + image01_pad;
		image01_mc._y=underSkyline_y;
		image01_mc._alpha=0;
		image01_mc._visible=true;
		image01_mc.enabled=true;

		var image02_pad= (gap - image02_mc._width)/2; 
		image02_mc._x= BGBodyMasked_mc._x+1*gap + image02_pad;
		image02_mc._y=underSkyline_y;
		image02_mc._alpha=0;
		image02_mc._visible=true;
		image02_mc.enabled=true;

		var image03_pad= (gap - image03_mc._width)/2; 
		image03_mc._x= BGBodyMasked_mc._x+2*gap + image03_pad;
		image03_mc._y=underSkyline_y;
		image03_mc._alpha=0;
		image03_mc._visible=true;
		image03_mc.enabled=true;

		var loadListener:Object = new Object();

		loadListener.onLoadComplete = function(target_mc:MovieClip, httpStatus:Number):Void {
			target_mc.tween(["_alpha","_y"],[100,350],3*duration,"easeOutSine");
			image01_mc.onRelease=function(){
					jumpToURLNewWindow("http://82.198.155.50/congestionMap.htm");
			}
			image02_mc.onRelease=function(){
					jumpToURLNewWindow("http://springerlink.metapress.com/openurl.asp?genre=article&issn=0302-9743&volume=3205&spage=433");
			}
			image03_mc.onRelease=function(){
					jumpToURLNewWindow("http://www.flickr.com/photos/julianbleecker/87099551/");
			}
			triggerBomb(bomb);

			unlockMenuChoices();
		}

		loadListener.onLoadInit = function(target_mc:MovieClip):Void {
			var myDropFilter = new flash.filters.DropShadowFilter();
			myDropFilter.distance = 0;
			myDropFilter.inner = true;
			var myFilters:Array = target_mc.filters;
			myFilters.push(myDropFilter);
			target_mc.filters = myFilters;

		}

		var mcLoader1:MovieClipLoader = new MovieClipLoader();
		lockMenuChoices();
		mcLoader1.addListener(loadListener);
		mcLoader1.loadClip("http://luci.ics.uci.edu/websiteContent/overview/overviewPhoto03.jpg",image01_mc);

		var mcLoader2:MovieClipLoader = new MovieClipLoader();
		lockMenuChoices();
		mcLoader2.addListener(loadListener);
		mcLoader2.loadClip("http://luci.ics.uci.edu/websiteContent/overview/overviewPhoto02.jpg",image02_mc);

		var mcLoader3:MovieClipLoader = new MovieClipLoader();
		lockMenuChoices();
		mcLoader3.addListener(loadListener);
		mcLoader3.loadClip("http://luci.ics.uci.edu/websiteContent/overview/overviewPhoto01.jpg",image03_mc);
		unlockMenuChoices();

	}
	lockMenuChoices(); //Unlocked after load is complete
	document.load(URL);
}

function clearTemplateA(duration:Number)
{
	if(duration == undefined){
		duration = 0.5;
	}

	titleBody_mc.tween("_alpha",0,duration,"linear");
	textBody_mc.tween("_alpha",0,duration,"linear");

	image01_mc.tween(["_x","_y","_alpha"],[214,underSkyline_y,0],duration,"easeInSine");
	image02_mc.tween(["_x","_y","_alpha"],[395,underSkyline_y,0],duration,"easeInSine");
	image03_mc.tween(["_x","_y","_alpha"],[576,underSkyline_y,0],duration,"easeInSine");

	lightFusePayload(duration,function(){
		titleBody_mc._visible=false;
		titleBody_mc.enabled=false;

		textBody_mc._visible=false;
		textBody_mc.enabled=false;

		image01_mc._visible=false;
		image01_mc.enabled=false;

		image02_mc._visible=false;
		image02_mc.enabled=false;

		image03_mc._visible=false;
		image03_mc.enabled=false;
	});

}

function createNewMenuItem(uniqueID:Number):MovieClip
{
	var menuItem_mc:MovieClip = _root.attachMovie("sectionListItem","sectionListItem_"+uniqueID.toString()+"_mc", _root.getNextHighestDepth());

	menuItem_mc._visible = false;
	menuItem_mc._alpha = 0;
	menuItem_mc.enabled = true;

	menuItem_mc.order = -1;
	menuItem_mc.title = "";
	menuItem_mc.textURL = "";
	menuItem_mc.sectionDataURL = "";
	menuItem_mc.launchURL = false;
	menuItem_mc.imageLinkURL = "";
	menuItem_mc.imageSourceURL = "";
	menuItem_mc.uniqueID = uniqueID;
	menuItem_mc.sectionListItem_tx._x=0;
	menuItem_mc.sectionListItem_tx._y=0;
	menuItem_mc.sectionListItem_tx._visible = true;
	menuItem_mc.sectionListItem_tx._alpha = 100;
	menuItem_mc.sectionListItem_tx.html = true;
	menuItem_mc.sectionListItem_tx.htmlText = "";
	menuItem_mc.sectionListItem_tx.embedFonts=true;
	menuItem_mc.sectionListItem_tx.wordWrap = true;
	menuItem_mc.sectionListItem_tx.multiline = true;
	menuItem_mc.sectionListItem_tx.styleSheet = textBody_styleSheet;
	menuItem_mc.sectionListItem_tx.autoSize=true;

	menuItem_mc._visible = true;
	return(menuItem_mc);
}


var projects:Array;

function loadProjects(URL:String,duration:Number,bomb:MovieClip)
{
	/****************************/
	/* Used for click functions */
	var leftBase:Number=216;
	var menuWidth:Number = 120;
	var buffer:Number = 10;
	var sectionDataWidth:Number=155;

	var topBase:Number=80;
	/****************************/

	projects = new Array();
	var document:XML = new XML();
	document.ignoreWhite = true;
	document.onLoad = function(success:Boolean){
		if(success){
			var uniqueID:Number = 0;
			var myArray:Array = document.firstChild.childNodes;
			for (i in myArray){
				if(myArray[i].nodeName == "project"){
					var menuItem_mc:MovieClip = createNewMenuItem(uniqueID);
					uniqueID++;
					
					var myArray2:Array = myArray[i].childNodes;
					for (j in myArray2){
						if(myArray2[j].nodeName == "order"){
							menuItem_mc.order= Number(myArray2[j].firstChild.nodeValue);
							menuItem_mc._x=leftBase;
							menuItem_mc._y=topBase+15*menuItem_mc.order;
						}
						else if(myArray2[j].nodeName == "title"){
							menuItem_mc.title= myArray2[j].firstChild.nodeValue;
							menuItem_mc.sectionListItem_tx.htmlText = menuItem_mc.title;
						}
						else if(myArray2[j].nodeName == "deepLink"){
							menuItem_mc.deepLink= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "textURL"){
							menuItem_mc.textURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "sectionDataURL"){
							menuItem_mc.sectionDataURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "menuItemURL"){
							menuItem_mc.menuItemURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "launchURL"){
							menuItem_mc.launchURL= true;
						}
						else if(myArray2[j].nodeName == "imageSourceURL"){
							menuItem_mc.imageSourceURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "imageLinkURL"){
							menuItem_mc.imageLinkURL= myArray2[j].firstChild.nodeValue;
						}
						else{
							debugMessage("Trouble parsing project XML item");
						}
					}
					//What to do when the menu item is clicked
					menuItem_mc.onRelease= function(){

						//Load the deepLink 
						ExternalInterface.call("jsUpdateLocation",this.deepLink,2);

						//Disable this item
						for (i in projects){
							projects[i].enabled = true;
							/* The color names are opposite what they look
							 * like because the background is white */
							projects[i].sectionListItem_tx.textColor= menuTextFormatNotClickable;
						}
						this.enabled = false;
							/* The color names are opposite what they look
							 * like because the background is white */
						this.sectionListItem_tx.textColor= menuTextFormatInactive;

						//Fade out existing imagery and text
						sectionImage_mc.tween("_alpha",0,duration,"linear");
						sectionTitle_mc.tween("_alpha",0,duration,"linear");
						sectionData_mc.tween("_alpha",0,duration,"linear");

						//Load the image
						if(this.imageSourceURL != ""){
							var foo=this.imageSourceURL;
							var bar=this.imageLinkURL;

							var loadListener:Object = new Object();

							loadListener.onLoadComplete = function(target_mc:MovieClip, httpStatus:Number):Void {
								target_mc.tween("_alpha",100,duration,"linear");
							}
	
							loadListener.onLoadInit = function(target_mc:MovieClip):Void {
								var myDropFilter = new flash.filters.DropShadowFilter();
								myDropFilter.distance = 0;
								myDropFilter.inner = true;
								var myFilters:Array = target_mc.filters;
								myFilters.push(myDropFilter);
								target_mc.filters = myFilters;

								if(bar == ""){
									target_mc.onRelease=undefined;
								}
								else{
									target_mc.onRelease=function(){jumpToURLNewWindow(bar);};
								}

							}
	
							var mcLoader1:MovieClipLoader = new MovieClipLoader();
							mcLoader1.addListener(loadListener);

							lightFusePayload(duration,function(){
								//Position title
								sectionTitle_mc._x=leftBase+menuWidth+buffer;
								sectionTitle_mc._y=topBase+sectionImage_mc._height+buffer;

								//Position data
								sectionData_mc._x=leftBase+menuWidth+buffer;
								sectionData_mc._y=topBase+sectionImage_mc._height+buffer+sectionTitle_mc._height;
								sectionData_mc.sectionData_tx._height=textBody_mc._height-sectionTitle_mc._height-sectionImage_mc._height;

								//Position image
								sectionImage_mc._visible = true;
								sectionImage_mc.enabled = true;
								sectionImage_mc._x=leftBase+menuWidth+buffer;
								sectionImage_mc._y=topBase;

								//Load new image
								mcLoader1.loadClip(deSandboxURL(foo),sectionImage_mc);
							});
						}
						else{
							lightFusePayload(duration,function(){
								sectionImage_mc._visible = false;
								sectionImage_mc.enabled = false;

								//Position title
								sectionTitle_mc._x=leftBase+menuWidth+buffer;
								sectionTitle_mc._y=topBase;

								//Position data
								sectionData_mc._x=leftBase+menuWidth+buffer;
								sectionData_mc._y=topBase+sectionTitle_mc._height;
								sectionData_mc.sectionData_tx._height=textBody_mc._height-sectionTitle_mc._height;
							});
						}

						//Load the section details
						if(this.title != ""){
							loadHTMLText(sectionTitle_mc,sectionTitle_mc.sectionTitle_tx,this.title,true,duration);
						}
						else{
							loadHTMLText(sectionTitle_mc,sectionTitle_mc.sectionTitle_tx,"",true,duration);
						}

						if(this.sectionDataURL != ""){
							loadHTMLText(sectionData_mc,sectionData_mc.sectionData_tx,"",true,noDuration);
							loadHTMLURL(this.sectionDataURL,duration,sectionData_mc,sectionData_mc.sectionData_tx);
						}
						else{
							loadHTMLText(sectionData_mc,sectionData_mc.sectionData_tx,"",true,duration);
						}

						//Load the text
						if(this.textURL != ""){
							loadHTMLURL(this.textURL,duration,textBody_mc,textBody_mc.textBody_tx);
						}
						else{
							loadHTMLText(textBody_mc,textBody_mc.textBody_tx,"",true,duration);
						}


					}

					projects[menuItem_mc.order] = menuItem_mc;
				}
			}
		}
		triggerBomb(bomb);
	}
	document.load(URL);
};

function templateB(title:String,URL:String,bomb:MovieClip,deepLink:String,duration:Number)
{
	var leftBase:Number=216;
	var menuWidth:Number = 120;
	var buffer:Number = 10;
	var sectionDataWidth:Number=155;

	var topBase:Number=80;

	if(duration == undefined){
		duration = 1.0;
	}

	titleBody_mc._alpha=0;
	titleBody_mc._visible=true;
	titleBody_mc.enabled=true;

	loadTitle(title,false);

	textBody_mc._x=leftBase+menuWidth+buffer+buffer+sectionDataWidth+buffer;
	textBody_mc._y=topBase;
	textBody_mc.textBody_tx._x = 0;
	textBody_mc.textBody_tx._y = 0;
	textBody_mc.textBody_tx._width = 400;
	textBody_mc.textBody_tx._height = 410;

	textBody_mc._alpha=0;
	textBody_mc._visible=true;
	textBody_mc.enabled=true;

	sectionTitle_mc._alpha=0;
	sectionTitle_mc._visible=true;
	sectionTitle_mc._x=leftBase+menuWidth+buffer;
	sectionTitle_mc.enabled=true;

	sectionData_mc._alpha=0;
	sectionData_mc._visible=true;
	sectionData_mc.tween._x=leftBase+menuWidth+buffer;
	sectionData_mc.enabled=true;

	sectionImage_mc._alpha=0;
	sectionImage_mc._visible=true;
	sectionImage_mc.enabled=true;

	dividerVert_mc._x=leftBase+menuWidth;
	dividerVert_mc._visible = true;
	dividerVert_mc.enabled = true;

	dividerVert_mc.tween(["_x","_y","_alpha"],[leftBase+menuWidth,83,100],duration,"easeInOutSine");

	lockMenuChoices(); //Unlocked after document load
	loadProjects(URL,duration,loadBomb(function(){
		for(i in projects){
			if (projects[i].order != -1){
				projects[i].enabled=true;
				projects[i]._visible=true;
				projects[i].tween(["_alpha"],[100],duration,"easeOutSine");
			}
		}
		/*Deal with deep linking*/
		var launched:Boolean = false;

		if(deepLink != undefined){
			for(i in projects){
				if((projects[i].deepLink == deepLink)&&(launched == false)){
					projects[i].onRelease();
					launched = true;
					trace(">> launching projects with deepLink "+deepLink);
				}
			}
		}

		if(launched == false){
			for(i in projects){
				if((projects[i].launchURL == true)&&(launched == false)){
					projects[i].onRelease();
					launched = true;
					debugMessage(">> launching projects without deepLink " + deepLink);
				}
			}
		}
		unlockMenuChoices();
	}));
}

function clearTemplateB(title:String,URL:String,duration:Number)
{
	if(duration == undefined){
		duration = 0.5;
	}

	titleBody_mc.tween("_alpha",0,duration,"linear");
	textBody_mc.tween("_alpha",0,duration,"linear");

	sectionImage_mc.tween("_alpha",0,duration,"linear");
	sectionTitle_mc.tween("_alpha",0,duration,"linear");
	sectionData_mc.tween("_alpha",0,duration,"linear");
				
	dividerVert_mc.tween("_alpha",0,duration,"linear");

	for(i in projects){
		projects[i].tween("_alpha",0,duration,"linear");
	}

	lightFusePayload(duration,function(){
			titleBody_mc._visible=false;
			titleBody_mc.enabled=false;

			textBody_mc._visible=false;
			textBody_mc.enabled=false;

			sectionImage_mc._visible=false;
			sectionImage_mc.enabled=false;
			sectionTitle_mc._visible=false;
			sectionTitle_mc.enabled=false;
			sectionData_mc._visible=false;
			sectionData_mc.enabled=false;

			dividerVert_mc._visible=false;
			dividerVert_mc.enabled=false;

			for(i in projects){
				projects[i]._visible = false;
				projects[i].enabled = false;
				projects[i].unloadMovie();
			}
	});

}

var biographies:Array;

function loadBiographies(URL:String,duration:Number,bomb:MovieClip)
{
	/****************************/
	/* Used for click functions */
	var leftBase:Number=216;
	var menuWidth:Number = 120;
	var buffer:Number = 10;
	var sectionDataWidth:Number=155;

	var topBase:Number=80;
	/****************************/

	biographies = new Array();
	var document:XML = new XML();
	document.ignoreWhite = true;
	document.onLoad = function(success:Boolean){
		if(success){
			var uniqueID:Number = 0;
			var myArray:Array = document.firstChild.childNodes;
			for (i in myArray){
				if(myArray[i].nodeName == "biography"){
					var menuItem_mc:MovieClip = createNewMenuItem(uniqueID);
					uniqueID++;

					var myArray2:Array = myArray[i].childNodes;
					for (j in myArray2){
						if(myArray2[j].nodeName == "order"){
							menuItem_mc.order= Number(myArray2[j].firstChild.nodeValue);
							menuItem_mc._x=Number(leftBase);
							menuItem_mc._y=Number(topBase+15*menuItem_mc.order);
						}
						else if(myArray2[j].nodeName == "title"){
							menuItem_mc.title= myArray2[j].firstChild.nodeValue;
							menuItem_mc.sectionListItem_tx.htmlText = menuItem_mc.title;
						}
						else if(myArray2[j].nodeName == "deepLink"){
							menuItem_mc.deepLink= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "textURL"){
							menuItem_mc.textURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "sectionDataURL"){
							menuItem_mc.sectionDataURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "menuItemURL"){
							menuItem_mc.menuItemURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "launchURL"){
							menuItem_mc.launchURL= true;
						}
						else if(myArray2[j].nodeName == "imageSourceURL"){
							menuItem_mc.imageSourceURL= myArray2[j].firstChild.nodeValue;
						}
						else if(myArray2[j].nodeName == "imageLinkURL"){
							menuItem_mc.imageLinkURL= myArray2[j].firstChild.nodeValue;
						}
						else{
							debugMessage("Trouble parsing biography XML item");
						}
					}
					//What to do when the menu item is clicked
					menuItem_mc.onRelease= function(){

						//Load the deepLink 
						ExternalInterface.call("jsUpdateLocation",this.deepLink,2);

						//Disable this item
						for (i in biographies){
							biographies[i].enabled = true;
							/* The color names are opposite what they look
							 * like because the background is white */
							biographies[i].sectionListItem_tx.textColor= menuTextFormatNotClickable;
						}
						this.enabled = false;
							/* The color names are opposite what they look
							 * like because the background is white */
						this.sectionListItem_tx.textColor= menuTextFormatInactive;

						//Fade out existing imagery and text
						sectionImage_mc.tween("_alpha",0,duration,"linear");
						sectionTitle_mc.tween("_alpha",0,duration,"linear");
						sectionData_mc.tween("_alpha",0,duration,"linear");

						//Load the image
						if(this.imageSourceURL != ""){
							var foo=this.imageSourceURL;
							var bar=this.imageLinkURL;

							var loadListener:Object = new Object();
	
							loadListener.onLoadComplete = function(target_mc:MovieClip, httpStatus:Number):Void {
								target_mc.tween("_alpha",100,duration,"linear");
							}
		
							loadListener.onLoadInit = function(target_mc:MovieClip):Void {
								var myDropFilter = new flash.filters.DropShadowFilter();
								myDropFilter.distance = 0;
								myDropFilter.inner = true;
								var myFilters:Array = target_mc.filters;
								myFilters.push(myDropFilter);
								target_mc.filters = myFilters;

								if(bar == ""){
									target_mc.onRelease=undefined;
								}
								else{
									target_mc.onRelease=function(){jumpToURLNewWindow(bar);};
								}

							}
		
							var mcLoader1:MovieClipLoader = new MovieClipLoader();
							mcLoader1.addListener(loadListener);
	

							lightFusePayload(duration,function(){
								//Position title
								sectionTitle_mc._x=leftBase+menuWidth+buffer;
								sectionTitle_mc._y=topBase+sectionImage_mc._height+buffer;

								//Position data
								sectionData_mc._x=leftBase+menuWidth+buffer;
								sectionData_mc._y=topBase+sectionImage_mc._height+buffer+sectionTitle_mc._height;
								sectionData_mc.sectionData_tx._height=textBody_mc._height-sectionTitle_mc._height-sectionImage_mc._height;

								//Position image
								sectionImage_mc._visible = true;
								sectionImage_mc.enabled = true;
								sectionImage_mc._x=leftBase+menuWidth+buffer;
								sectionImage_mc._y=topBase;

								//Load new image
								mcLoader1.loadClip(deSandboxURL(foo),sectionImage_mc);
							});
						}
						else{
							lightFusePayload(duration,function(){
								sectionImage_mc._visible = false;
								sectionImage_mc.enabled = false;

								//Position title
								sectionTitle_mc._x=leftBase+menuWidth+buffer;
								sectionTitle_mc._y=topBase;

								//Position data
								sectionData_mc._x=leftBase+menuWidth+buffer;
								sectionData_mc._y=topBase+sectionTitle_mc._height;
								sectionData_mc.sectionData_tx._height=textBody_mc._height-sectionTitle_mc._height;
							});
						}

						//Load the section details
						if(this.title != ""){
							loadHTMLText(sectionTitle_mc,sectionTitle_mc.sectionTitle_tx,this.title,true,duration);
						}
						else{
							loadHTMLText(sectionTitle_mc,sectionTitle_mc.sectionTitle_tx,"",true,duration);
						}
	
						if(this.sectionDataURL != ""){
							loadHTMLText(sectionData_mc,sectionData_mc.sectionData_tx,"",true,noDuration);
							loadHTMLURL(this.sectionDataURL,duration,sectionData_mc,sectionData_mc.sectionData_tx);
						}
						else{
							loadHTMLText(sectionData_mc,sectionData_mc.sectionData_tx,"",true,duration);
						}
	
						//Load the text
						if(this.textURL != ""){
							loadHTMLURL(this.textURL,duration,textBody_mc,textBody_mc.textBody_tx);
						}
						else{
							loadHTMLText(textBody_mc,textBody_mc.textBody_tx,"",true,duration);
						}
	
					}
					
					biographies[menuItem_mc.order] = menuItem_mc;
				}
			}
		}
		triggerBomb(bomb);
	}
	document.load(URL);
};


function templateC(title:String,URL:String,bomb:MovieClip,deepLink:String,duration:Number)
{
	var leftBase:Number=216;
	var menuWidth:Number = 120;
	var buffer:Number = 10;
	var sectionDataWidth:Number=155;

	var topBase:Number=80;

	if(duration == undefined){
		duration = 1.0;
	}

	titleBody_mc._alpha=0;
	titleBody_mc._visible=true;
	titleBody_mc.enabled=true;

	loadTitle(title,false);

	textBody_mc._x=leftBase+menuWidth+buffer+buffer+sectionDataWidth+buffer;
	textBody_mc._y=topBase;
	textBody_mc.textBody_tx._x = 0;
	textBody_mc.textBody_tx._y = 0;
	textBody_mc.textBody_tx._width = 400;
	textBody_mc.textBody_tx._height = 410;

	textBody_mc._alpha=0;
	textBody_mc._visible=true;
	textBody_mc.enabled=true;

	sectionTitle_mc._alpha=0;
	sectionTitle_mc._visible=true;
	sectionTitle_mc._x=leftBase+menuWidth+buffer;
	sectionTitle_mc.enabled=true;

	sectionData_mc._alpha=0;
	sectionData_mc._visible=true;
	sectionData_mc.tween._x=leftBase+menuWidth+buffer;
	sectionData_mc.enabled=true;

	sectionImage_mc._alpha=0;
	sectionImage_mc._visible=true;
	sectionImage_mc.enabled=true;

	dividerVert_mc._x=leftBase+menuWidth;
	dividerVert_mc._visible = true;
	dividerVert_mc.enabled = true;

	dividerVert_mc.tween(["_x","_y","_alpha"],[leftBase+menuWidth,83,100],duration,"easeInOutSine");

	lockMenuChoices(); //Unlocked after document load
	loadBiographies(URL,duration,loadBomb(function(){
		for(i in biographies){
			if (biographies[i].order != -1){
				biographies[i].enabled=true;
				biographies[i]._visible=true;
				biographies[i].tween(["_alpha"],[100],duration,"easeOutSine");
			}
		}
		/*Deal with deep linking*/
		var launched:Boolean = false;

		if(deepLink != undefined){
			for(i in biographies){
				if((biographies[i].deepLink == deepLink)&&(launched == false)){
					biographies[i].onRelease();
					launched = true;
					debugMessage(">> launching biographies with deepLink "+deepLink);
				}
			}
		}

		if(launched == false){
			for(i in biographies){
				if((biographies[i].launchURL == true)&&(launched == false)){
					biographies[i].onRelease();
					launched = true;
					debugMessage(">> launching biographies without deepLink " + deepLink);
				}
			}
		}
		unlockMenuChoices();
	}));
}

function clearTemplateC(title:String,URL:String,duration:Number)
{
	if(duration == undefined){
		duration = 0.5;
	}

	titleBody_mc.tween("_alpha",0,duration,"linear");
	textBody_mc.tween("_alpha",0,duration,"linear");

	sectionImage_mc.tween("_alpha",0,duration,"linear");
	sectionTitle_mc.tween("_alpha",0,duration,"linear");
	sectionData_mc.tween("_alpha",0,duration,"linear");
				
	dividerVert_mc.tween("_alpha",0,duration,"linear");

	for(i in biographies){
		biographies[i].tween("_alpha",0,duration,"linear");
	}

	lightFusePayload(duration,function(){
			titleBody_mc._visible=false;
			titleBody_mc.enabled=false;

			textBody_mc._visible=false;
			textBody_mc.enabled=false;

			sectionImage_mc._visible=false;
			sectionImage_mc.enabled=false;
			sectionTitle_mc._visible=false;
			sectionTitle_mc.enabled=false;
			sectionData_mc._visible=false;
			sectionData_mc.enabled=false;

			dividerVert_mc._visible=false;
			dividerVert_mc.enabled=false;

			for(i in biographies){
				biographies[i]._visible = false;
				biographies[i].enabled = false;
				biographies[i].unloadMovie();
			}
	});
}



function templateSA(title,URL,bomb)
{
var document:XML = new XML();

	loadSidebarTitle(title,false,0.5);
	
	document.ignoreWhite = true;
	document.onLoad = function(success:Boolean){
		if(success){
			if(document.firstChild.nodeName == "rdf:RDF"){
				var runningText:String = "";
				var i:String;
				var myArray:Array = document.childNodes;
				myArray = document.firstChild.childNodes;
				for (i in myArray){
					var lastDate:String = "";
					if(myArray[i].nodeName == "item"){
						var title:String = "";
						var url:String = "";
						var subject:String = "";
						var date:String = "";
						var j:String;
						var myArray2:Array = myArray[i].childNodes;
						for (j in myArray2){
							if(myArray2[j].nodeName == "title"){
								title = myArray2[j].firstChild.nodeValue;
							}
							else if(myArray2[j].nodeName == "link"){
								url = myArray2[j].firstChild.nodeValue;
							}
							else if(myArray2[j].nodeName == "dc:date"){
								date = myArray2[j].firstChild.nodeValue;
							}
							else if(myArray2[j].nodeName == "dc:subject"){
								subject = myArray2[j].firstChild.nodeValue;
							}
							else if(myArray2[j].nodeName == "dc:creator"){
							}
							else if(myArray2[j].nodeName == "description"){
							}
							else{
								trace(">> unknown thing :"+myArray2[j].nodeName);
							}
						}
						if(lastDate != date.split("T",1)[0]){
							lastDate = date.split("T",1)[0];
							runningText= "<p>"+lastDate+"</p><p><a href=\"asfunction:_root.jumpToURLSameWindow,"+url+"\">"+title+"</a></p><br/>" +runningText;
						}
						else{
							runningText="&nbsp;&nbsp;&nbsp;<a href=\"asfunction:_root.jumpToURLSameWindow,"+url+"\">"+title+"</a><br>"+runningText;
						}
					}
					//trace(">> "+runningText);
				}
				loadSidebarText(runningText,false,0.5);

			}
			else{
				trace(">> Unknown element in templateSA "+document.firstChild.nodeName);
			}
		}
		else{
			trace(">> Trouble loading XML in templateSA");
		}
		triggerBomb(bomb);

	}
	document.load(deSandboxURL(URL));
}


function clearTemplateSA(duration:Number)
{
	if(duration == undefined){
		duration = 0.5;
	}
	loadSidebarTitle("",true,duration);
	loadSidebarText("",true,duration);

}


_global.loadingTemplates = 0;
function lockMenuChoices()
{
	if(_global.loadingTemplates == 0){
		disableAllMenuItems();
	}
	_global.loadingTemplates++;
	//debugMessage("Locking Menu Choices "+_global.loadingTemplates);
}

function unlockMenuChoices()
{
	//debugMessage("Unlocking Menu Choices "+_global.loadingTemplates);
	_global.loadingTemplates--;
	if(_global.loadingTemplates < 0){
			debugMessage("_global.loadingTemplates is out of sync");
			_global.loadingTemplates = 0;
	}
	if(_global.loadingTemplates == 0){
		enableAllButOneMenuItems();
	}
}


function dispatchTemplate(type:String,title:String,URL:String,bomb:MovieClip,deepLink:String,duration:Number)
{
		lockMenuChoices()
		debugMessage(">> dispatching template "+type+",url "+URL+": locks = "+_global.loadingTemplates);
		if(type=="A"){
			templateA(title,URL,bomb,deepLink,duration);
		}
		else if(type=="SA"){
			templateSA(title,URL,bomb,deepLink,duration);
		}
		else if(type=="B"){
			templateB(title,URL,bomb,deepLink,duration);
		}
		else if(type=="C"){
			templateC(title,URL,bomb,deepLink,duration);
		}
		else{
			debugMessage(">> Can't Dispatch This Template");
		}
		unlockMenuChoices();
}

function undispatchTemplate(type:String,duration:Number)
{
		lockMenuChoices();
		debugMessage(">> Undispatching template "+type+": locks = "+_global.loadingTemplates);
		if(type=="A"){
			clearTemplateA(duration);
		}
		else if(type=="SA"){
			clearTemplateSA(duration);
		}
		else if(type=="B"){
			clearTemplateB(title,URL,duration);
		}
		else if(type=="C"){
			clearTemplateC(title,URL,duration);
		}
		else{
			debugMessage(">> Unknown Template");
		}
		unlockMenuChoices();
}



//Comment this out if it's being run from in a web browser
//Launch
if(launchFromWebsite == false){
	//animateOpen("projects&nomaticGaim");
	animateOpen();
}
else{
	ExternalInterface.call("jsStartFromActionScript", undefined);
}
//animateOpen();
//animateOpen("projects&nomaticGaim");


//var x:String = "abc&def&ghi";
//trace(">> "+x.indexOf("&")+":"+x.substring(0,x.indexOf("&"))+":"+x.substring(x.indexOf("&")+1,x.length));
