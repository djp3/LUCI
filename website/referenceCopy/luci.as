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

// turn off active menu states
BGmenu_mc.menuOverviewWhite_mc._visible = false;

BGmenu_mc.menuCoursesWhite_mc._visible = false;
BGmenu_mc.menuProjectsWhite_mc._visible = false;
BGmenu_mc.menuBiosWhite_mc._visible = false;

BGmenu_mc.menuLocalWhite_mc._visible = false;
BGmenu_mc.menuRegionalWhite_mc._visible = false;
BGmenu_mc.menuWorldWhite_mc._visible = false;
BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;


// parallax
var mouseListener:Object = new Object();
mouseListener.onMouseMove = function() {
	myX = _xmouse;
	skyline_mc.skyline1_mc._x = 0-(myX/10);
	skyline_mc.skyline2_mc._x = 0-(myX/20);
	skyline_mc.skyline3_mc._x = 0-(myX/50);
};
Mouse.addListener(mouseListener);

animateOpen();

// setup menu handling: clicks
BGmenu_mc.menuOverview_mc.onRelease = animateOverview;
BGmenu_mc.menuWeAreLuci_mc.onRelease = animateWeAreCourses;
BGmenu_mc.menuCourses_mc.onRelease = animateWeAreCourses;
BGmenu_mc.menuProjects_mc.onRelease = animateWeAreProjects;
BGmenu_mc.menuBios_mc.onRelease = animateWeAreBios;
BGmenu_mc.menuNews_mc.onRelease = animateNewsLocal;
BGmenu_mc.menuLocal_mc.onRelease = animateNewsLocal;
BGmenu_mc.menuRegional_mc.onRelease = animateNewsRegional;
BGmenu_mc.menuWorld_mc.onRelease = animateNewsWorld;
BGmenu_mc.menuDataRepository_mc.onRelease = animateDataRepository;



// site opening animation
function animateOpen() {
	// set text vars = 0
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textBody_mc.textBody_tx.text = "";
	textSidebar_mc._visible = false;
	blindWhite_mc._visible = false;
	blindOrange_mc._visible = false;
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// bare interface pieces
	BGmenu_mc.roundedTween(["_x", "_y", "_alpha"], [17, 115, 100], 1, "easeOutSine", 0);
	BGBodyMasked_mc.roundedTween(["_x", "_y", "_alpha"], [208, 17, 100], 1, "easeOutSine", .25);
	scrollBar1_mc.roundedTween(["_x", "_y", "_alpha"], [757, 17, 100], 1, "easeOutSine", .25);
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 17, 100], 1, "easeOutSine", .5);
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 17, 100], 1, "easeOutSine", .5);
	scrollBar2_mc.onTweenComplete = function(propName) 
		{
			if (propName == "_y") 
			{
				animateOverview();
			}
		}
}


// luci nav functions



function animateOverview() {
	// remove content & unused interface pieces:
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween (["_x", "_y"], [0, 0], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 32;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [19, 30, 58], .5, "easeInOutSine");

	// remove content & unused interface pieces:
	// blank out text boxes
	sectionListItem_mc1._visible = false; // you'll need to do the same to any other sectionListItem movie clips
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	textBody_mc.textBody_tx.text = "";
	dividerVert_mc._visible = false;
	
	
	//shorten body section, bring in News sidebar
	scrollBar1_mc.roundedTween("_x", 757, .5, "easeInOutSine");
	BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 548, .5, "easeInOutSine");
	BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
	{
		BGsidebar_mc._visible = true;
		scrollbar2_mc._visible = true;
		BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 17, 100], 1, "easeOutSine");
		scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 17, 100], 1, "easeOutSine");
		scrollBar2_mc.onTweenComplete = function(propName) 
		{
			if (propName == "_y") 
			{
			BGmenu_mc.menuOverviewWhite_mc._visible = true;
			titleBody_mc.titleBody_tx.text = "OVERVIEW: LABORATORY for UBIQUITOUS COMPUTING and INTERACTION";
			titleSidebar_mc.titleSidebar_tx.text = "UBICOMP NEWS";
			
			// add blinds
			blindOrange_mc._visible = true;
			blindOrange_mc._alpha = 100;
			blindOrange_mc._x = 789;
			blindOrange_mc._y = 74;
			blindOrange_mc._width = 138;
			blindOrange_mc._height = 438;
			
			blindWhite_mc._visible = true;
			blindWhite_mc._alpha = 100;
			blindWhite_mc._x = 213;
			blindWhite_mc._y = 74;
			blindWhite_mc._width = 541;
			blindWhite_mc._height = 438;
			
			// add content behind blinds
			textBody_mc._x = 216;
			textBody_mc._y = 80;
			textBody_mc.textBody_tx._width = 534;
			textBody_mc.textBody_tx._height = 380;
			textSidebar_mc._visible = true;
			
			// drop in XML text here.
			textBody_mc.textBody_tx.text = "This is overview text. This is overview text. This is overview text. This is overview text. This is overview text. This is overview text."
			textSidebar_mc.textSidebar_tx.text = "This is text for the news section. This is text for the news section. This is text for the news section. This is text for the news section. "
			
			//reveal content
			blindOrange_mc.roundedTween(["_x", "_y", "_alpha"], [789, 574, 0], 1, "easeInSine");
			blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");			
			
			}
		}
	}
}


