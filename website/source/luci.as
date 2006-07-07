//Code to manage animation sequences
#include "bomb.as"
import TextField.StyleSheet;
import flash.display.*;
import flash.filters.ColorMatrixFilter;



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


// turn off active menu states
var isBodyShrunk:Boolean=true;
var isSidebarShrunk:Boolean=true;
var clearCurrentTemplate:Object = new Object();
	clearCurrentTemplate.clearFunction= function(){trace(">> No template to clear");};
	clearCurrentTemplate.whichMenuItem= new MovieClip();

/*BGmenu_mc.menuOverviewWhite_mc._visible = false;

BGmenu_mc.menuCoursesWhite_mc._visible = false;
BGmenu_mc.menuProjectsWhite_mc._visible = false;
BGmenu_mc.menuBiosWhite_mc._visible = false;

BGmenu_mc.menuLocalWhite_mc._visible = false;
BGmenu_mc.menuRegionalWhite_mc._visible = false;
BGmenu_mc.menuWorldWhite_mc._visible = false;
BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
*/


// parallax
var mouseListener:Object = new Object();
mouseListener.onMouseMove = function() {
	myX = _xmouse;
	skyline_mc.skyline1_mc._x = 0-(myX/10);
	skyline_mc.skyline2_mc._x = 0-(myX/20);
	skyline_mc.skyline3_mc._x = 0-(myX/50);
};
Mouse.addListener(mouseListener);


