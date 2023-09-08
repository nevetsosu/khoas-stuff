ifndef saveLoad_wdl;
define saveLoad_wdl;

// ---------------------------------------------------------------------
// STARTHEADER
//
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Save / Load Game State
// class: INTERFACE
// type: SUPPORT
// image: saveload.pcx
// help: Allows player to save current game state to one of 8 'slots'.
// help:Player can load a saved game state from a previously used slot.
//
//
// prefix: saveLoad00_
// idcode: 018
//
// needs: miscInput01.wdl
//
// ENDHEADER
// ---------------------------------------------------------------------
// entry: Save Game Directory
// id: 1
string	saveLoad00_dir_str = "";	// save game directory (pathed from game directory)

// entry: Save Game Basename
// help: This name plus the slot number will be used to save states
// id: 2
string	saveLoad00_basename_str = "Saves";

// fixed number of save games
define	saveLoad00_slot_num = 36;

// entry: Cancel save/load key
// id: 4
string saveLoad00_esc_key_c = "esc";
//
var starthour = 0;
var startmin = 0;
var 	saveLoad00_esc_scancode = 0;

// entry: Save mode
// help: See C-Script documentation for details (0 is default)
// id: 5
var	saveLoad00_savemode = 0;
var	item_down_scancode = 0;
// entry: Previous item up key
// id: 34
//string menu01_item_up_key_c = "cuu";
var	item_up_scancode = 0;
// entry: Previous item to the left key
// id: 35
//string menu01_item_left_key_c = "cul";
var	item_left_scancode = 0;
// entry: Next item to the right key
// id: 36
//string menu01_item_right_key_c = "cur";
var	item_right_scancode = 0;
// entry: Execute the current item key
// id: 37
//string menu01_item_execute_key_c = "enter";
var	item_execute_scancode = 0;
//
var saveLoad00_movesel = 0;  //var for moving lesson selection cursor
// entry: Save game mouse bitmap
// id: 6
bmap	saveLoad00_save_mouse_bmp = <arrow_red.pcx>;
// entry: Load game mouse bitmap
// id: 7
bmap	saveLoad00_load_mouse_bmp = "arrow_blue.pcx";
bmap*	saveLoad00_tmp_mouse_bmp;   			// used to temp store old mousemap
BMAP closehelpbutton_bmp = "closehelpwinbutton.bmp";
FONT titlefont="Arial",1,18;
FONT big20_font = "Arial", 1,20;

//----------------------------------------------------------------------
// section: Save Game Panel

// entry: The "Save Game" Background panel bitmap
// id: 8
bmap saveLoad00_save_bmp = <saveLoad00_save_bmp.pcx>;

// enable: Auto Center Panel?
// id: 9
define saveLoad00_auto_center_save;


panel saveLoad00_save_pan
{
// entry: Layer
// id: 10
	layer = 10;
// entry: Pos X
// help: Position X (only valid if auto center is off)
// id: 11
	pos_x = 0;
// entry: Pos Y
// help: Position Y (only valid if auto center is off)
// id: 12
	pos_y = 0;

	bmap = saveLoad00_save_bmp;

 	flags = refresh;
}

//----------------------------------------------------------------------
// section: Load Lesson Panel

// entry: The "Load" Background panel bitmap
// id: 13
bmap saveLoad00_load_bmp = "saveLoad00_load_bmp.bmp";

// enable: Auto Center Panel?
// id: 14
define saveLoad00_auto_center_load;


panel saveLoad00_load_pan =
{
// entry: Layer
// id: 15
	layer = 10;
// entry: Pos X
// help: Position X (only valid if auto center is off)
// id: 16
	pos_x = 0;
// entry: Pos Y
// help: Position Y (only valid if auto center is off)
// id: 17
	pos_y = 0;

	bmap = saveLoad00_load_bmp;

 	flags = refresh;
}

//----------------------------------------------------------------------
// section: save/load slot buttons

// entry: Empty slot bitmap
// help: Bitmap used to represent an empty slot
// id: 18
bmap saveLoad00_empty_bmp = <emptyslot.bmp>; //<saveLoad00_empty_bmp.pcx>;

// entry: Full slot bitmap
// help: Bitmap used to represent an full slot
// id: 19
bmap saveLoad00_full_bmp = <emptyslot.bmp>; //<saveLoad00_full_bmp.pcx>;

// entry: Start X
// help: Starting position of first save/load slot (offset from panel pos)
// id: 20
define	saveLoad00_slot_pos_x = 15;  //was 10
// entry: Start Y
// help: Starting position of first save/load slot (offset from panel pos)
// id: 21
define	saveLoad00_slot_pos_y = 55; //was 80
//
var menu01_active_b=0;
//function SaveLoad00_Slot_Showhide_All2()
// save/load slot function prototypes

function saveLoad00_slot1_click();

function saveLoad00_slot2_click();
function saveLoad00_slot3_click();
function saveLoad00_slot4_click();
function saveLoad00_slot5_click();
function saveLoad00_slot6_click();
function saveLoad00_slot7_click();
function saveLoad00_slot8_click();
function saveLoad00_slot9_click();
function saveLoad00_slot10_click();
function saveLoad00_slot11_click(); //next button
//function saveLoad00_slot12_click(); // click info text line
function saveLoad00_slot13_click(); //Lesson 11
function saveLoad00_slot14_click();
function saveLoad00_slot15_click();
function saveLoad00_slot16_click();
function saveLoad00_slot17_click(); //Lesson 15
function saveLoad00_slot18_click();
function saveLoad00_slot19_click();
function saveLoad00_slot20_click();
function saveLoad00_slot21_click(); //Lesson 19
function saveLoad00_slot22_click(); //Lesson 20
function saveLoad00_slot23_click();//NEXT Lessons 21-30 button
function saveLoad00_slot24_click();//PREV Lessons 1-10 button
function saveLoad00_slot25_click();//Lesson 21
function saveLoad00_slot26_click();//
function saveLoad00_slot27_click();//Lesson 23
function saveLoad00_slot28_click(); 
function saveLoad00_slot29_click();//Lesson 25
function saveLoad00_slot30_click();//Lesson 26
function saveLoad00_slot31_click();//Lesson 27
function saveLoad00_slot32_click();//
function saveLoad00_slot33_click();//Lesson 29
function saveLoad00_slot34_click();//Lesson 30
function saveLoad00_slot35_click();//PREV 11-20 Lessons button
function saveLoad00_slot36_click();//PREV 1-11 Lessons button
function saveLoad00_closelessonswindow();
function saveLoad00_slot37_click();//L31
function saveload00_slot38_click();
function saveLoad00_slot39_click();
function saveLoad00_slot40_click();
function saveLoad00_slot41_click();//pass opposing night L35

function saveLoad00_slot43_click();
function saveLoad00_slot44_click();
function saveLoad00_slot45_click();

function SaveLoad00_LoadState(name, num);
function SaveLoad00_LoadState_Display();
function	SaveLoad00_Slot_Set_All(base_x, base_y);
function	SaveLoad00_Slot_ShowHide_All(showhide);  //page one of lessons
function	SaveLoad00_Slot_ShowHide_All2(showhide);
function	SaveLoad00_Slot_ShowHide_All3(showhide);
function	SaveLoad00_Slot_ShowHide_All4(showhide);
//
//Lesson titles
//
STRING getstartedtitle_str ="1. Getting Started (No Time Limit)";
STRING lesson2title_str ="2. Vehicle Following (3 min.)";
STRING lesson3title_str ="3. Passing, No Oncoming Traffic";
STRING lesson4title_str ="4. Passing, Oncoming Traffic (5 min.)";
STRING lesson5title_str ="5. Passing Large Trucks (5 min.)";
STRING lesson6title_str ="6. Left Turn, Light Traffic (< 3 min.)";
STRING lesson7title_str ="7. Left Turn, Heavy Traffic (< 3 min.)";
STRING lesson8title_str ="8. Parking, Diagonal (No Time Limit)";
STRING lesson9title_str ="9. Parking, Parallel (No Time Limit)";
STRING lesson10title_str ="10. Construction Hazard (< 3 min.)";
STRING nextlessonstitle_str="Next Scenarios >>";
//STRING lesson12=
STRING lesson11title_str ="11. Slow Vehicle (< 3 min.)";//van slows to crawl
STRING lesson12title_str ="12. Road Hazards (< 3 min.)"; //Man jumps out from behind car
STRING lesson13title_str ="13. Left Turn MidBlock (< 3 min.)"; //Cross two lanes
STRING lesson14title_str ="14. Left Intersection Turn (< 3 min.)"; //Peds crossing
STRING lesson15title_str ="15. Traffic Jam (< 3 min.)"; //Driver may block intersection
STRING lesson16title_str ="16. Curves and Straights (8 min.)"; //Blocked traffic lane
STRING lesson17title_str ="17. Parking in Traffic (No Time Limit)";
STRING lesson18title_str ="18. Parallel Parking in Traffic (No Time Limit)";
STRING lesson19title_str="19. Left Turn, Fog (< 3 min.)";
STRING Lesson20title_str="20. Passing, Oncoming Traffic, Fog";
//STRING Nextlessons_str="		Next Scenarios >>";
STRING Prev1to10title_str="<< Prev Scenarios 1-10";
STRING Lesson21title_str="21. Freeway Entry (< 3 min.)";//enter freeway merge with traffic
STRING Lesson22title_str="22. Freeway Entry (< 3 min.), Heavy Traffic"; //exit freeway from center lane
STRING Lesson23title_str="23. Night Driving, Rural (No Time Limit)";
STRING Lesson24title_str="24. Freeway Exit, Fast Lane (< 3 min.)";
STRING Lesson25title_str="25. Driving Test, Rural, v.3 (10 min.)";
STRING Lesson26title_str="26. Driving Test, Urban, v.3 (12 min.)";
STRING Lesson27title_str="27. Driving Test, Rural, v.2 (10 min.)";
STRING Lesson28title_str="28. Driving Test Urban, v.2 (12 min.)";
STRING Lesson29title_str="29. Driving Test, Rural, v.1 (10 min.)";
STRING Lesson30title_str="30. Driving Test Urban, v.1 (12 min.)"; //urban then freeway then exit and park at DMV
STRING Prev11to20title_str="<< Prev Scenarios 11-20";
STRING nextlessons31to40title_str="Next Scenarios >>";
STRING lessonloading_str="Loading Scenario ...";
STRING clicklessons_str= "Click Scenario Title to Load";
STRING Lesson31title_str="31. Curves and Straights, Night";
STRING Lesson32title_str="32. Parking Urban, Night";
STRING Lesson33title_str="33. Left Turn, Night (<3 min.)";
STRING Lesson34title_str="34. Night Urban Hazards (10 min.)";
STRING Lesson35title_str="35. Pass Opposing Night (< 4 min)";
STRING Prev21to30title_str="<<Prev Scenarios 21-30";
STRING Prev11to20title_str="<<Prev Scenarios 11-20";
STRING Prev1to10title_str="<<Prev Scenarios 1-10";
STRING Panel4Prev11to20title_str="<<Prev Scenarios 11-20";
STRING Panel4Prev1to10title_str="<<Prev Scenarios 1-10";
STRING Panel4Prev21to30title_str="<<Prev Scenarios 21-30";
///
TEXT lessonloading_txt =
{
	pos_x = 200;
	pos_y = 200;
	layer = 13;
	font = big20_font;
	string = <lessonloading_str>;
}