function animateWeAreCourses() 
{
	// remove content & unused interface pieces:
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 57], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 52], .5, "easeInOutSine");
	
	//remove sidebar, etc.
	BGsidebar_mc.roundedTween(["_x", "_y", "_alpha"], [785, 517, 0], 1, "easeInOutSine");
	scrollBar2_mc.roundedTween(["_x", "_y", "_alpha"], [931, 517, 0], 1, "easeInOutSine");
	BGsidebar_mc._visible = false;
	scrollbar2_mc._visible = false;
	scrollBar2_mc.onTweenComplete = function(propName) 
	{
		if (propName == "_y") 
		{
			BGmenu_mc.menuCoursesWhite_mc._visible = true;
			scrollBar1_mc.roundedTween("_x", 931, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.roundedTween("_x", 722, .5, "easeInOutSine");
			BGBodyMasked_mc.whiteBlock_mc.onTweenComplete = function()
			{
				titleBody_mc.titleBody_tx.text = "WE ARE LUCI: COURSES";
				// add blinds
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
				sectionListItem_mc1.sectionListItem_tx.text = "Course One"
				sectionTitle_mc.sectionTitle_tx.text = "Course One"
				sectionData_mc.sectionData_tx.text = "This is the section Data for course one."
				textBody_mc.textBody_tx.text = "This is course1 text. This is course1 text. This is course1 text. This is course1 text. This is course1 text. This is course1 text."
				
				//reveal content
				blindWhite_mc.roundedTween(["_x", "_y", "_alpha"], [213, 574, 0], 1, "easeInSine");	
			}
		}
	}
}


function animateWeAreProjects() 
{
	// remove content & unused interface pieces:
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 82], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 55], .5, "easeInOutSine");

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
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 107], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 25], .5, "easeInOutSine");

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
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 156], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 37], .5, "easeInOutSine");

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
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 182], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 58], .5, "easeInOutSine");

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
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 207], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 28;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [29, 26, 41], .5, "easeInOutSine");

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
	// blank out text boxes
	textBody_mc.textBody_tx.text = "";
	titleBody_mc.titleBody_tx.text = "";
	titleSidebar_mc.titleSidebar_tx.text = "";
	textSidebar_mc._visible = false;
	
	sectionImage_mc._visible = false;
	sectionTitle_mc._visible = false;
	sectionData_mc._visible = false;
	sectionListItem_mc1._visible = false; //same for additional list items
	dividerVert_mc._visible = false;
	
	// turn off active menu states
	BGmenu_mc.menuOverviewWhite_mc._visible = false;
	
	BGmenu_mc.menuCoursesWhite_mc._visible = false;
	BGmenu_mc.menuProjectsWhite_mc._visible = false;
	BGmenu_mc.menuBiosWhite_mc._visible = false;

	BGmenu_mc.menuLocalWhite_mc._visible = false;
	BGmenu_mc.menuRegionalWhite_mc._visible = false;
	BGmenu_mc.menuWorldWhite_mc._visible = false;
	BGmenu_mc.menuDataRepositoryWhite_mc._visible = false;
	
	// relocate active menu indicator
	BGmenu_mc.menuActive_mc.tween(["_x", "_y"], [0, 236], .5, "easeInOutSine");
	BGmenu_mc.menuActive_mc.menuActiveGray_mc._height = 30;
	BGmenu_mc.menuActive_mc.menuActiveOrange_mc.tween (["_x", "_y", "_width"], [19, 28, 100], .5, "easeInOutSine");

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