function initialBuildOrangeSidebar(bomb:MovieClip)
{

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
		x= _ymouse - x;
		textSidebar_mc.textSidebar_tx.onScroller(x);
	}

	textSidebar_mc.textSidebar_tx.onScroller= function(delta)
		{
			var base:Number;
			var step:Number;
			var current:Number;

			base = scrollBar2_mc.scrollUp_but._y+ scrollBar2_mc.scrollUp_but._height;
			step = (scrollBar2_mc.scrollDown_but._y - base)/(textSidebar_mc.textSidebar_tx.maxscroll+1);
			current = textSidebar_mc.textSidebar_tx.scroll;

			if(typeof(delta) == typeof(0)){
				var x:Number= textSidebar_mc.textSidebar_tx.scroll + delta/step;
				if(x<1){
					textSidebar_mc.textSidebar_tx.scroll = 1;
				}
				else if(x> textSidebar_mc.textSidebar_tx.maxscroll) {
					textSidebar_mc.textSidebar_tx.scroll = textSidebar_mc.textSidebar_tx.maxscroll;
				}
				else{
					textSidebar_mc.textSidebar_tx.scroll=x;
				}
				current = x;
			}
			else{
				scrollBar2_mc.scrollThumb_mc.tween(["_y","_height"],[current*step+base,step],0.5,"easeOutSine");
			}


			if(textSidebar_mc.textSidebar_tx.scroll == 1){
				scrollBar2_mc.scrollUp_but.enabled =false;
	 			scrollBar2_mc.scrollUp_but._alpha=0;
			}
			else{
				scrollBar2_mc.scrollUp_but.enabled =true;
				scrollBar2_mc.scrollUp_but._alpha=100;
			}
			if(textSidebar_mc.textSidebar_tx.scroll == textSidebar_mc.textSidebar_tx.maxscroll) {
				scrollBar2_mc.scrollDown_but.enabled =false;
				scrollBar2_mc.scrollDown_but._alpha=0;
			}
			else{
				scrollBar2_mc.scrollDown_but.enabled =true;
				scrollBar2_mc.scrollDown_but._alpha=100;
			}

			if(textSidebar_mc.textSidebar_tx.maxscroll == 1){
				scrollBar2_mc.scrollThumb_mc._enabled=false;
				scrollBar2_mc.scrollThumb_mc._alpha=0;
			}
			else{
				scrollBar2_mc.scrollThumb_mc._enabled=true;
				scrollBar2_mc.scrollThumb_mc._alpha=100;
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



	sidebarExpand(bomb);
}

function finalBuildOrangeSidebar(bomb:MovieClip)
{
	sidebarShrink(bomb);

}

function jumpToURL(URL:String)
{
	trace(">> jumping to "+URL);
	finalBuild(loadBomb(function(){
		getURL(URL,"_self");
	}));
}


function initialBuildMenu(bomb:MovieClip)
{

var duration:Number = 1.0;

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

	//When animation is complete, load menu items, when that's done reveal them
	lightFusePayload(duration, function(){
		loadMenuItems(menuItemsURL,loadBomb(function()
			{
				var duration2:Number = 1.0;

				for(var i in mainMenu){
					mainMenu[i].menuItemText_tx._alpha=100;
					mainMenu[i].tween("_alpha",100,duration2,"linear");

					if(mainMenu[i]._order == 0){
						mainMenu[i].onRelease();
					}
				}
				triggerBomb(bomb);
			}
		));
	});
}

function finalBuildMenu(bomb:MovieClip)
{

var duration:Number = 0.5;

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

function initialBuildCenterPane(bomb:MovieClip)
{
	var duration:Number = 2.0;

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

	textBody_mc._visible=true;		
	textBody_mc.textBody_tx.embedFonts=true;
	textBody_mc.textBody_tx.html = true;
	textBody_mc.textBody_tx.wordWrap = true;
	textBody_mc.textBody_tx.multiline = true;
	textBody_mc.textBody_tx.styleSheet = textBody_styleSheet;

	textBody_mc._x=216;
	textBody_mc._y=80;

	textBody_mc.textBody_tx._alpha=0;
	textBody_mc.textBody_tx._x=0;
	textBody_mc.textBody_tx._y=0;
	textBody_mc.textBody_tx._width=534;
	textBody_mc.textBody_tx._height=300;

	//Construct scroll bar functionality
	// Click on scoll bar but not on buttons
	scrollBar1_mc.scrollBackground_mc.onRelease=function(){
		var x:Number;

		x= scrollBar1_mc.scrollThumb_mc._y;
		x= _ymouse - x;
		textBody_mc.textBody_tx.onScroller(x);
	}

	textBody_mc.textBody_tx.onScroller= function(delta)
		{
			var base:Number;
			var step:Number;
			var current:Number;

			base = scrollBar1_mc.scrollUp_but._y+ scrollBar1_mc.scrollUp_but._height;
			step = (scrollBar1_mc.scrollDown_but._y - base)/(textBody_mc.textBody_tx.maxscroll+1);
			current = textBody_mc.textBody_tx.scroll;

			if(typeof(delta) == typeof(0)){
				var x:Number= textBody_mc.textBody_tx.scroll + delta/step;
				if(x<1){
					textBody_mc.textBody_tx.scroll = 1;
				}
				else if(x> textBody_mc.textBody_tx.maxscroll) {
					textBody_mc.textBody_tx.scroll = textBody_mc.textBody_tx.maxscroll;
				}
				else{
					textBody_mc.textBody_tx.scroll=x;
				}
				current = x;
			}
			else{
				scrollBar1_mc.scrollThumb_mc.tween(["_y","_height"],[current*step+base,step],0.5,"easeOutSine");
			}


			if(textBody_mc.textBody_tx.scroll == 1){
				scrollBar1_mc.scrollUp_but.enabled =false;
	 			scrollBar1_mc.scrollUp_but._alpha=0;
			}
			else{
				scrollBar1_mc.scrollUp_but.enabled =true;
				scrollBar1_mc.scrollUp_but._alpha=100;
			}
			if(textBody_mc.textBody_tx.scroll == textBody_mc.textBody_tx.maxscroll) {
				scrollBar1_mc.scrollDown_but.enabled =false;
				scrollBar1_mc.scrollDown_but._alpha=0;
			}
			else{
				scrollBar1_mc.scrollDown_but.enabled =true;
				scrollBar1_mc.scrollDown_but._alpha=100;
			}

			if(textBody_mc.textBody_tx.maxscroll == 1){
				scrollBar1_mc.scrollThumb_mc._enabled=false;
				scrollBar1_mc.scrollThumb_mc._alpha=0;
			}
			else{
				scrollBar1_mc.scrollThumb_mc._enabled=true;
				scrollBar1_mc.scrollThumb_mc._alpha=100;
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

function finalBuildCenterPane(bomb:MovieClip)
{
	var duration:Number = 1.0;

	loadTitle("");
	loadHTMLText("");

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

function initialBuild(bomb:MovieClip){

	//Immediately clear some items
	image01_mc._visible=false;
	image01_mc._alpha=0;
	image02_mc._visible=false;
	image02_mc._alpha=0;
	image03_mc._visible=false;
	image03_mc._alpha=0;

	initialBuildMenu();

	initialBuildOrangeSidebar();

	initialBuildCenterPane(bomb);
}

function finalBuild(bomb:MovieClip)
{
	finalBuildOrangeSidebar();			
	finalBuildCenterPane(loadBomb(function(){
		logo_mc.tween(["_alpha"],[0],1.0,"easeInSine");
	skyline_mc.tween("_alpha",0,0.5,"linear");
		lightFuseBomb(1.0,bomb);
	}));
	finalBuildMenu();
}




function clearAndResetPage(){
	// remove content & unused interface pieces:
	// blank out text boxes

	titleBody_mc.titleBody_tx.text = "";
	textBody_mc.textBody_tx.text = "";

	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc.textSidebar_tx.text = "";

	blindWhite_mc._visible = false;
	blindOrange_mc._visible = false;

	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;

	turnOffActiveMenuStates();
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
var moveDuration:Number = 0.5;

	BGmenu_mc.menuActive_mc._visible=true;
	BGmenu_mc.menuActive_mc._x=0;

	BGmenu_mc.menuActive_mc.tween(["_alpha","_y"],[100, baseY], moveDuration, "easeOutSine");

	BGmenu_mc.menuActive_mc.menuActiveGray_mc.tween(["_alpha","_y","_height"],[100,0,grayHeight],moveDuration,"easeOutSine");

	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_alpha","_x", "_y", "_width"], [100,orangeX, orangeY, orangeWidth],moveDuration , "easeOutSine");
}

function sidebarShrink(bomb:MovieClip)
{
var duration:Number=1.0;		

	if(isSidebarShrunk != true){
		loadSidebarTitle("");
		loadSidebarHTMLText("");

		//This is the orange sidebar
		BGsidebar_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");
		scrollBar2_mc.tween(["_y", "_alpha"], [underSkyline_y, 0], duration, "easeInSine");

		lightFusePayload(duration,function(){
			textSidebar_mc._visible=false;	
			BGsidebar_mc._visible = false;
			scrollBar2._visible = false;
			isSidebarShrunk=true;
			triggerBomb(bomb);
		});
	}
}

function sidebarExpand(bomb:MovieClip)
{
var duration:Number;

	if(isSidebarShrunk == true){
		duration = 2.0;				
		//This is the orange sidebar
		BGsidebar_mc._alpha = 0;
		BGsidebar_mc._visible = true;
		BGsidebar_mc.tween(["_y", "_alpha"], [17, 100], duration, "easeOutSine");
	
		scrollBar2._alpha = 0;
		scrollBar2._visible = true;
		scrollBar2_mc.tween(["_y", "_alpha"], [17, 100], duration, "easeOutSine");

		isSidebarShrunk=false;
	}
	else{
		duration = noDuration;
	}

	textSidebar_mc.textSidebar_tx._x=0;
	textSidebar_mc.textSidebar_tx._y=0;
	textSidebar_mc.textSidebar_tx.wordWrap = true;
	textSidebar_mc.textSidebar_tx.multiline = true;
	textSidebar_mc.textSidebar_tx.html = true;
	textSidebar_mc.textSidebar_tx.styleSheet = sidebarBody_styleSheet;


	lightFuseBomb(duration,bomb);
}


var mainMenu:Array = new Array();

function loadMenuItems(url:String,bomb:MovieClip)
{
var menuItems:XML = new XML();
	
	menuItems.ignoreWhite = true;
	menuItems.onLoad = function(success:Boolean){
			if(success){
				var uniqueID = 0;
				if(menuItems.firstChild.nodeName == "menuItems"){
					var i:String;
					var myArray:Array = menuItems.childNodes;
					myArray = menuItems.firstChild.childNodes;
					for (i in myArray){

						if(myArray[i].nodeName == "menuItem"){

							//Create a new menu item
							var tempMenuItem_mc = _root.attachMovie("menuItem","menuItem_"+uniqueID.toString()+"_mc", _root.getNextHighestDepth());
							tempMenuItem_mc._uniqueID = uniqueID++;
							mainMenu.push(tempMenuItem_mc);

							tempMenuItem_mc.menuItemText_tx.textColor=menuTextFormatNotClickable;
							tempMenuItem_mc._visible=true;
							tempMenuItem_mc._alpha=0;
							tempMenuItem_mc._x=anchorBGmenu_x + 15;
							tempMenuItem_mc._y=underSkyline_y;
							tempMenuItem_mc._order=99;
							tempMenuItem_mc._indent=0;

							var breakBelow:Boolean = false;
							var clickable:Boolean = false;
							tempMenuItem_mc.templateType = "";
							tempMenuItem_mc.templateTitle = "";
							tempMenuItem_mc.templateURL = "";
							tempMenuItem_mc.sidebar = false;
							tempMenuItem_mc.sidebarTemplateType = "";
							tempMenuItem_mc.sidebarTemplateTitle = "";
							tempMenuItem_mc.sidebarTemplateURL = "";

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
									tempMenuItem_mc._order=index;
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
									}
								}
								else if(myArray2[j].nodeName == "indent"){
									var howMuch:Number = 10* myArray2[j].firstChild.nodeValue;
									tempMenuItem_mc._indent=howMuch;
									tempMenuItem_mc._x=anchorBGmenu_x + 15+howMuch;
									tempMenuItem_mc.menuItemText_tx.textColor=menuTextFormatInactive;
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
								line_mc._y=anchorBGmenu_y+25*tempMenuItem_mc._order+30;
								line_mc._height=3;
								line_mc._order = tempMenuItem_mc._order+0.5;
								var h:Number = 20;
								line_mc.lineStyle(2.0, 0xFFFFFF, 100);
								line_mc.moveTo(-15, h);
								line_mc.lineTo(BGmenu_mc._width-75,h);
								mainMenu.push(line_mc);
							}
							if(clickable){
									tempMenuItem_mc.menuItemText_tx.textColor=menuTextFormatInactive;
									tempMenuItem_mc.onRelease=function(){
											trace(">> clicked on:"+ (this.templateTitle));

											//Set up to clear last function and
											//then us later
											var temp_mc=clearCurrentTemplate.whichMenuItem;
											var tempFunction:Function = clearCurrentTemplate.clearFunction;

											this.enabled=false;
											clearCurrentTemplate.whichMenuItem = this;

											var xx = this.templateType;
											clearCurrentTemplate.clearFunction = function(){
												undispatchTemplate(xx);
											};

											tempFunction();
											temp_mc.enabled=true;



											//Move the menu indicator
											if(this._order == 0){
												relocateActiveMenuIndicator(25*this._order,25+5,17+this._indent,25+3,this._width-1);
											}
											else{
												relocateActiveMenuIndicator(25*this._order+6,25,17+this._indent,25-2,this._width-1);
											}

											//Bring in the sidebar and content as necessary
											if(this.sidebar == true){
													var x = this.sidebarTemplateType;
													var y = this.sidebarTemplateTitle;
													var z = this.sidebarTemplateURL;
													var myFunction= function(){
														dispatchTemplate(x,y,z);
													};
													bodyShrink(loadBomb(sidebarExpand(loadBomb(myFunction))));
											}
											else{
													sidebarShrink(loadBomb(bodyExpand));
											}
											//Load main content
											dispatchTemplate(this.templateType,this.templateTitle,this.templateURL);
									};
							}
							tempMenuItem_mc = null;
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


// site opening animation
function animateOpen() {

	clearAndResetPage();
	initialBuild(loadBomb(animateOverview));

}


// luci nav functions

function bodyShrink(bomb1:MovieClip,bomb2:MovieClip)
{
var duration:Number;

	if(isBodyShrunk == false){
		duration = 0.5;
		textBody_mc._x=216;
		textBody_mc._y=80;

		//shorten body section
		scrollBar1_mc.tween("_x", 757, duration, "easeInOutSine");
		whiteBlock_mc.tween("_x", 208+548, duration, "easeInOutSine");

		textBody_mc.textBody_tx.tween(["_x","_y","_width","_height"],[0,0,534,300],duration,"easeInOutSine");

	}
	else{
		duration = noDuration;
	}
	isBodyShrunk = true;

	trace(">> bodyShrink "+duration.toString());

	lightFuseBomb(duration,bomb1);
	lightFuseBomb(duration,bomb2);
}

function bodyExpand(bomb1:MovieClip,bomb2:MovieClip)
{
var duration:Number;

	if(isBodyShrunk == true){
		duration = 0.5;
		scrollBar1_mc.tween("_x", 931,duration , "easeInOutSine");
		whiteBlock_mc.tween("_x", 208+722, duration, "easeInOutSine");
		lightFusePayload(duration,function(){
				/*Adjust size of textBody */
				textBody_mc.tween(["_x","_y"],[565,80],duration,"easeInOutSine");
				textBody_mc.textBody_tx.tween(["_x","_y","_width","_height"],[0,0,357,380],duration,"easeInOutSine");
		});
	}
	else{
		duration = noDuration;
	}
	isBodyShrunk= false;

	lightFuseBomb(duration,bomb1);
	lightFuseBomb(duration,bomb2);
}

function loadTitle(myText:String){
	var duration:Number = 0.5;
	titleBody_mc._visible=true;		
	titleBody_mc.titleBody_tx.tween("_alpha",0,duration,"linear");
	lightFusePayload(duration,function(){
			titleBody_mc.titleBody_tx.text = myText;
			titleBody_mc.titleBody_tx.tween("_alpha",100,duration,"linear");
	});
}


function loadText(myText:String)
{
		trace(">> Huge Error");
	var duration:Number = 0.5;

	textBody_mc._visible=true;		
	textBody_mc._x = 0;
	textBody_mc._y = 0;
	textBody_mc.textBody_tx._x=0;
	textBody_mc.textBody_tx._y=0;
	textBody_mc.textBody_tx._width=200;
	textBody_mc.textBody_tx._height=200;

	textBody_mc.textBody_tx.tween("_alpha",0,duration,"linear");
	trace(">> text going down");
	lightFusePayload(duration,function(){
			textBody_mc.textBody_tx.text = myText;
			textBody_mc.textBody_tx.tween(["_alpha","_x","_y","_width","_height"],[100,0,0,357,380],duration,"linear");
	});
}

function loadHTMLText(myText:String)
{
	var duration:Number = 0.5;

	textBody_mc.textBody_tx.tween(["_alpha"],[0],duration,"linear");

	lightFusePayload(duration,function(){
			textBody_mc.textBody_tx.htmlText = myText;
			textBody_mc.textBody_tx.tween("_alpha",100,duration,"linear");
	});
}

function blindWhite(){
	blindWhite_mc._visible = true;
	blindWhite_mc._alpha = 100;
	blindWhite_mc._x = 213;
	blindWhite_mc._y = 74;
	blindWhite_mc._width = 541;
	blindWhite_mc._height = 438;
}


function blindOrange(){
	blindOrange_mc._visible = true;
	blindOrange_mc._alpha = 100;
	blindOrange_mc._x = 789;
	blindOrange_mc._y = 74;
	blindOrange_mc._width = 138;
	blindOrange_mc._height = 438;
};

function unblindOrange(bomb:MovieClip)
{
var duration:Number = 1.0;

	blindOrange_mc.tween(["_x", "_y", "_alpha"], [789, underSkyline_y, 0], duration, "easeInSine");
	lightFusePayload(duration, function(){
		blindOrange_mc._visible = false;
		triggerBomb(bomb);
	});
};

function unblindWhite(bomb:MovieClip){

	blindWhite_mc.tween(["_x", "_y", "_alpha"], [213, underSkyline_y, 0], 1, "easeInSine");			
	lightFusePayload(duration, function(){
		blindWhite_mc._visible = false;
		triggerBomb(bomb);
	});
}


function animateOverview() {
		/*
	trace(">> animateOverview");

	clearAndResetPage();
	
	relocateActiveMenuIndicator(0,32,19,30,58);
	BGmenu_mc.menuOverviewWhite_mc._visible = true;

	var bomb1,bomb2,bomb3:MovieClip;

	// Chain events In reverse order
	bomb1 = loadBomb(loadOverviewContent);
	bomb2 = loadBomb(loadSidebarContent);

	if(BGsidebar_mc._visible == false){
		bomb3 = bomb2;
		bomb2 = loadBomb(function(){sidebarExpand(bomb3)});
	}

	bodyShrink(bomb1,bomb2);
	*/

};


function loadOverviewContent(){
	loadTitle("LABORATORY for UBIQUITOUS COMPUTING and INTERACTION");

	blindWhite();
	loadOverviewText();
	unblindWhite();
}

function loadSidebarTitle(title:String)
{
var duration:Number = 0.5;

	titleSidebar_mc._visible = true;
	titleSidebar_mc.titleSidebar_tx.tween("_alpha",0,duration,"linear");

	lightFusePayload(duration,function(){
			titleSidebar_mc.titleSidebar_tx.text = title;
			titleSidebar_mc.titleSidebar_tx.tween("_alpha",100,duration,"linear");
			titleBody_mc.titleBody_tx.tween("_alpha",100,duration,"linear");
	});
}



function loadSidebarHTMLText(text:String)
{
var duration:Number = 0.5;
			
	textSidebar_mc._visible = true;
	textSidebar_mc.tween("_alpha",0,duration,"linear");

	lightFusePayload(duration,function(){
			textSidebar_mc.textSidebar_tx.htmlText = text;
			textSidebar_mc.tween("_alpha",100,duration,"linear");
	});
}; 

function addSidebarText(text:String)
{
	textSidebar_mc.textSidebar_tx.text += text;
}


function templateA(title:String,URL:String)
{
var document:XML = new XML();
	


	loadTitle(title);

	document.ignoreWhite = true;
	document.onData = function(src:String){

		loadHTMLText(src);

		//Cause scrollBar1._x is in the middle of the scrollbar somewhere
		var scrollBar1Pad:Number = 18;
		var gap = (((scrollBar1_mc._x-scrollBar1Pad)-BGBodyMasked_mc._x)/3);
		var image01_pad= (gap - image01_mc._width)/2; 
		image01_mc._x= BGBodyMasked_mc._x+0*gap + image01_pad;
		image01_mc._y=underSkyline_y;
		image01_mc._alpha=0;
		image01_mc._visible=true;
		var image02_pad= (gap - image02_mc._width)/2; 
		image02_mc._x= BGBodyMasked_mc._x+1*gap + image02_pad;
		image02_mc._y=underSkyline_y;
		image02_mc._alpha=0;
		image02_mc._visible=true;
		var image03_pad= (gap - image03_mc._width)/2; 
		image03_mc._x= BGBodyMasked_mc._x+2*gap + image03_pad;
		image03_mc._y=underSkyline_y;
		image03_mc._alpha=0;
		image03_mc._visible=true;

		var loadListener:Object = new Object();

		loadListener.onLoadComplete = function(target_mc:MovieClip, httpStatus:Number):Void {
			target_mc.tween(["_alpha","_y"],[100,350],3.0,"easeOutSine");
			image01_mc.onRelease=function(){
					jumpToURL("http://82.198.155.50/congestionMap.htm");
			}
			image02_mc.onRelease=function(){
					jumpToURL("http://springerlink.metapress.com/openurl.asp?genre=article&issn=0302-9743&volume=3205&spage=433");
			}
			image03_mc.onRelease=function(){
					jumpToURL("http://www.flickr.com/photos/julianbleecker/87099551/");
			}
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
		mcLoader1.addListener(loadListener);
		mcLoader1.loadClip("websiteContent/overview/overviewPhoto03.jpg",image01_mc);

		var mcLoader2:MovieClipLoader = new MovieClipLoader();
		mcLoader2.addListener(loadListener);
		mcLoader2.loadClip("websiteContent/overview/overviewPhoto02.jpg",image02_mc);

		var mcLoader3:MovieClipLoader = new MovieClipLoader();
		mcLoader3.addListener(loadListener);
		mcLoader3.loadClip("websiteContent/overview/overviewPhoto01.jpg",image03_mc);

	}
	document.load(URL);
}

function clearTemplateA()
{
var duration:Number = 0.5;

	image01_mc.tween(["_x","_y","_alpha"],[214,underSkyline_y,0],duration,"easeInSine");
	image02_mc.tween(["_x","_y","_alpha"],[395,underSkyline_y,0],duration,"easeInSine");
	image03_mc.tween(["_x","_y","_alpha"],[576,underSkyline_y,0],duration,"easeInSine");

}

function templateSA(title,URL)
{
var document:XML = new XML();

	loadSidebarTitle(title);
	
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
							runningText= "<p>"+lastDate+"</p><p><a href=\"asfunction:_root.jumpToURL,"+url+"\">"+title+"</a></p><br/>" +runningText;
						}
						else{
							runningText="&nbsp;&nbsp;&nbsp;<a href=\"asfunction:_root.jumpToURL,"+url+"\">"+title+"</a><br>"+runningText;
						}
					}
					//trace(">> "+runningText);
				}
				loadSidebarHTMLText(runningText);

			}
			else{
				trace(">> Unknown element in templateSA "+document.firstChild.nodeName);
			}
		}
		else{
			trace(">> Trouble loading XML in templateSA");
		}

	}
	document.load(URL);
}

function dispatchTemplate(type:String,title:String,URL:String)
{
		trace(">> Dispatch Template "+type+" "+title+" "+URL);
		if(type=="A"){
			templateA(title,URL);
		}
		else if(type=="SA"){
			templateSA(title,URL);
		}
		else{
			trace(">> Unknown Template");
		}
}

function undispatchTemplate(type:String)
{
		trace(">> Undispatch Template "+type);
		if(type=="A"){
			clearTemplateA(title,URL);
		}
		else if(type=="SA"){
			templateSA(title,URL);
		}
		else{
			trace(">> Unknown Template");
		}
}


function animateWeAreCourses() 
{
	trace(">> We Are Courses");
	clearAndResetPage();
	BGmenu_mc.menuCoursesWhite_mc._visible = true;
	relocateActiveMenuIndicator(57,28,29, 26, 52);

	createGun("gunC01_mc");
	createGun("gunC02_mc");

	loadGun(gunC02_mc,loadWeAreCoursesContent);

	loadGun(gunC01_mc,function(){bodyExpand(gunC02_mc)});

	sidebarDisappear(gunC01_mc);
}

function loadWeAreCoursesText(){
	// drop in XML text here. You will need to set up an array to take care of 
	// course names and drop them into the sectionListItem movie clips.
	sectionListItem_mc1.sectionListItem_tx.text = "Course One"
	sectionTitle_mc.sectionTitle_tx.text = "Course One"
	sectionData_mc.sectionData_tx.text = "This is the section Data for course one."
	textBody_mc.textBody_tx.text = "This is course1 text. This is course1 text. This is course1 text. This is course1 text. This is course1 text. This is course1 text."
}

function loadWeAreCoursesContent(){
	loadTitle("WE ARE LUCI: COURSES");

	blindWhite("loadWeAreCourses");

	sectionImage_mc._visible = true;
	sectionTitle_mc._visible = true;
	sectionData_mc._visible = true;
	sectionListItem_mc1._visible = true; //same for additional list items
			
	dividerVert_mc._x = 376;
	dividerVert_mc._y = 83;
	dividerVert_mc._visible = true;
	dividerVert_mc._alpha = 100;
				
	loadWeAreCoursesText();
	unblindWhite();
}


function animateWeAreProjects() 
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(82,28,29, 26, 55);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuProjectsWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "WE ARE LUCI: PROJECTS";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "Project One"
				sectionTitle_mc.sectionTitle_tx.text = "Project One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for Project one."
				textBody_mc.textBody_tx.text = "This is project1 text. This is project1 text. This is project1 text. This is project1 text. This is project1 text. This is project1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}


function animateWeAreBios()
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(107,28,29, 26, 25);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuBiosWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "WE ARE LUCI: BIOS";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "Bio One"
				sectionTitle_mc.sectionTitle_tx.text = "Bio One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for Bio one."
				textBody_mc.textBody_tx.text = "This is bio1 text. This is bio1 text. This is bio1 text. This is bio1 text. This is bio1 text. This is bio1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}



function animateNewsLocal() 
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(156,28,29, 26, 37);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuLocalWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "UBICOMP NEWS: LOCAL";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "Local One"
				sectionTitle_mc.sectionTitle_tx.text = "Local One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for Local one."
				textBody_mc.textBody_tx.text = "This is local1 text. This is local1 text. This is local1 text. This is local1 text. This is local1 text. This is local1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}



function animateNewsRegional() 
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(182,28,29, 26, 58);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuRegionalWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "UBICOMP NEWS: REGIONAL";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "Regional One"
				sectionTitle_mc.sectionTitle_tx.text = "Regional One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for Regional one."
				textBody_mc.textBody_tx.text = "This is regional1 text. This is regional1 text. This is regional1 text. This is regional1 text. This is regional1 text. This is regional1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}



function animateNewsWorld() 
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(207,28,29, 26, 41);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuWorldWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "UBICOMP NEWS: WORLD";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "World One"
				sectionTitle_mc.sectionTitle_tx.text = "World One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for World one."
				textBody_mc.textBody_tx.text = "This is world1 text. This is world1 text. This is world1 text. This is world1 text. This is world1 text. This is world1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}



function animateDataRepository() 
{
	// remove content & unused interface pieces:
	clearAndResetPage();
	
	turnOffActiveMenuStates();
	
	relocateActiveMenuIndicator(236,30,19, 28, 100);

	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuDataRepositoryWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "DATA REPOSITORY";
				// add blinds
				blindWhite_mc._visible = true;
				blindWhite_mc._alpha = 100;
				blindWhite_mc._x = 213;
				blindWhite_mc._y = 74;
				blindWhite_mc._width = 713;
				blindWhite_mc._height = 438;
				
				// add content behind blinds
				textBody_mc._x = 565;
				textBody_mc._y = 80;
				textBody_mc.textBody_tx._width = 357;
				textBody_mc.textBody_tx._height = 380;
				sectionImage_mc._visible = true;
				sectionTitle_mc._visible = true;
				sectionData_mc._visible = true;
				sectionListItem_mc1._visible = true; //same for additional list items
				
				dividerVert_mc._x = 376;
				dividerVert_mc._y = 83;
				dividerVert_mc._visible = true;
				dividerVert_mc._alpha = 100;
				
				// drop in XML text here. You will need to set up an array to take care of 
				// course names and drop them into the sectionListItem movie clips.
				sectionListItem_mc1.sectionListItem_tx.text = "Data One"
				sectionTitle_mc.sectionTitle_tx.text = "Data One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for Data one."
				textBody_mc.textBody_tx.text = "This is data1 text. This is data1 text. This is data1 text. This is data1 text. This is data1 text. This is data1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}


//Launch

animateOpen();