TEXT getstartedtitle_txt =
{
	pos_x = 490; //
	pos_y = 293;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<getstartedtitle_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}

TEXT lesson2title_txt =
{
	pos_x = 490; //
	pos_y = 312;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson2title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson3title_txt =
{
	pos_x = 490; //
	pos_y = 331;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson3title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson4title_txt =
{
	pos_x = 490; //
	pos_y = 350;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson4title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson5title_txt =
{
	pos_x = 490; //
	pos_y = 370;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson5title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson6title_txt =
{
	pos_x = 490; //
	pos_y = 389;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson6title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson7title_txt =
{
	pos_x = 490; //
	pos_y = 408;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson7title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson8title_txt =
{
	pos_x =490; //
	pos_y = 427;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson8title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson9title_txt =
{
	pos_x = 490; //
	pos_y = 446;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson9title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson10title_txt =  //slot 10 construction hazard
{
	pos_x = 490; //
	pos_y = 465;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson10title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT nextlessonstitle_txt =  //slot 11 next lessons button
{
	pos_x = 650; //
	pos_y = 482;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<nextlessonstitle_str>;
}
//allow space for click info at bottom of page 1, no slot function
//
TEXT clicklessons_txt =  //display only
{
	pos_x = 320; //
	pos_y = 653;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<clicklessons_str>;
}

// second page of lessons
//
TEXT lesson11title_txt =    //slot 13 stalled vehicle lesson 11
{
	pos_x = 490; //
	pos_y = 293;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson11title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson12title_txt =  //slot 14 Road Debris
{
	pos_x = 490; //
	pos_y = 312;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson12title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson13title_txt =  //slot 15 Left Turn MidBlock
{
	pos_x = 490; //
	pos_y = 331;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson13title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson14title_txt =   //slot 16 Left Turn Intersection
{
	pos_x = 490; //
	pos_y = 350;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson14title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson15title_txt =    //slot 17 Traffic Jam
{
	pos_x = 490; //
	pos_y = 370;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson15title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson16title_txt =     //slot 18  Right Intersect Turn URBAN
{
	pos_x = 490; //
	pos_y = 389;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson16title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson17title_txt =    //slot 19 Quick Park URBAN
{
	pos_x = 490; //
	pos_y = 408;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson17title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson18title_txt =    //slot 20
{
	pos_x = 490; //
	pos_y = 427;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson18title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson19title_txt =    //slot 21
{
	pos_x = 490; //
	pos_y = 446;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson19title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson20title_txt =  //slot 22
{
	pos_x = 490; //
	pos_y = 465;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson20title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT nextlessons21to30title_txt =  //slot 23
{
	pos_x = 700; //
	pos_y = 482;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<nextlessonstitle_str>;
}
TEXT prev1to10title_txt =    //slot 24
{
	pos_x = 490; //
	pos_y = 500;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<prev1to10title_str>;
}
//
// Third page of lessons
//
TEXT lesson21title_txt =  //slot 25 freeway entry
{
	pos_x = 490; //
	pos_y = 293;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson21title_str>;
}
TEXT lesson22title_txt =  //slot 26 freeway exit
{
	pos_x = 490; //
	pos_y = 312;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson22title_str>;
}
TEXT lesson23title_txt =  //slot 27 freeway vehicle hazard
{
	pos_x = 490; //
	pos_y = 331;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson23title_str>;
}
TEXT lesson24title_txt =   //slot 28 freeway lane change
{
	pos_x = 490; //
	pos_y = 350;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson24title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson25title_txt =
{
	pos_x = 490; //
	pos_y = 370;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson25title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson26title_txt =
{
	pos_x = 490; //
	pos_y = 389;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson26title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson27title_txt =
{
	pos_x = 490; //
	pos_y = 408;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson27title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson28title_txt =
{
	pos_x = 490; //
	pos_y = 427;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson28title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson29title_txt =
{
	pos_x = 490; //
	pos_y = 446;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson29title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}
TEXT lesson30title_txt =
{
	pos_x = 490; //
	pos_y = 465;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson30title_str>;
	//flags = NOFILTER; //not visible until HUD loaded	
}

TEXT prev11to20title_txt =
{
	pos_x = 490; //
	pos_y = 482;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<prev11to20title_str>;
}
TEXT nextlessons31to40title_txt =  //slot 11 next lessons button
{
	pos_x = 700; //
	pos_y = 501;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<nextlessonstitle_str>;
}

//
//Page 4 Lessons
//
TEXT Lesson31title_txt =
{
	pos_x = 490; //
	pos_y = 293;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson31title_str>;	
}
TEXT lesson32title_txt =
{
	pos_x = 490; //
	pos_y = 312;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson32title_str>;
}
TEXT lesson33title_txt =
{
	pos_x = 490; //
	pos_y = 331;//
	scale_x = 1.0; //
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson33title_str>;
}
TEXT lesson34title_txt =
{
	pos_x = 490; //
	pos_y = 350;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson34title_str>;
}
TEXT lesson35title_txt =
{
	pos_x = 490; //
	pos_y = 369;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<lesson35title_str>;
}
TEXT Panel4Prev21to30title_txt =
{
	pos_x = 490; //
	pos_y = 407;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<prev21to30title_str>;
}

TEXT Panel4prev11to20title_txt =
{
	pos_x = 490; //
	pos_y = 426;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<prev11to20title_str>;
}

TEXT Panel4prev1to10title_txt =    //panel 4 button text
{
	pos_x = 490; //
	pos_y = 445;//
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	layer = 12;
	font = titlefont;
	string =<prev1to10title_str>;
}
//allow space for prev 1to20 lessons 

//function eventLevel(percent);

// variable used to indicate that a slot was clicked.
// contains the number of the slot clicked or 0 if waiting
var	saveLoad00_slot_clicked;

PANEL closelessons_pan = //button to close lessons window
 	{
 	pos_x = 1590;
 	pos_y = 240;
	layer = 11;
	flags = overlay;
	bmap = closehelpbutton_bmp; //close window button
	on_click = saveLoad00_closelessonswindow();
	}
PANEL saveLoad00_slot1_pan=
{
// entry: Layer
// id: 22
	
	layer = 11;
	bmap =  "emptygreenslot.bmp"; 				//saveLoad00_empty_bmp;
 	//flags = OVERLAY;
	on_click = saveLoad00_slot1_click();

}
PANEL saveLoad00_slot1_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot2_pan=
{
// entry: Layer
// id: 23
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot2_click;
}
PANEL saveLoad00_slot2_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot3_pan=
{
// entry: Layer
// id: 24
	layer = 11;
	
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot3_click;
}
PANEL saveLoad00_slot3_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot4_pan=
{
// entry: Layer
// id: 25
	layer = 11;
	
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot4_click;
}
PANEL saveLoad00_slot4_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot5_pan=
{
// entry: Layer
// id: 26
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot5_click;
}
PANEL saveLoad00_slot5_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot6_pan=
{
// entry: Layer
// id: 27
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot6_click;
}
PANEL saveLoad00_slot6_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot7_pan=
{
// entry: Layer
// id: 28
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot7_click;
}
PANEL saveLoad00_slot7_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot8_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot8_click;
}
PANEL saveLoad00_slot8_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot9_pan=
{
// entry: Layer
// id: 29
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot9_click;
}
PANEL saveLoad00_slot9_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot10_pan=
{
// entry: Layer
// id: 29
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot10_click;
}
PANEL saveLoad00_slot10_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot11_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot11_click;
}
PANEL saveLoad00_slot11_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
/*PANEL saveLoad00_slot12_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	//pos_x = 640;
 	//pos_y = 650;
	bmap = "clicklesson.bmp"; //click lesson info line
 	flags = overlay,refresh;
	
}*/
////
////Lessons 11-20
////
PANEL saveLoad00_slot13_pan=
{
// entry: Layer
// id: 29
	layer = 11;

	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot13_click;
}
PANEL saveLoad00_slot13_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot14_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot14_click;
}
PANEL saveLoad00_slot14_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot15_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot15_click;
}
PANEL saveLoad00_slot15_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot16_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot16_click;
}
PANEL saveLoad00_slot16_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot17_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot17_click;
}
PANEL saveLoad00_slot17_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot18_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot18_click;
}
PANEL saveLoad00_slot18_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot19_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot19_click;
}
PANEL saveLoad00_slot19_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}

PANEL saveLoad00_slot20_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot20_click;
}
PANEL saveLoad00_slot20_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot21_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot21_click;
}
PANEL saveLoad00_slot21_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot22_pan= //lesson 20
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot22_click;
}
PANEL saveLoad00_slot22_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot23_pan= //NEXT button for Lessons 21-30
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot23_click;
}
PANEL saveLoad00_slot23_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}

PANEL saveLoad00_slot24_pan= //PREV button for 1-10
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot24_click;
}
PANEL saveLoad00_slot24_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
//
//Lessons 21-30
//

PANEL saveLoad00_slot25_pan //Lesson 21
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot25_click;
}
PANEL saveLoad00_slot25_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot26_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot26_click;
}
PANEL saveLoad00_slot26_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot27_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot27_click;
}
PANEL saveLoad00_slot27_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot28_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot28_click;
}
PANEL saveLoad00_slot28_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot29_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot29_click;
}
PANEL saveLoad00_slot29_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot30_pan=
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot30_click;
}
PANEL saveLoad00_slot30_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot31_pan=//
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot31_click;
}
PANEL saveLoad00_slot31_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot32_pan=  //Lesson 30
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot32_click;
}
PANEL saveLoad00_slot32_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot33_pan=  //
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot33_click;
}
PANEL saveLoad00_slot33_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot34_pan=  //lesson 30
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot34_click;
}
PANEL saveLoad00_slot34_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot35_pan=  //PREV Lessons 11-20
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot35_click;
}
PANEL saveLoad00_slot35_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot36_pan=  //Next Scenarios was Prev Lessons 1-10
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot36_click;
}
PANEL saveLoad00_slot36_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
//
//Lesson 31-34
//
PANEL saveLoad00_slot37_pan=  //Lesson 31 Curves and Straights, Night
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay;
	on_click = saveLoad00_slot37_click;
}
PANEL saveLoad00_slot37_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
	//alpha = 0;
}
PANEL saveLoad00_slot38_pan=  //Lesson 32 Night parking
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot38_click;
}
PANEL saveLoad00_slot38_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot39_pan=  //Lesson 33
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot39_click;
}
PANEL saveLoad00_slot39_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot40_pan=  
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot40_click;//Lesson 34
}
PANEL saveLoad00_slot40_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot41_pan=  //Prev 21-30
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot41_click;//L35
}
PANEL saveLoad00_slot41_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot42_pan=  
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	//on_click = saveLoad00_slot42_click;//blank
}
PANEL saveLoad00_slot42_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot43_pan=  //Prev 21-30
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot43_click;
}
PANEL saveLoad00_slot43_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot44_pan=  //Prev 11-20
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot44_click;
}
PANEL saveLoad00_slot44_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot45_pan=  
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
	on_click = saveLoad00_slot45_click;//Prev 1-10
}
PANEL saveLoad00_slot45_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot46_pan=  //Blank
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
//	on_click = saveLoad00_slot42_click;
}
PANEL saveLoad00_slot46_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot47_pan=  //Blank
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
}
PANEL saveLoad00_slot47_sel_pan=
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
PANEL saveLoad00_slot48_pan=  //Blank
{
// entry: Layer
// id: 29
	layer = 11;
	bmap = "emptygreenslot.bmp";
 	flags = overlay,refresh;
}
PANEL saveLoad00_slot48_sel_pan= 
{
// entry: Layer
// id: 22
	
	layer = 13;
	bmap =  "lessonselect.tga"; 				//saveLoad00_empty_bmp;
 	flags = transparent,OVERLAY;
}
//
// Used to tell the calling function when we are finished displaying save/load menus
// 1 - active, 0 - done
var saveLoad00_active = 0;

// array of slot states, 1-slot is used, 0-slot is empty
var	saveLoad00_slot_state[saveLoad00_slot_num]; 

string saveLoad00_tmp_str[256]; // temp value string
string saveLoad00_tmp2_str[256]; // temp value string


// ---------------------------------------------------------------------
// Basic Functions


// Desc: init all values
starter SaveLoad00_Init()
{
	diag("\nWDL-Loaded:saveLoad00.wdl");


	/////////////////////////////
	// Set up keyboard scancodes
	/////////////////////////////
	// use MiscInput01_Key_For_Str() to convert strings into scancodes
	// next item down key
	str_cpy(miscInput01_temp_str,saveLoad00_esc_key_c);
	saveLoad00_esc_scancode = MiscInput01_Key_For_Str();


	if(saveLoad00_savemode == 0)
	{
		saveLoad00_savemode = (SV_ALL-SV_INFO);
	}
}


// Desc: save the current state using the file name given
// Input: name (string) name of the save game (including path)
//			 num (var) number appendend to save game name
//			 mode the save mode (see game_save documentation)
// Return: -1 on error, 1 on success
function saveLoad00_closelessonswindow() //active by close button;hides all slots,
                                         // lesson panel, close button
{
	SaveLoad00_Slot_ShowHide_All();
	SaveLoad00_Slot_ShowHide_All2();
	SaveLoad00_Slot_ShowHide_All3();
	SaveLoad00_Slot_ShowHide_All4();
	saveLoad00_load_pan.VISIBLE =OFF;
	menu01_show_main();
	menu01_highlight(1);
	
	

	mouse_mode = 0; //no engine mouse pointer
	mouse_pointer = 0;//no windows pointer
	menu01_active_b = 1; //return to main menu
}
function SaveLoad00_SaveState(name, num, mode)
{
	if(game_save(name,num,mode) <= 0) { return(-1); }       // error occured durring save
	else { return(1); }							// state save successful
}


// Desc: Load a game state from a file name given.
// Input: name (string)
// Return: -1 on error
function SaveLoad00_LoadState(name, num)
{
	if(game_load(name,num) <= 0) {  return(-1); }       // error occured durring load
	// success
}

// Desc: Set the save game directory
//+++


// ---------------------------------------------------------------------
// "Slot" functions

// Desc: functions called when the player clicks on slots
 //on_level = eventLevel
 function saveLoad00_moveselection()  //var saveLoad00_movesel is 0 at startup
 													//var set to 1 when lesson page opens and  0 closed
 {
 	//while(1)
 	//{

 		//if ((joy_buttons && 32) && (nextlessonstitle_txt.VISIBLE == ON)&&(saveLoad00_movesel )) //up button on gear shift
 		 //	{
			//saveLoad00_movesel -=1; //subtract 1 from movesel var
			//}
		if ((joy_buttons && 128) && (nextlessonstitle_txt.VISIBLE == ON) && (saveLoad00_movesel < 12))
			
			{
			saveLoad00_movesel +=1; //add 1 to movelsel var to move down first lessons page
			}
		/*if ((joy_buttons && 128) && (nextlessons21to30title_txt.VISIBLE == ON)&& (saveLoad00_movesel < 13))  //down button
			{
			saveLoad00_movesel +=1; //add 1 to movelsel var to move down 2nd page
			}
		if((joy_buttons && 128) && (prev11to20title_txt.VISIBLE == ON) && (saveLoad00_movesel < 13))//3rd lessons
			{
			saveLoad00_movesel +=1; //add 1 to movelsel var to move down 3rd page
			}*/
			//
			//make selection icon visible next to lesson title
			//
		if (nextlessonstitle_txt.VISIBLE == ON)// && (joy_buttons && 128)) //down button
		{
			if(saveLoad00_movesel == 0){saveLoad00_slot1_sel_pan.VISIBLE = ON;}
			//if(saveLoad00_movesel == 1){saveLoad00_slot1_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 2){saveLoad00_slot1_sel_pan.VISIBLE = OFF;saveLoad00_slot2_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 3){saveLoad00_slot2_sel_pan.VISIBLE = OFF;saveLoad00_slot3_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 4){saveLoad00_slot3_sel_pan.VISIBLE = OFF;saveLoad00_slot4_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 5){saveLoad00_slot4_sel_pan.VISIBLE = OFF;saveLoad00_slot5_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 6){saveLoad00_slot5_sel_pan.VISIBLE = OFF;saveLoad00_slot6_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 7){saveLoad00_slot6_sel_pan.VISIBLE = OFF;saveLoad00_slot7_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 8){saveLoad00_slot7_sel_pan.VISIBLE = OFF;saveLoad00_slot8_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 9){saveLoad00_slot8_sel_pan.VISIBLE = OFF;saveLoad00_slot9_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 10){saveLoad00_slot9_sel_pan.VISIBLE = OFF;saveLoad00_slot10_sel_pan.VISIBLE = ON;}	
			if(saveLoad00_movesel == 11){saveLoad00_slot10_sel_pan.VISIBLE = OFF;saveLoad00_slot11_sel_pan.VISIBLE = ON;}	
		}
		/*if ((nextlessonstitle_txt.VISIBLE == ON) && (joy_buttons && 32))//up
		{
			if(saveLoad00_movesel == 1){saveLoad00_slot1_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 2){saveLoad00_slot1_sel_pan.VISIBLE = ON;saveLoad00_slot2_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 3){saveLoad00_slot2_sel_pan.VISIBLE = ON;saveLoad00_slot3_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 4){saveLoad00_slot3_sel_pan.VISIBLE = ON;saveLoad00_slot4_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 5){saveLoad00_slot4_sel_pan.VISIBLE = ON;saveLoad00_slot5_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 6){saveLoad00_slot5_sel_pan.VISIBLE = ON;saveLoad00_slot6_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 7){saveLoad00_slot6_sel_pan.VISIBLE = ON;saveLoad00_slot7_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 8){saveLoad00_slot7_sel_pan.VISIBLE = ON;saveLoad00_slot8_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 9){saveLoad00_slot8_sel_pan.VISIBLE = ON;saveLoad00_slot9_sel_pan.VISIBLE = OFF;}
			if(saveLoad00_movesel == 10){saveLoad00_slot9_sel_pan.VISIBLE = ON;saveLoad00_slot10_sel_pan.VISIBLE = OFF;}	
			if(saveLoad00_movesel == 11){saveLoad00_slot10_sel_pan.VISIBLE = ON;saveLoad00_slot11_sel_pan.VISIBLE = OFF;}
		}
		//end of first lesson page
		//
		if (nextlessons21to30title_txt.VISIBLE == ON)
		{
			
			if(saveLoad00_movesel == 0){saveLoad00_slot13_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 1){saveLoad00_slot14_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 2){saveLoad00_slot15_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 3){saveLoad00_slot16_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 4){saveLoad00_slot17_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 5){saveLoad00_slot18_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 6){saveLoad00_slot19_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 7){saveLoad00_slot20_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 8){saveLoad00_slot21_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 9){saveLoad00_slot22_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 10){saveLoad00_slot23_sel_pan.VISIBLE = ON;}//NEXT11to20
			if(saveLoad00_movesel == 11){saveLoad00_slot24_sel_pan.VISIBLE = ON;}//PREV1to10
		}
		if (nextlessons21to30title_txt.VISIBLE == ON) //page 3 lesson load
		{
		
			if(saveLoad00_movesel == 0){saveLoad00_slot25_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 1){saveLoad00_slot26_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 2){saveLoad00_slot27_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 3){saveLoad00_slot28_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 4){saveLoad00_slot29_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 5){saveLoad00_slot30_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 6){saveLoad00_slot31_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 7){saveLoad00_slot32_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 8){saveLoad00_slot33_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 9){saveLoad00_slot34_sel_pan.VISIBLE = ON;}
			if(saveLoad00_movesel == 10){saveLoad00_slot35_sel_pan.VISIBLE = ON;}//PREV11to20
			if(saveLoad00_movesel == 11){saveLoad00_slot36_sel_pan.VISIBLE = ON;}//PREV1to10
		}*/
		//wait(-.125);
	//}
}
 function saveLoad00_slot1_click() // L1 Getting Started
	{
	SaveLoad00_Slot_ShowHide_All(); 
	saveLoad00_load_pan.visible = off;
	mouse_mode = 0;
	menu01_hide_main();//hide main menu and unfreeze
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("getstarted.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
 


function saveLoad00_slot2_click() //L2 Following Traffic, no opposing
	{
	SaveLoad00_Slot_ShowHide_All(); 
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("following.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
function saveLoad00_slot3_click() //L3 Pass NO Opposing Traffic Rural
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	mouse_mode = 0;
	menu01_hide_main();//hide main menu and unfreeze
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("passnoopposing.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot4_click()  //L4 Pass Opposing Traffic Rural
   {
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("passopposing40.wmb"); //was passopposing.wmb
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot5_click()   //L5 Passing Large Trucks
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("passopposingtruck40.wmb");
	wait(3);
	fog_color = 0;
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot6_click() //L6 Left Turn Light Rural
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("leftturnlight.wmb"); //load lesson 6
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot7_click() //L7 Left Turn Heavy Rural
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("leftturnheavy.wmb"); //load lesson 7
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot8_click() //L8 Diagonal Parking
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("parkdiagonal.wmb"); //load lesson 8
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot9_click() //L9 Parallel Parking
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("parkparallel.wmb");//
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot10_click() //L10 Construction Hazard Urban
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();  //hide main and unfreeze to allow clear and load
	mouse_mode = 0;
	
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("constrhazard26.wmb");//was	constrhazard24test.wmb
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot11_click() //click slot NEXT  to show lessons 11-20
	{
	SaveLoad00_Slot_ShowHide_All(); //hide all panel slots
	SaveLoad00_Slot_ShowHide_All2(1); //show lessons 11-20
	}
	//
	// slot 12 is for click info line bitmap so there is no function for 12
	//
function saveLoad00_slot13_click() //L11 - Stalled Traffic Urban
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("stalledtraffic.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot14_click() //L12 Road Hazard Urban
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
		mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("roadhazard.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot15_click() //L13 LEFT MIDBLOCK TURN
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	mouse_mode = 0;
	menu01_hide_main();//hide main menu and unfreeze
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("leftmidblock3.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot16_click() //L14	Left Turn at Intersection
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	mouse_mode = 0;
	menu01_hide_main();//hide main menu and unfreeze
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("leftturnintersect2.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot17_click() //L15 Traffic Jam Intersection
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	mouse_mode = 0;
	menu01_hide_main();//hide main menu and unfreeze
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("trafficjam5.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot18_click() //L16 Curves Fog
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("curvesfogtest.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot19_click() //L17 quick parking URBAN
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("quickparkingurban2.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot20_click() //L18 Parallel Park URBAN
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("parallelparkingurbanold.wmb");	
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot21_click() //L19 Left Turn Fog (L7 with fog)
	{
	SaveLoad00_Slot_ShowHide_All2(); 
	saveLoad00_load_pan.visible = off;
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("leftturnfog.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot22_click() //L20 Pass Oncoming Fog (L4 with Fog)
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("passopposingfog.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot23_click() //NEXT Lessons 21-30
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel slots Lessons 11-20
	SaveLoad00_Slot_ShowHide_All3(1); //show Lessons 21-30
	}
	
	function saveLoad00_slot24_click() //PREV Lessons 1-10
	{
	SaveLoad00_Slot_ShowHide_All2(); //hide all panel Lessons 21-30 slots
	SaveLoad00_Slot_ShowHide_All(1);// show lessons 1-10
	}
	
	function saveLoad00_slot25_click() //L21 freeway entry
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	level_load("fwyentry.wmb"); 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot26_click() //L22 freeway entry heavy traffic
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("fwyentryhvy.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	function saveLoad00_slot27_click() //L23 Night Rural
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("nightrural.wmb");//was fwyexitright.wmb
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot28_click() //L24 freeway exit from left lane
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("fwyexitleft.wmb");//was 
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
	function saveLoad00_slot29_click() //L25 Test rural v.3
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("drivetestruralv3.wmb");//
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	
	}
	
	function saveLoad00_slot30_click() //L26 Test Urban v.3
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("testurbanv3.wmb");//
	wait(3);
	lessonloading_txt.VISIBLE = OFF; 
	}
	
	function saveLoad00_slot31_click() //
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("drivetestruralv2.wmb");
	wait(3); 
	fog_color = 0;
	lessonloading_txt.VISIBLE = OFF; 
	}
	
	function saveLoad00_slot32_click() //
	{	
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("testurbanv2.wmb");//was iceandsnow.wmb
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
function saveLoad00_slot33_click() //
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText(); 
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("drivetestrural.wmb");
	wait(3);
	lessonloading_txt.VISIBLE = OFF;
	}
	
function saveLoad00_slot34_click() //L30 Driving Test v.1 - Urban
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	terrain_lod = 4;
	terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("testurbannew.wmb"); //was drivetesturban
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}

	
function saveLoad00_slot35_click() //PREV Lessons 11-20 button
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all panel slots
	SaveLoad00_Slot_ShowHide_All2(1); //show Lessons 11-20
	}
function saveLoad00_slot36_click() //Next Scenarios, was PREV Lessons 1-10 button
	{
	SaveLoad00_Slot_ShowHide_All3(); //hide all Lessons 21-30 panel slots
	SaveLoad00_Slot_ShowHide_All4(1); //Show Lessons 31-40
	}
//
//
//Lessons 31-40 PANEL 4
//
//
function saveLoad00_slot37_click() //Lesson 31
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	//terrain_lod = 4;
	//terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("curvesnighttest.wmb"); // curvesnight.wmb
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot38_click() //Lesson 32//parking urban night
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	terrain_lod = 4;
	terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("parkingurbannight.wmb"); //parking urban night
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot39_click() //Lesson 33 Left Turn, NIGHT
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
	terrain_lod = 4;
	terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("leftturnheavynight.wmb"); //
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot40_click() //Lesson 34 Night Urban Hazards
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel slots
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
//	terrain_lod = 4;
//	terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("nighturbanhazards6.wmb"); //was drivetesturban
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}
function saveLoad00_slot41_click() //Lesson 35 Pass Opposing Night
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel 4 slots	
	saveLoad00_load_pan.visible = off; //hide Load panel
	menu01_hide_main();
	mouse_mode = 0;
	clearInstructText();
//	terrain_lod = 4;
//	terrain_chunk = 32; //chunck terrain
	lessonloading_txt.VISIBLE = ON;
	preload_mode = 2;
	level_load("passopposingnight.wmb"); //
	starthour = sys_hours;
	startmin = sys_minutes;
	wait(-3);
	lessonloading_txt.VISIBLE = OFF;
	}
	//slot 42 blank
	
function saveLoad00_slot43_click() //PREV Lessons 21-30 button
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel 4 slots
	SaveLoad00_Slot_ShowHide_All3(1); //show Lessons 21-30
	}
function saveLoad00_slot44_click() //PREV Lessons 11-20 button
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel 4 slots
	SaveLoad00_Slot_ShowHide_All2(1); //Show Lessons 11-20
	}
function saveLoad00_slot45_click() //PREV Lessons 1-10 button
	{
	SaveLoad00_Slot_ShowHide_All4(); //hide all panel 4 slots
	SaveLoad00_Slot_ShowHide_All(1); //Show Lessons 1-10
	}

	//////
///////Use Joy 4 button to execute lesson selection
//////
function saveLoad00_selectlesson()= //execute button selection called by menu01_select_load()
  												//function 
{
	//while(1)
		//{
			if((joy_buttons && 256) && (nextlessonstitle_txt.VISIBLE == ON))
				{
					//if (saveLoad00_movesel == 0) //first slot
				 		//{
						//saveLoad00_slot1_click(); 
						//SaveLoad00_Slot_ShowHide_All(0);
						//}
					if (saveLoad00_movesel == 1) ///
				 		{
						saveLoad00_slot1_click(); ///select lesson 1
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 2) //
				 		{
						saveLoad00_slot2_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 3) //
				 		{
						saveLoad00_slot3_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 4) //
				 		{
						saveLoad00_slot4_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 5) //
				 		{
						saveLoad00_slot5_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 6) //
				 		{
						saveLoad00_slot6_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 7) //
				 		{
						saveLoad00_slot7_click(); //
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 8) //
				 		{
						saveLoad00_slot8_click(); //select lesson 8
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 9) //
				 		{
						saveLoad00_slot9_click(); //select lesson 9
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 10) //
				 		{
						saveLoad00_slot10_click(); //select 10
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 11) //
				 		{
						saveLoad00_slot11_click(); //select NEXT 11to20 lessons
						SaveLoad00_Slot_ShowHide_All(0);
						SaveLoad00_Slot_ShowHide_All2(1);//show page 2
						}
				}
			if((joy_buttons && 256) && (nextlessons21to30title_txt.VISIBLE == ON))		
				{
					if (saveLoad00_movesel == 1) //first slot
				 		{
						saveLoad00_slot13_click(); //select lesson 11
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 2) //first slot
				 		{
						saveLoad00_slot14_click(); //select lesson 12
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 3) //first slot
				 		{
						saveLoad00_slot15_click(); //select lesson 13
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 4) //first slot
				 		{
						saveLoad00_slot16_click(); //select lesson 14
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 5) //first slot
				 		{
						saveLoad00_slot17_click(); //select lesson 15
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 6) //first slot
				 		{
						saveLoad00_slot18_click(); //select lesson 16
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 7) //first slot
				 		{
						saveLoad00_slot19_click(); //select lesson 17
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 8) //first slot
				 		{
						saveLoad00_slot20_click(); //select lesson 18
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 9) //first slot
				 		{
						saveLoad00_slot21_click(); //select lesson 19
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 10) //first slot
				 		{
						saveLoad00_slot22_click(); //select lesson 20
						SaveLoad00_Slot_ShowHide_All(0);
						}
					if (saveLoad00_movesel == 11) //Next
				 		{
						saveLoad00_slot23_click(); //select NEXT 21to30 lessons
						SaveLoad00_Slot_ShowHide_All(0);
						}
					
					if (saveLoad00_movesel == 12) //Prev 1to11
				 		{
						saveLoad00_slot24_click(); //select Prev
						SaveLoad00_Slot_ShowHide_All(0);
						}			
				}
			if((joy_buttons && 256) && (prev11to20title_txt.VISIBLE == ON))	
				{
						if (saveLoad00_movesel == 0) //first slot
				 		{
						saveLoad00_slot25_click(); //select lesson 21
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 1) //first slot
				 		{
						saveLoad00_slot26_click(); //select lesson 22
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 2) //first slot
				 		{
						saveLoad00_slot27_click(); //select lesson 23
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 3) //first slot
				 		{
						saveLoad00_slot28_click(); //select lesson 24
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 4) //first slot
				 		{
						saveLoad00_slot29_click(); //select lesson 25
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 5) //first slot
				 		{
						saveLoad00_slot30_click(); //select lesson 26
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 6) //first slot
				 		{
						saveLoad00_slot31_click(); //select lesson 27
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 7) //first slot
				 		{
						saveLoad00_slot32_click(); //select lesson 28
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 8) //first slot
				 		{
						saveLoad00_slot33_click(); //select lesson 29
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 9) //first slot
				 		{
						saveLoad00_slot34_click(); //select lesson 30
						SaveLoad00_Slot_ShowHide_All(0);
						}
						if (saveLoad00_movesel == 10) //Next
				 		{
						saveLoad00_slot35_click(); //select Prev11to20 lessons
						SaveLoad00_Slot_ShowHide_All(0);
						}
					
						if (saveLoad00_movesel == 11) //Prev
				 		{
						saveLoad00_slot36_click(); //select Prev1to10
						SaveLoad00_Slot_ShowHide_All(0);
						}	
				}	
						
						
				//saveLoad00_slot1_sel_pan.VISIBLE = OFF;
				//SaveLoad00_Slot_ShowHide_All(0);
				//closelessons_pan.VISIBLE = OFF;
				//wait(-.125);
		 //if(saveLoad00_load_pan.visible == OFF){break;}
			//
	//	wait(-.125);
		//}//end of loop
	
}//end of function



// Desc: set all 11 of the slot bitmaps to the correct type (empty or full)
//  based on the information stored in saveLoad00_slot_state.
//			Also set the position relative to the values passed in
function	SaveLoad00_Slot_Set_All(base_x, base_y)
{
	saveLoad00_slot_state[0] == 1;  //if(saveLoad00_slot_state[0] == 1)
	
	saveLoad00_slot1_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot1_pan.pos_y = base_y + saveLoad00_slot_pos_y;
	saveLoad00_slot1_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+50;
	saveLoad00_slot1_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+10;
//--
	saveLoad00_slot_state[1] == 1;
	
	saveLoad00_slot2_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot2_pan.pos_y = base_y + saveLoad00_slot_pos_y + bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot2_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+50;
	saveLoad00_slot2_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + bmap_height(saveLoad00_empty_bmp);

//--
	saveLoad00_slot_state[2] == 1;

	saveLoad00_slot3_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot3_pan.pos_y = base_y + saveLoad00_slot_pos_y + 2*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot3_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot3_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 2*bmap_height(saveLoad00_empty_bmp);
//--
	saveLoad00_slot_state[3] == 1;

	saveLoad00_slot4_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot4_pan.pos_y = base_y + saveLoad00_slot_pos_y + 3*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot4_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot4_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 3*bmap_height(saveLoad00_empty_bmp);
//--
	saveLoad00_slot_state[4] == 1;

	saveLoad00_slot5_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot5_pan.pos_y = base_y + saveLoad00_slot_pos_y + 4*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot5_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x + 30;
	saveLoad00_slot5_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 4*bmap_height(saveLoad00_empty_bmp);
//--
	saveLoad00_slot_state[5] == 1;
	
	saveLoad00_slot6_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot6_pan.pos_y = base_y + saveLoad00_slot_pos_y + 5*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot6_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot6_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 5*bmap_height(saveLoad00_empty_bmp);
//--
	saveLoad00_slot_state[6] == 1;

	saveLoad00_slot7_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot7_pan.pos_y = base_y + saveLoad00_slot_pos_y + 6*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot7_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot7_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 6*bmap_height(saveLoad00_empty_bmp);
//--
	saveLoad00_slot_state[7] == 1;
	
	saveLoad00_slot8_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot8_pan.pos_y = base_y + saveLoad00_slot_pos_y + 7*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot8_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot8_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 7*bmap_height(saveLoad00_empty_bmp);
//---
//-
	saveLoad00_slot_state[8] == 1;
	
	saveLoad00_slot9_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot9_pan.pos_y = base_y + saveLoad00_slot_pos_y + 8*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot9_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x +30;
	saveLoad00_slot9_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 8*bmap_height(saveLoad00_empty_bmp);
	//---
	saveLoad00_slot_state[9] == 1;
	
	saveLoad00_slot10_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot10_pan.pos_y = base_y + saveLoad00_slot_pos_y + 9*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot10_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x + 30;
	saveLoad00_slot10_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 9*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[10] == 1;
	//
	//For NEXT button lessons 11-20
	//
	
	saveLoad00_slot11_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot11_pan.pos_y = base_y + saveLoad00_slot_pos_y + 10*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot11_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x + 50;
	saveLoad00_slot11_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 10*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[11] == 1;
	//
	//For Click info text line
	//saveLoad00_slot12_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	
	//saveLoad00_slot12_pan.pos_y = base_y + saveLoad00_slot_pos_y + 11*bmap_height(saveLoad00_empty_bmp);
	//saveLoad00_slot_state[12] == 1;
	//
	//For Lesson 11 Urban Traffic 1
	saveLoad00_slot13_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot13_pan.pos_y = base_y + saveLoad00_slot_pos_y;
	saveLoad00_slot_state[13] == 1;
	//Lesson 12
	saveLoad00_slot14_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot14_pan.pos_y = base_y + saveLoad00_slot_pos_y + bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[14] == 1;
	//Lesson 13
	saveLoad00_slot15_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot15_pan.pos_y = base_y + saveLoad00_slot_pos_y + 2*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[15] == 1;
	//Lesson 14
	saveLoad00_slot16_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot16_pan.pos_y = base_y + saveLoad00_slot_pos_y + 3*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[16] == 1;
	//Lesson 15
	saveLoad00_slot17_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot17_pan.pos_y = base_y + saveLoad00_slot_pos_y + 4*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[17] == 1;
	//Lesson 16
	saveLoad00_slot18_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot18_pan.pos_y = base_y + saveLoad00_slot_pos_y + 5*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[18] == 1;
	//Lesson 17
	saveLoad00_slot19_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot19_pan.pos_y = base_y + saveLoad00_slot_pos_y + 6*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[19] == 1;
	//Lesson 18
	saveLoad00_slot20_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot20_pan.pos_y = base_y + saveLoad00_slot_pos_y + 7*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[20] == 1;
	//Lesson 19
	saveLoad00_slot21_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot21_pan.pos_y = base_y + saveLoad00_slot_pos_y + 8*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[21] == 1;
	//Lesson 20
	saveLoad00_slot22_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot22_pan.pos_y = base_y + saveLoad00_slot_pos_y + 9*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[22] == 1;
	//Next Lessons 21-30 button
	saveLoad00_slot23_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot23_pan.pos_y = base_y + saveLoad00_slot_pos_y + 10*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[23] == 1;
	//Prev Lessons 1-10 button
	saveLoad00_slot24_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot24_pan.pos_y = base_y + saveLoad00_slot_pos_y + 11*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[24] == 1;
	//
	//Lesson 21
	//
	saveLoad00_slot25_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot25_pan.pos_y = base_y + saveLoad00_slot_pos_y;
	saveLoad00_slot_state[25] == 1;
	//Lesson 22
	saveLoad00_slot26_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot26_pan.pos_y = base_y + saveLoad00_slot_pos_y + bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[26] == 1;
	//Lesson 23
	saveLoad00_slot27_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot27_pan.pos_y = base_y + saveLoad00_slot_pos_y + 2*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[27] == 1;
	//Lesson 24
	saveLoad00_slot28_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot28_pan.pos_y = base_y + saveLoad00_slot_pos_y + 3*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[28] == 1;
	//Lesson 25
	saveLoad00_slot29_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot29_pan.pos_y = base_y + saveLoad00_slot_pos_y + 4*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[29] == 1;
	//Lesson 26
	saveLoad00_slot30_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot30_pan.pos_y = base_y + saveLoad00_slot_pos_y + 5*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[30] == 1;
	//Lesson 27
	saveLoad00_slot31_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot31_pan.pos_y = base_y + saveLoad00_slot_pos_y + 6*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[31] == 1;
	//Lesson 28
	saveLoad00_slot32_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot32_pan.pos_y = base_y + saveLoad00_slot_pos_y + 7*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[32] == 1;
	//Lesson 29
	saveLoad00_slot33_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot33_pan.pos_y = base_y + saveLoad00_slot_pos_y + 8*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[33] == 1;
	//Lesson 30
	saveLoad00_slot34_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot34_pan.pos_y = base_y + saveLoad00_slot_pos_y + 9*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[34] == 1;
	//Prev 11-20 button
	saveLoad00_slot35_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot35_pan.pos_y = base_y + saveLoad00_slot_pos_y + 10*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot_state[35] == 1;
	//Next Scenarios button
	saveLoad00_slot36_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot36_pan.pos_y = base_y + saveLoad00_slot_pos_y + 11*bmap_height(saveLoad00_empty_bmp);
	
//	saveLoad00_slot_state[36] == 1;	//caused crash?
	//
	//Lesson 31
	//
	saveLoad00_slot37_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot37_pan.pos_y = base_y + saveLoad00_slot_pos_y;
	saveLoad00_slot37_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+50;
	saveLoad00_slot37_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+10;
//	saveLoad00_slot_state[37] == 1;
	//Lesson 32
	saveLoad00_slot38_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot38_pan.pos_y = base_y + saveLoad00_slot_pos_y + bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot38_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+50;
	saveLoad00_slot38_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + bmap_height(saveLoad00_empty_bmp);
//	saveLoad00_slot_state[38] == 1;
	//Lesson 33
	saveLoad00_slot39_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot39_pan.pos_y = base_y + saveLoad00_slot_pos_y + 2*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot39_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot39_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 2*bmap_height(saveLoad00_empty_bmp);
	//Lesson 34
	saveLoad00_slot40_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot40_pan.pos_y = base_y + saveLoad00_slot_pos_y + 3*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot40_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot40_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 3*bmap_height(saveLoad00_empty_bmp);
	//Lesson 35 
	saveLoad00_slot41_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot41_pan.pos_y = base_y + saveLoad00_slot_pos_y + 4*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot41_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x + 30;
	saveLoad00_slot41_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 4*bmap_height(saveLoad00_empty_bmp);
	//Blank 
	saveLoad00_slot42_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot42_pan.pos_y = base_y + saveLoad00_slot_pos_y + 5*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot42_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot42_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 5*bmap_height(saveLoad00_empty_bmp);
	//Prev Lessons 21-30
	saveLoad00_slot43_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot43_pan.pos_y = base_y + saveLoad00_slot_pos_y + 6*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot43_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot43_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 6*bmap_height(saveLoad00_empty_bmp);
	
	//Prev Lessons 11-20
	saveLoad00_slot44_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot44_pan.pos_y = base_y + saveLoad00_slot_pos_y + 7*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot44_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot44_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 7*bmap_height(saveLoad00_empty_bmp);
	//Prev Lesons 1-10
	saveLoad00_slot45_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot45_pan.pos_y = base_y + saveLoad00_slot_pos_y + 8*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot45_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot45_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 8*bmap_height(saveLoad00_empty_bmp);
	//blank
	saveLoad00_slot46_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot46_pan.pos_y = base_y + saveLoad00_slot_pos_y + 9*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot46_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot46_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 9*bmap_height(saveLoad00_empty_bmp);
	//blank
	saveLoad00_slot47_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot47_pan.pos_y = base_y + saveLoad00_slot_pos_y + 10*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot47_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot47_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 10*bmap_height(saveLoad00_empty_bmp);
	//blank
	saveLoad00_slot48_pan.pos_x = base_x + saveLoad00_slot_pos_x;
	saveLoad00_slot48_pan.pos_y = base_y + saveLoad00_slot_pos_y + 11*bmap_height(saveLoad00_empty_bmp);
	saveLoad00_slot48_sel_pan.pos_x = base_x + saveLoad00_slot_pos_x+30;
	saveLoad00_slot48_sel_pan.pos_y = base_y + saveLoad00_slot_pos_y+30 + 11*bmap_height(saveLoad00_empty_bmp);
}


// Desc: Show (1) or Hide (0) all slot panels
function	SaveLoad00_Slot_ShowHide_All(showhide)  //page one of lessons
{
	if(showhide == 1)
	{
		
		closelessons_pan.VISIBLE = ON; //show close window button
		//
		// show all slots
		//
		saveLoad00_slot1_pan.visible = on;
			getstartedtitle_txt.VISIBLE = ON;
		saveLoad00_slot2_pan.visible = on;
			lesson2title_txt.VISIBLE = ON;
		saveLoad00_slot3_pan.visible = on;
			lesson3title_txt.VISIBLE = ON;
		saveLoad00_slot4_pan.visible = on;
			lesson4title_txt.VISIBLE = ON;
		saveLoad00_slot5_pan.visible = on;
			lesson5title_txt.VISIBLE = ON;
		saveLoad00_slot6_pan.visible = on;
			lesson6title_txt.VISIBLE = ON;
		saveLoad00_slot7_pan.visible = on;
			lesson7title_txt.VISIBLE = ON;
		saveLoad00_slot8_pan.visible = on;
			lesson8title_txt.VISIBLE = ON;
		saveLoad00_slot9_pan.visible = on;
			lesson9title_txt.VISIBLE = ON;
		saveLoad00_slot10_pan.visible = on;
			lesson10title_txt.VISIBLE = ON;
		saveLoad00_slot11_pan.visible = on; //slot is for next button
			nextlessonstitle_txt.VISIBLE = ON;
		//saveLoad00_slot12_pan.visible = on; //slot is for "click to load" info
	}
	else
	{
		closelessons_pan.VISIBLE = OFF; //hide close window button
		// hide all slots
		saveLoad00_slot1_pan.visible = off;
			getstartedtitle_txt.VISIBLE = OFF;
		saveLoad00_slot2_pan.visible = off;
			lesson2title_txt.VISIBLE = OFF;
		saveLoad00_slot3_pan.visible = off;
			lesson3title_txt.VISIBLE = OFF;
		saveLoad00_slot4_pan.visible = off;
			lesson4title_txt.VISIBLE = OFF;
		saveLoad00_slot5_pan.visible = off;
			lesson5title_txt.VISIBLE = OFF;
		saveLoad00_slot6_pan.visible = off;
			lesson6title_txt.VISIBLE = OFF;
		saveLoad00_slot7_pan.visible = off;
			lesson7title_txt.VISIBLE = OFF;
		saveLoad00_slot8_pan.visible = off;
			lesson8title_txt.VISIBLE = OFF;
		saveLoad00_slot9_pan.visible = off;
			lesson9title_txt.VISIBLE = OFF;
		saveLoad00_slot10_pan.visible = off;
			lesson10title_txt.VISIBLE = OFF;
		saveLoad00_slot11_pan.visible = off; //slot is for next button
			nextlessonstitle_txt.VISIBLE = OFF;
		//saveLoad00_slot12_pan.visible = off; //slot is for "click to load" info
 		saveLoad00_slot1_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot2_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot3_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot4_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot5_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot6_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot7_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot8_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot9_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot10_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot11_sel_pan.VISIBLE = OFF;
 	}
 }
// Desc: Show (1) or Hide (0) all slot panels on Load Lesson panel #2
function	SaveLoad00_Slot_ShowHide_All2(showhide)
{
	if(showhide == 1)
	{
		closelessons_pan.VISIBLE = ON; //show close window button
		//
		// show all slots
		//
		saveLoad00_slot13_pan.visible = on; //Lesson 11 panel on
			lesson11title_txt.VISIBLE = ON;
		saveLoad00_slot14_pan.visible = on;
			lesson12title_txt.VISIBLE = ON;
		saveLoad00_slot15_pan.visible = on;
			lesson13title_txt.VISIBLE = ON;
		saveLoad00_slot16_pan.visible = on;
			lesson14title_txt.VISIBLE = ON;
		saveLoad00_slot17_pan.visible = on;//Lesson 15 panel on
			lesson15title_txt.VISIBLE = ON;
		saveLoad00_slot18_pan.visible = on;
			lesson16title_txt.VISIBLE = ON;
		saveLoad00_slot19_pan.visible = on;
			lesson17title_txt.VISIBLE = ON;
		saveLoad00_slot20_pan.visible = on;
			lesson18title_txt.VISIBLE = ON;
		saveLoad00_slot21_pan.visible = on;
			lesson19title_txt.VISIBLE = ON;
		saveLoad00_slot22_pan.visible = on;//Lesson 20 panel on
			lesson20title_txt.VISIBLE = ON;
		saveLoad00_slot23_pan.visible = on;//slot Next button
			nextlessons21to30title_txt.VISIBLE = ON; //next button for lessons 21-30
		saveLoad00_slot24_pan.visible = on;//slot is for Prev button
			prev1to10title_txt.VISIBLE = ON;
	}
	else
	{
		
		closelessons_pan.VISIBLE = OFF; //hide close window button
		//
		// hide all slots
		saveLoad00_slot13_pan.visible = off;
			lesson11title_txt.VISIBLE = OFF;
		saveLoad00_slot14_pan.visible = off;
			lesson12title_txt.VISIBLE = OFF;
		saveLoad00_slot15_pan.visible = off;
			lesson13title_txt.VISIBLE = OFF;
		saveLoad00_slot16_pan.visible = off;
			lesson14title_txt.VISIBLE = OFF;
		saveLoad00_slot17_pan.visible = off;
			lesson15title_txt.VISIBLE = OFF;
		saveLoad00_slot18_pan.visible = off;
			lesson16title_txt.VISIBLE = OFF;
		saveLoad00_slot19_pan.visible = off;
			lesson17title_txt.VISIBLE = OFF;
		saveLoad00_slot20_pan.visible = off;
			lesson18title_txt.VISIBLE = OFF;
		saveLoad00_slot21_pan.visible = off;
			lesson19title_txt.VISIBLE = OFF;
		saveLoad00_slot22_pan.visible = off;//Lesson 20 panel off
			lesson20title_txt.VISIBLE = OFF;
		saveLoad00_slot23_pan.visible = off; //slot is for Prev button
			nextlessons21to30title_txt.VISIBLE = OFF;
		saveLoad00_slot24_pan.visible = off;//slot is for Prev button
			prev1to10title_txt.VISIBLE = OFF;
				//saveLoad00_slot1_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot13_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot14_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot15_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot16_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot17_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot18_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot19_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot20_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot21_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot22_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot23_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot24_sel_pan.VISIBLE = OFF;
 	}
 }

// Desc: Show (1) or Hide (0) all slot panels on Load Lesson panel #3
function	SaveLoad00_Slot_ShowHide_All3(showhide)
{
	if(showhide == 1)
	{
	
		closelessons_pan.VISIBLE = ON; //show close window button
		//
		// show all slots
		//
		saveLoad00_slot25_pan.visible = on;//show lesson 21
			lesson21title_txt.VISIBLE = ON;
		saveLoad00_slot26_pan.visible = on;
			lesson22title_txt.VISIBLE = ON;
		saveLoad00_slot27_pan.visible = on;
			lesson23title_txt.VISIBLE = ON;
		saveLoad00_slot28_pan.visible = on;
			lesson24title_txt.VISIBLE = ON;
		saveLoad00_slot29_pan.visible = on;
			lesson25title_txt.VISIBLE = ON;
		saveLoad00_slot30_pan.visible = on;
			lesson26title_txt.VISIBLE = ON;
		saveLoad00_slot31_pan.visible = on;
			lesson27title_txt.VISIBLE = ON;
		saveLoad00_slot32_pan.visible = on;
			lesson28title_txt.VISIBLE = ON;
		saveLoad00_slot33_pan.visible = on;
			lesson29title_txt.VISIBLE = ON;
		saveLoad00_slot34_pan.visible = on;
			lesson30title_txt.VISIBLE = ON;
		saveLoad00_slot35_pan.visible = on; //prev 11 to 20
			prev11to20title_txt.VISIBLE = ON;
		saveLoad00_slot36_pan.visible = on; // Next 31-40 was prev 1 to 10
			nextlessons31to40title_txt.VISIBLE = ON;
	}
	else
	{
		closelessons_pan.VISIBLE = OFF; //hide close window button
		//
		// hide all slots
		//
		saveLoad00_slot25_pan.visible = off;//hide lesson 21 panel
			lesson21title_txt.VISIBLE = OFF;
		saveLoad00_slot26_pan.visible = off;
			lesson22title_txt.VISIBLE = OFF;
		saveLoad00_slot27_pan.visible = off;
			lesson23title_txt.VISIBLE = OFF;
		saveLoad00_slot28_pan.visible = off;
			lesson24title_txt.VISIBLE = OFF;
		saveLoad00_slot29_pan.visible = off;
			lesson25title_txt.VISIBLE = OFF;
		saveLoad00_slot30_pan.visible = off;
			lesson26title_txt.VISIBLE = OFF;
		saveLoad00_slot31_pan.visible = off;
			lesson27title_txt.VISIBLE = OFF;
		saveLoad00_slot32_pan.visible = off;
			lesson28title_txt.VISIBLE = OFF;
		saveLoad00_slot33_pan.visible = off;
			lesson29title_txt.VISIBLE = OFF;
		saveLoad00_slot34_pan.visible = off;
			lesson30title_txt.VISIBLE = OFF;
		saveLoad00_slot35_pan.visible = off;// prev 11 to 20
			prev11to20title_txt.VISIBLE = OFF;  
		saveLoad00_slot36_pan.visible = off;// next 32-40 was prev 1 to 10
			nextlessons31to40title_txt.VISIBLE = OFF;
		saveLoad00_slot1_sel_pan.VISIBLE = OFF;
			saveLoad00_slot13_sel_pan.VISIBLE = OFF;
 		
 		saveLoad00_slot25_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot26_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot27_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot28_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot29_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot30_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot31_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot32_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot33_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot34_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot35_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot36_sel_pan.VISIBLE = OFF;
 	}
}
function	SaveLoad00_Slot_ShowHide_All4(showhide)
{
	if(showhide == 1)
	{
	
		closelessons_pan.VISIBLE = ON; //show close window button
		//
		// show all slots
		//
		saveLoad00_slot37_pan.visible = on;//show lesson 31
			lesson31title_txt.VISIBLE = ON;
		saveLoad00_slot38_pan.visible = on;
			lesson32title_txt.VISIBLE = ON;
		saveLoad00_slot39_pan.visible = on;
			lesson33title_txt.VISIBLE = ON;
		saveLoad00_slot40_pan.visible = on;
			lesson34title_txt.VISIBLE = ON;
		saveLoad00_slot41_pan.visible = on;
			lesson35title_txt.VISIBLE = ON;//Pass Opposing Night Panel4
		saveLoad00_slot42_pan.visible = on;	//slot 42 blank
		saveLoad00_slot43_pan.visible = on;	//slot 43 blank
		saveLoad00_slot44_pan.visible = on;
			Panel4prev21to30title_txt.VISIBLE = ON;//Panel4prev11to20title_txt.VISIBLE = ON;
		saveLoad00_slot45_pan.visible = on;
			Panel4prev11to20title_txt.VISIBLE = ON;//Panel4prev1to10title_txt.VISIBLE = ON;
		saveLoad00_slot46_pan.visible = on;
			Panel4prev1to10title_txt.VISIBLE = ON;//Panel4prev1to10title_txt.VISIBLE = ON;
	
		saveLoad00_slot47_pan.visible = on;
			//BLANK Panel4prev1to10title_txt.VISIBLE = ON;	
		saveLoad00_slot48_pan.visible = on;
			//BLANK Panel4prev1to10title_txt.VISIBLE = ON;
	}
	else
	{
		closelessons_pan.VISIBLE = OFF; //hide close window button
		//
		// hide all slots
		//
		saveLoad00_slot37_pan.visible = off;
			lesson31title_txt.VISIBLE = Off;
		saveLoad00_slot38_pan.visible = off;
			lesson32title_txt.VISIBLE = Off;
		saveLoad00_slot39_pan.visible = off;
			lesson33title_txt.VISIBLE = Off;
		saveLoad00_slot40_pan.visible = off;
			lesson34title_txt.VISIBLE = Off;
		saveLoad00_slot41_pan.visible = off;
			lesson35title_txt.VISIBLE = Off;
			
		saveLoad00_slot42_pan.visible = off;	
		saveLoad00_slot43_pan.visible = off;
			
		saveLoad00_slot44_pan.visible = off;
			Panel4prev21to30title_txt.VISIBLE = Off;
		saveLoad00_slot45_pan.visible = off;
			Panel4prev11to20title_txt.VISIBLE = Off;
		saveLoad00_slot46_pan.visible = off;
			Panel4prev1to10title_txt.VISIBLE = Off;
		saveLoad00_slot47_pan.visible = off;//blank	
		saveLoad00_slot48_pan.visible = off;//blank
						
 		
 		saveLoad00_slot37_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot38_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot39_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot40_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot41_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot42_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot43_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot44_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot45_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot46_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot47_sel_pan.VISIBLE = OFF;
 		saveLoad00_slot48_sel_pan.VISIBLE = OFF;
 	}
}
// Desc: Display save game panel, allow user the option to save game state
function SaveLoad00_SaveState_Display()
{
	// Display panel
	ifdef saveLoad00_auto_center_save;
	//if(saveLoad00_auto_center_save == 1)
	//{
		// center the panel
 		saveLoad00_save_pan.pos_x = (screen_size.x - bmap_width(saveLoad00_save_bmp)) / 2;
  		saveLoad00_save_pan.pos_y = (screen_size.y - bmap_height(saveLoad00_save_bmp)) / 2;
	//}
	endif;
	saveLoad00_save_pan.visible = on;

	// set up 'slots'
	//SaveLoad00_Slot_Check();	// check if slots are used
	SaveLoad00_Slot_Set_All(saveLoad00_save_pan.pos_x, saveLoad00_save_pan.pos_y); // set the state of all slots
	SaveLoad00_Slot_ShowHide_All(1);  	// show all slots

	// save mouse state and bring up mouse cursor
	var	old_mouse_mode;
	old_mouse_mode = mouse_mode;
	saveLoad00_tmp_mouse_bmp = mouse_map;
	mouse_mode = 2;
	mouse_map = saveLoad00_load_mouse_bmp; // was save_mouse


	saveLoad00_slot_clicked = 0;	// wait for user to click slot
	// loop on user input
	while(saveLoad00_slot_clicked == 0)
	{
		if(Key_Pressed(saveLoad00_esc_scancode)) { break; }	// cancel save
		mouse_pos.x = pointer.x;
		mouse_pos.y = pointer.y;
		wait(1);
	}

	// restore mouse mode and bitmap
	mouse_mode = old_mouse_mode;
	mouse_map = saveLoad00_tmp_mouse_bmp;


	SaveLoad00_Slot_ShowHide_All(0);  	// hide all slots
	
	saveLoad00_save_pan.visible = off;
	saveLoad00_active = 0; 	// signal calling function that we are done


	// save game
	if((saveLoad00_slot_clicked > 0) && (saveLoad00_slot_clicked < 9))
	{
		wait(1);	// allow menus to vanish...
		SaveLoad00_SaveState(saveLoad00_basename_str,saveLoad00_slot_clicked,saveLoad00_savemode);
	}
}


// Desc: Display load game panel, allow user the option to load a game state
function SaveLoad00_LoadState_Display()
{
	// Display panel
	ifdef saveLoad00_auto_center_load;
	//if(saveLoad00_auto_center_load == 1)
	//{
		// center the panel
 		saveLoad00_load_pan.pos_x = (screen_size.x - bmap_width(saveLoad00_load_bmp)) / 2;
  		saveLoad00_load_pan.pos_y = (screen_size.y - bmap_height(saveLoad00_load_bmp)) / 2;
	//}
	endif;
	saveLoad00_load_pan.visible = on; //make Load panel visible
	// set up 'slots'
	//SaveLoad00_Slot_Check();	// check if slots are used
	SaveLoad00_Slot_Set_All(saveLoad00_load_pan.pos_x, saveLoad00_load_pan.pos_y);// set the state of all slots
	SaveLoad00_Slot_ShowHide_All(1);  	// show all slots and close button
	

	// save mouse state and bring up mouse cursor
	var	old_mouse_mode;
	old_mouse_mode = mouse_mode;
	saveLoad00_tmp_mouse_bmp = mouse_map;
	mouse_mode = 1;
	mouse_map = saveLoad00_load_mouse_bmp;
	//mouse_pos.x = mouse_cursor.x + 1100;
	freeze_mode = 1;

	saveLoad00_slot_clicked = 0;	// wait for user to click slot
	// loop on user input
	while(saveLoad00_slot_clicked == 0)
	{
		if((Key_Pressed(saveLoad00_esc_scancode)) || (JOY_1))
			{ break; }	// cancel save
		mouse_pos.x = pointer.x;
		mouse_pos.y = pointer.y;
		wait(1);
	}
	mouse_pointer = 0;
	mouse_mode = 0;
/*	while(1) //esc key operation to close both main menu and leesons panel
	{
		if (joy_4)
		{
			saveLoad00_load_pan.visible = OFF; //close lesson panel
			SaveLoad00_Slot_ShowHide_All(0); //hide slots
			SaveLoad00_Slot_ShowHide_All2(0);
			SaveLoad00_Slot_ShowHide_All3(0);
			closelessons_pan.VISIBLE =OFF; //hide close button
			mouse_pointer = 0;
			mouse_mode = 0;
		}
		wait(-.125);
	}*/
	// restore mouse mode and bitmap
	mouse_mode = old_mouse_mode;
	mouse_map = saveLoad00_tmp_mouse_bmp;
	//mouse_mode = 0;


	SaveLoad00_Slot_ShowHide_All(0);  	// hide all slots

	SaveLoad00_Slot_ShowHide_All2(0);
	SaveLoad00_Slot_ShowHide_All3(0);
	SaveLoad00_Slot_ShowHide_All4(0);
	saveLoad00_load_pan.visible = off;
	saveLoad00_active = 0; 	// signal calling function that we are done

	// load game
	if((saveLoad00_slot_clicked > 0) && (saveLoad00_slot_clicked < 9))
	{
		wait(1);
		SaveLoad00_LoadState(saveLoad00_basename_str,saveLoad00_slot_clicked);
	}

}

endif;