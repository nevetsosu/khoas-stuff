//
////////////////////////////////////////////////////////////////////////
// v. 2.64
////////////////////////////////////////////////////////////////////////
//Logitech G27G29;Thrustmaster T150T300TMXTMXPro
//Radio buttons for wheel set selection
//Created exit for T150 pedal problems
//Changed Press Brake or Accelerator to Just Acclerator
//DrivingSimEX v.2.6 1366 x 768
//Added 5 night scenarios
//Added shadows
//Reduced brake torque from 65K to 50K
//Improved collision
//Highbeam bug fixed
//Fixed EndScenario bug on Left turns
//Increased speed traffic Left turn fog and night
//Rural level lighting changes
//Windowed,Engine Mouse Pointer
//Increased Max FPS from 30 to 50
//Removed Bldg bwk8 MDL from Urban tests
//Increased steering force from 2.3 to 4.6
//Reduced use of shade
//F10 for Full Screen, F12 for Windowed
//Added "Brake" to Press for pedal calib
//Removed Brake and added instr to rese to default
////////////////////////////////////////////////////////////////////////////
// The PATH keyword gives directories where template files can be found.
path "C:\\Program Files\\GStudio7\\template_6";	// Path to A6 templates directory
path "C:\\Program Files\\GStudio7\\template_6\\code";	// Path to A6 template code subdirectory
path "C:\\Program Files\\GStudio7\\template_6\\docs"; //path to docs
path "C:\\Program Files\\GStudio7\\template_6\\images";	// Path to A6 template image subdirectory
path "C:\\Program Files\\GStudio7\\template_6\\sounds";	// Path to A6 template sound subdirectory
path "C:\\Program Files\\GStudio7\\template_6\\models";	// Path to A6 template model subdirectory



/////////////////////////////////////////////////////////////////
// Filename of the starting level.
string level_str = <getstarted.WMB>; // give file names in angular brackets
////////////////////////////////////////////////////////////////////////////
// Included files

include "gid01.wdl";	// global ids
include "display00.wdl";  // basic display settings
include "startup01.wdl"; //startup window
include "miscInput01.wdl";
include "saveLoad00.wdl";

var startcount;
var starthour;
var startmin; 
/////////////////////////////////////////////////////////////////
// Desc: The main() function is started at game start
 function main()
{
	// set some common flags and variables
	//video_switch(9,0,0);

	video_window(NULL,NULL,16,"DrivingSimEX");//was 16
//	video_window(NULL,sys_metrics(77),16,"DrivingSimEX");//,vector(1366,768,2),1,NULL);//sys_metrics(78),sys_metrics(79)
	wait(1);
	video_set(1366,768,0,2);//was 1366 x 768
	//video_switch(9,0,2);//use for single monitorsys_metrics(76)

	// freeze all entity functions
	freeze_mode = 1;
	// no level has been loaded yet...
	gid01_level_state = gid01_level_not_loaded;

	// entry: Warning Level (0,1, or 2)
	// entry_help: Sets sensitivity to warnings (0 = none, 1 = some, 2 = all).
	warn_level = 1;	// announce bad texture sizes and bad wdl code - was 1


	// entry: Starting Mouse Mode (0, 1, or 2)
	mouse_mode = 0;//was 0
	//mouse_pointer = 0;

max_entities = 2000;
	// wait 3 frames (for triple buffering) until it is flipped to the foreground
	wait(3);
preload_mode = 2;
//shadow_stencil = 0;//cannot use stencils with open mesh models

	// now load the level
	level_load(level_str);

	wait(3);	// let level load
	
	// level should be loaded at this point...
	gid01_level_state = gid01_level_loaded;

	//+++ load starting values
	//////////////
	//Start the evaluation count all code lines needed plus var startcount
	/////////////
	var filehandle;
	
	
	filehandle = file_open_append("startcount.txt");
	filehandle = file_open_read("startcount.txt");
	
	//below is for DEMO
	startcount = file_var_read(filehandle); //read current value
	startcount += 1;




	// un-freeze the game
	
	freeze_mode = 0;

	// save start of game here
	wait(6);   // allow time for functions that wait for "gid01_level_loaded" to load
	//file_delete("start0.SAV");	// remove any old savefile
	//wait(1);
	/*if( game_save("start",0,SV_ALL) <= 0)
	{
		diag("\nWARNING! main - Cannot save 'start' of level (ignore on restarts).");
	}
	else
	{
		diag("\nWDL: main - Game 'start' saved.");
	}*/


	// main game loop
	while(1)
	{
		if(gid01_level_state != gid01_level_loaded) 
		{
			freeze_mode = 1;  // pause the game
			while(gid01_level_state != gid01_level_loaded) { wait(1); }
			freeze_mode = 0;  // resume the game
		}
		wait(1);
	}

}


// Desc: this is the function used to restart the game.
function	main_restart_game()
{
	// wait 3 frames (for triple buffering) until it is flipped to the foreground
	wait(3);

	// freeze the game
	freeze_mode = 1;

	if( game_load("start",0) <= 0)
	{
		diag("\nWARNING! main_restart_game - Cannot load 'start' of level.");
	}
	else
	{
		diag("\nWDL: main_restart_game - Game 'start' loaded");
	}

	// un-freeze the game
	freeze_mode = 0;
}
BMAP truckrightrearmirror_bmp = "truckrightrearmirror.bmp";
BMAP truckleftrearmirror_bmp = "truckleftrearmirror.bmp";
BMAP rightrearmirror_bmp = "rightrearmirror.bmp";
BMAP leftrearmirror_bmp = "leftrearmirror.bmp";
BMAP toprearmirror_bmp = "toprearmirror.bmp";
BMAP drivsimsumm_bmp = "drivsimsumm.bmp";
BMAP closedrivsumm_bmp = "closedrivsumm.bmp";
BMAP savedrivsumm_bmp = "savedrivsumm.bmp";


BMAP savescreenmsg_bmp = "savescreenmsg.bmp";
BMAP seldistractormsg_bmp = "seldistractormsg.bmp";
BMAP closeseldistractormsg_bmp = "closeseldistractormsg.bmp";

BMAP closewheelpedalset_bmp ="closewheelpedalset.bmp";

BMAP speedometerkm = "speedometerKM.bmp";
BMAP tachometer = "tachometernew.bmp";
BMAP gears = "gearpix.pcx";      // Gear number display - numbers are 20 pixels wide
BMAP driverinfo_bmp = "driverinfo.bmp";
BMAP whitebackgrd_bmp = "whitebackgrd.bmp";
BMAP scenariosummUNSEL_bmp = "scenariosummUNSEL.bmp";
BMAP scenariosummSEL_bmp = "scenariosummSEL.bmp";
BMAP verbalizeUNSEL_bmap = "verbalizeUNSEL.bmp";
BMAP verbalizeSEL_bmap = "verbalizeSEL.bmp";
BMAP fullscreenviewing_bmp = "fullscreenviewing.bmp";
BMAP closefullscreen_bmp = "closefullscreen.bmp";//close button for full screen dialog

BMAP displayG27G29UNSEL_bmp = "displayG27G29UNSEL.bmp";
BMAP displayG27G29SEL_bmp = "displayG27G29SEL.bmp";
BMAP displayT150T300UNSEL_bmp = "displayT150T300UNSEL.bmp";
BMAP displayT150T300SEL_bmp = "displayT150T300SEL.bmp";
BMAP displayTMXTMXProUNSEL_bmp = "displayTMXTMXProUNSEL.bmp";
BMAP displayTMXTMXProSEL_bmp = "displayTMXTMXProSEL.bmp";
BMAP selectwheelpedalset_bmp = "selectwheelpedalset.bmp";

FONT big20_font = "Arial", 1,20;
FONT big16_font = "Arial",1,16;
FONT panel_font = "Arial",1,12;    	// 12 pt. bold font,
FONT system_font = "Arial",1,14; //14 pt. bold Arial truetype
FONT distract_font = "Arial",1,12;
var_nsave fhandle_2;
var_nsave filehandle;
var gear = 1; //was 1    // Gear number in use - initially first gear (calculated)
var gear_pos[2] = 0,0;  // Scroll position of the gear display (calculated)
//Driver Information
//
STRING idnumber_str = "    ";
STRING filename_str;
STRING text_str = ".txt";
STRING dummyname_str ="               ";
STRING drivername_str ="           "; // long empty string 11
STRING filename_str;
STRING datetime_str ="              ";

STRING filenamepre_str="\"";
STRING filenamesuf_str="\"";
STRING scenarioname_str;
STRING screenfile_str;
STRING linefeed_str = "\n";

//Below for save SUMMARY
//
STRING passingscores_str ="

PASSING SCORES:
  
Collisions: 0;  Speed Limit:< 5;  Too Slow:< 5;  No Signal:< 5; 
Follow Too Close:<10  Lat Dev:<10; Road Edge:<5; Median:0; 
BrakeRT:<0.7";

STRING measuresdef_str = "

MEASURES DEFINED:

Date:  Month, Day, Year of summary creation
Time: Hour,Minute of summary creation
Collisions: Number of collision events
Speed Limit: Second 5+ mph over the speed limit
Too Slow:  Seconds 5+ under speed limit
No Signal: Seconds of no turn signal priorto turn
Follow too Close:  Second driving too close to vehicle ahead
Lat Dev: Mean lateral deviation (feet) of right edge of vehicle from road edge
Road Edge: Seconds vehicle has crossed road edge
Median:  Seconds vehicle has illegally crossed road median
BrakeRT:  Time (sec.) elapsed from object entry to road until brake pedal pressed

NOTE:  Not all performance measures are collected for each scenario\n

";
//
//
var numcollisions = 0;
var speedexceed = 0; //num of times speed limit exceeded
var followtooclose = 0;
var noturnsignalcount = 0;
var speedtooslow = 0;
var overroadedge = 0;
var overmedian = 0;
var latdev = 0;
var meanlatdev = 0;
var rmse = 0;
var brakeRT = 0;
var brakeRT2 = 0;
var brakeRT3 = 0;
var brakeRT4 = 0;
var brakeRT5 = 0;
var scenariosummflag = 0;
var screenfilenum = 0;
var selectEXM = 0;//0 = EX, 1 = EXM
var proginstL30 = 0; 
var scenariotime = 0;
var meanlatdevsumm = 0;

var displayG27G29flag = 1; //set for Logitech G29 (default);
var displayT150T300flag = 0;//set for Thrustmaster T150
var displayTMXTMXProflag = 0;//set for Thrustmaster TMX

//function hideG27G29();
function showG27G29();
//function hideT150T300();
function showT150T300();
//function hideTMXTMXPro();
function showTMXTMXPro();


function closewheelpedalset();


function closedrivsumm;
function closefullscreendialog;


PANEL fullscreenviewing_pan =
	{
	pos_x = 475;// Position the panel was 375
	pos_y = 225;   // 
	layer = 2;
	bmap = fullscreenviewing_bmp; 
	}
	
PANEL closefullscreen_pan =//button to close full screen viewing dialog
	{
		pos_x = 610;//was 510
		pos_y = 415;
		layer = 12;
		bmap = closefullscreen_bmp;
		on_click = closefullscreendialog();//closes dialog full screen viewing
	}	
PANEL drivsimsumm_pan =
	{
		pos_x = 370;//was 170
		pos_y = 100;
		layer = 11;
		bmap = drivsimsumm_bmp;
	}

PANEL closedrivsumm_pan =
	{
		pos_x = 730;//was 720
		pos_y = 580;
		layer = 12;
		bmap = closedrivsumm_bmp;//Close button
		on_click = closedrivsumm();
	}
	
PANEL savedrivsumm_pan =
	{
		pos_x = 640;//was 630
		pos_y = 580;
		layer = 12;
		bmap = savedrivsumm_bmp;//Save button
		on_click = saveSUMMARY();//show msg and save screen to file
	}
	
PANEL savescreenmsg_pan =
		{
		pos_x = 550;//500
		pos_y = 200;
		layer = 48;
		bmap = savescreenmsg_bmp;//dialog save to BRSimData folder
		}	

PANEL seldistractormsg_pan =
		{
		pos_x = 500;//was 400
		pos_y = 200;//was 200
		layer = 48;
		bmap = seldistractormsg_bmp;//msg alerting driver to expect distractor
		}

PANEL closeseldistractormsg_pan =
		{
		pos_x = 620;//was 580
		pos_y = 410;
		layer = 49;
		bmap = closeseldistractormsg_bmp;
		on_click = closeseldistractormsg();
		}
		//////////////////////////////////////////////////////
		//////  Put a speedometer dial on the screen
		//////////////////////////////////////////////////////
		
PANEL speeddial =
		{
			bmap = speedometerKM;
			pos_x = 404;
			pos_y = 570;//was 550
			scale_y = 1.0;
			scale_x = 1.0;
			flags = overlay;  // set flags  refresh, d3d, overlay
			layer = 2;
		}
		
		//////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////
		//////  Put a tachometer dial on the screen
		//////////////////////////////////////////////////////////////////
		
PANEL tachdial =
		{
			bmap = tachometer;
			pos_x = 223;     //see player car function dynamic Position of the tachometer, was 203
			pos_y = 570;   // was 550 Use 4 and 600 for 1024
			scale_y = 1.0;
			scale_x = 1.0;
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 2;
		}	
		
		//////////////////////////////////
		// Add the highbems icon and speedometer needle  ///
		//////////////////////////////////
		
ENTITY highbeams =
		{
			type = "highbeams.bmp";
			layer = 5;
			ambient = 100;
			x = 125;				//pos_x = 200; 
			y = 45; //was 45
			z = -38.0;			// Position
			//pos_y = 500;    // 
			//size_x = 118;
			scale_x = 0.08;  // Scaled width of arrow - use 0.15 for 1024
			scale_y = 0.14;  // Scaled length of arrow - use 0.25 for 1024
			scale_z = 0.22;  // Thickness - not really used
			flags =  OVERLAY;   // set flags  refresh, d3d, overlay
		}		
ENTITY sneedle =
		{
			type = "needle.tga";
			layer = 5;             // display over lower layers
			flags = OVERLAY, nofilter; //not visible at startup
			ambient = 100;
			scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
			scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
			scale_z = 0.22;  // Thickness - not really used
		//	view  = camera;
			x = 201;      // distance ahead of the view
			y = 27.5;     // was -2.0 left-right distance 0 = center (use 98.0 for 1024) was 17
			z = -50.1;    // was -32.0 vertical distance   0 = center (use -31.3 for 1024)
			
		}
	
		/////////////////////////////////
		// Add the tachometer needle  ///
		/////////////////////////////////
		
ENTITY tneedle =
		{
			type = "needle.tga";
			layer = 5;             // displays over lower layers
			flags = overlay, nofilter;       
			ambient = 100;
			scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
			scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
			scale_z = 0.22;  // Thickness - not really used    
		//	view  = camera;
			x = 201; // distance ahead of the view
			y = 58.7;// was 57.5 left-right distance 0 = center
			z = -50.1; //up-down
			
		}
	
TEXT driveridnumber_txt =  //display on summary
		{
			
			pos_x = 603; //was 613
			pos_y = 154; //was 135
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = big20_font;
			string (idnumber_str);
			layer = 12;
		
		}
		
TEXT scenarioname_txt =  //display on summary
		{
			
			pos_x = 713; //was 693
			pos_y = 154; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = big20_font;
			string (scenarioname_str);
			layer = 12;
		
		}
	
PANEL sys_monthdisp =
		{
	
			pos_x = 410;     // Position the  display was 165
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,sys_month);//*
			layer = 12;
		}
		
PANEL sys_daydisp =
		{
			pos_x = 426;     // Position the  display was 165
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,sys_day);//*
			layer = 12;
		}
		
PANEL sys_yeardisp =
		{
			pos_x = 446;     // Position the  display was 165
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,sys_year);//*
			layer = 12;
		}
		
PANEL sys_hoursdisp =
		{
	
			//bmap = numcoll
			pos_x = 481;     // Position the  display was 165
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,sys_hours);//*
			layer = 12;
			
		}
		
PANEL sys_minutesdisp =
		{
	
			pos_x = 501;     // Position the  display was 165
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,sys_minutes);//*
			layer = 12;
	
		}
		
PANEL numcollisionssumm =
		{
			pos_x = 556;     // Position the  display was 356
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,numcollisions);
			layer = 12;
			
		}
		
PANEL speedlimitsumm =
		{
			pos_x = 606;     // Position the  display was 406
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,speedexceed);
			layer = 12;
			
		}
		
PANEL speedtooslowsumm =
		{
			pos_x = 638;     // Position the  display was 466
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,speedtooslow);
			layer = 12;
		}
		
PANEL noturnsignalsumm =
		{
			pos_x = 677;     // Position the  display was 506
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,noturnsignalcount);
			layer = 12;
		}
		
PANEL followtooclosesumm =
		{
			pos_x = 736;     // Position the  display was 536
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,followtooclose);
			layer = 12;
		}
		
PANEL meanlatdevsumm_pan =
		{
			pos_x = 776;     // Position the  display was 586
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.1f",big16_font,1,meanlatdevsumm);
			layer = 12;
		}
		
PANEL overroadedgesumm =
		{
			pos_x = 866;     // Position the  display was 656
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,overroadedge);
			layer = 12;
		}
		
PANEL overmediansumm =
		{
			pos_x = 916;     // Position the  display was 716
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.0f",big16_font,1,overmedian);
			layer = 12;
		}
		
PANEL brakertsumm =
		{
			pos_x = 965;     // Position the  display was 926
			pos_y = 215;   // Use 4 and 600 for 1024
			digits(0,0,"%.1f",big16_font,1,brakeRT);//big16_font
			layer = 12;
		}
		
PANEL geardisp=
		{
			pos_x = 195;     // Position the gear display was 165
			pos_y = 610;   // Use 4 and 600 for 1024
		
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			flags = visible | overlay; // set flags
			layer = 3;
			window = 0, 0, 20, 20, gears, gear_pos.x, gear_pos.y;
		}

TEXT drivernamelabel_txt =  //entry for name
		{
			
			pos_x = 615; //was 465
			pos_y = 292; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = big20_font;
			string (drivername_str);
			layer = 4;
		
		}
		
TEXT idnumberlabel_txt =  //entry for number
		{
			
			pos_x = 615; //was 465
			pos_y = 325; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = big20_font;
			string (idnumber_str);
			layer = 4;
		
		}
			
TEXT datetime_txt =  
		{
			
			pos_x = 340; //was 570
			pos_y = 280; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = system_font;
			string (datetime_str);
			layer = 12;
		}
		
	PANEL driverinfo_pan = 
	{
		pos_x = 525;     // Position the panel
		pos_y = 225;   // 
		layer = 2;
		bmap = driverinfo_bmp;
		
	}
	
	PANEL whitebackgrd_pan = 
	{
		pos_x = 0;     // Position the panel
		pos_y = 0;   // 
		layer = 1;
		bmap = whitebackgrd_bmp;
		
	}
	PANEL toprearmirror_pan = 
	{
		pos_x = 858;     // was 658 Position the panel
		pos_y = 14;   // 
		layer = 3;
		bmap = toprearmirror_bmp;
		flags = OVERLAY | VISIBLE;
		
	}
	PANEL leftrearmirror_pan = 
	{
		pos_x = 14;     // Position the panel horizontally
		pos_y = 480;   // 
		size_x = 157;
		size_y = 107;
		layer = 3;
		bmap = leftrearmirror_bmp;
		flags = OVERLAY | VISIBLE;
		
	}
	
	PANEL rightrearmirror_pan = 
	{
		pos_x = 1198;     // was 856 Position the panel horiz
		pos_y = 480;   // 
		layer = 3;
		bmap = rightrearmirror_bmp;
		flags = OVERLAY | VISIBLE;
		
	}
	
	PANEL truckrightrearmirror_pan = 
	{
		pos_x = 912;     // Position the panel
		pos_y = 263;   // 
		
		layer = 3;
		bmap = truckrightrearmirror_bmp;
		flags = OVERLAY | VISIBLE;
		
	}
	
	PANEL truckleftrearmirror_pan = 
	{
		pos_x = 7;     // Position the panel
		pos_y = 263;   // 
		
		layer = 3;
		bmap = truckleftrearmirror_bmp;
		flags = OVERLAY | VISIBLE;
		
	}
	
	ENTITY distractDisplay_ent =
{
	type = "distractorDisplay.bmp";
	layer = 5;             // displays over lower layers
	flags = OVERLAY;       
	ambient = 100;
	scale_x = .2;  // Scaled width of needle - use 0.15 for 1024
	scale_y = .2;  // Scaled length of needle - use 0.25 for 1024
	scale_z = .2;  // Thickness - not really used    
	view  = camera;
	x = 250;// distance ahead of the view was 200 large means smaller size
	y = -59.5;     // left-right distance 0 = center (use 97.5 for 1024) was 52.5
	z = -62.5;    // vertical distance   0 = center (use -67.0 for 1024) was -62
}
	TEXT filename_txt =  
		{
			
			pos_x = 660; //was 560
			pos_y = 325; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = big20_font;
			string (filename_str);
			layer = 12;
		
		}

		
// Desc: this is the function used to quit the game.
function	main_quit()//QUIT SIMULATOR
{
	//+++			// save global skills & strings
	
	//Show Drive Sim Summary
//

wait(2);
	menu01_hide_main();
	highbeams.VISIBLE = OFF;
	speeddial.VISIBLE = OFF;
	tachdial.VISIBLE = OFF;
	sneedle.VISIBLE = OFF;
	tneedle.VISIBLE = OFF;
	geardisp.VISIBLE = OFF;
	toprearmirror_pan.VISIBLE = OFF;
	leftrearmirror_pan.VISIBLE = OFF;
	rightrearmirror_pan.VISIBLE = OFF;
	truckleftrearmirror_pan.VISIBLE = OFF;
	truckrightrearmirror_pan.VISIBLE = OFF;
	distractDisplay_ent.VISIBLE = OFF;
	level_load ("");
	whitebackgrd_pan.VISIBLE = ON;
	freeze_mode = 1;
	//L1 file
	
	
	//str_cat(filename_str,"L1");//filename_str contains driver name and id
	//str_cat(filename_str,"GetStart");
	//str_cat(filename_str,".txt");
	//filehandle=file_open_read("atlee1111L1GetStart.txt");
	//fhandle_2 = file_open_read(filename_str);//atlee4444L1Getstart.txt
	//if(filehandle == file_open_read("atlee1111L1GetStart.txt") == 0)
	//{
	//filename_txt.VISIBLE = ON;
	//wait(-3);
	//filename_txt.VISIBLE = OFF;
	//}

	//str_cpy(delimit_str,",");//end input string
	//file_str_read(filehandle,datetime_str);//find 
	
	
	//numcollisions = file_var_read(fhandle_2);//read collisions into var
	wait(-.5);
	if(scenariosummflag == 0)
	{
	driveridnumber_txt.VISIBLE = ON;
	drivsimsumm_pan.VISIBLE = ON;
	closedrivsumm_pan.VISIBLE = ON;
	savedrivsumm_pan.VISIBLE = ON;
	sys_monthdisp.VISIBLE = ON;
	sys_daydisp.VISIBLE = ON;
	sys_yeardisp.VISIBLE = ON;
	sys_hoursdisp.VISIBLE = ON;
	sys_minutesdisp.VISIBLE = ON;
	scenarioname_txt.VISIBLE = ON;
	numcollisionssumm.VISIBLE = ON;
	speedlimitsumm.VISIBLE = ON;
	speedtooslowsumm.VISIBLE = ON;
	noturnsignalsumm.VISIBLE = ON;
	followtooclosesumm.VISIBLE = ON;
	meanlatdevsumm_pan.VISIBLE = ON;
	overroadedgesumm.VISIBLE = ON;
	overmediansumm.VISIBLE = ON;
	brakertsumm.VISIBLE = ON;
	}
	mouse_mode = 1;//was 1
	while(drivsimsumm_pan.VISIBLE == ON)
	{	
	mouse_pos.x = mouse_cursor.x;
	mouse_pos.y = mouse_cursor.y;
	wait(1);
	}
	mouse_mode = 0;
	exit;
}


/////////////////////////////////////////////////////////////////
// The following definitions are for the pro edition window composer
// to define the start and exit window of the application.
WINDOW WINSTART
{
	TITLE			"3D GameStudio";
	SIZE			1024,768;								//480,320;
	MODE			IMAGE;	//STANDARD;
	BG_COLOR		RGB(240,240,240);
	FRAME			FTYP1,0,0,1024,768;									//FTYP1,0,0,480,320;
	//	BUTTON		BUTTON_START,SYS_DEFAULT,"Start",400,288,72,24;
	BUTTON		BUTTON_QUIT,SYS_DEFAULT,"Abort",400,288,72,24;
	TEXT_STDOUT	"Arial",RGB(0,0,0),10,10,460,280;
}

/* no exit window at all..
WINDOW WINEND
{
	TITLE			"Finished";
	SIZE			540,320;
	MODE	 		STANDARD;
	BG_COLOR		RGB(0,0,0);
	TEXT_STDOUT	"",RGB(255,40,40),10,20,520,270;

	SET FONT		"",RGB(0,255,255);
	TEXT			"Any key to exit",10,270;
}*/


/////////////////////////////////////////////////////////////////
//INCLUDE <debug.wdl>;

// To Use:  
//  1.  In WED, assign the action "Player_Car" to your car model
//  2.  You can position the rear view mirror by changing it's values (below)
//  3.  You can change car characteristics by changing table values (below)
//  4.  You can change the actual gear ratios in "Car_Init" (near the end of this file)
//  5.  Do not attempt to change table entries that are marked "(calculated)"
//  6.  While running, use "S" (steering) and "T" (Throttle) keys to toggle
//         between keyboard, mouse or joystick (See on-screen display)
//  ***** Please see "Changes.txt" and "Using.txt" documentation files  *****
//
//////////////////////////////////////////////////
// Car Specific values - TABLE ENTRY AREA      ///
//  Change these values for different vehicles ///
//////////////////////////////////////////////////
var Brake_Torque = 50000;   // Stopping force (arbitrary number)was 65K
var Car_Weight = 2600;       // Total car weight, in pounds  
var differential_ratio = 2.73; // Ratio of the differential gear  
var Drag = 0.35;             // was .31,Air friction (A Corvettte is 0.29)
var gear_efficiency = 0.8;   // Overall gear efficiency
var Horse_power = 160; //was 160     // Rated engine horsepower - will be converted to Max_Torq  
var num_gears = 6; //was 6          // Number of forward gears (at least 1, but no more than 6)
// Specify actual gear ratios in the Car_Init() function (near the end of this script)
var wheel_radius_inch = 15.0; // Wheel radius, in inches

/////////////////////////////////////////////////
//      Other table values you can adjust      //
/////////////////////////////////////////////////
var A_Chirp = 0.2;      // Amount of acceleration to cause tire squeal, or "chirp"
var Acel_Val = 5.0;     // Acceleration value - increase to accelerate slower was 7.0
var car_bstrength = 3.0;  //was 1 for g27 Increase to make braking quicker and more effective was 3
var car_sstrength = 1.5;  //was 3 for g27 Increase to make steering quicker and more effective
var car_tstrength = 2.0;  //2 for T150;was 2 for g27/g29 Increase to make throttle quicker and more effective was 3
var Corner_Lean = -0.1; // Leaning amount for cornering, reverse sign to reverse lean
var DnShift = 1000;     // Specify RPM to automaticaly down shift to a lower gear
var Hill_Effect = 1;    // Power gain/loss on a hill (Bigger number is less effect)
var Max_RPM = 7000;     // Maximum allowed engine speed
var Rock_Back = .1;     // For accelerating and braking - set high for wheelies
var steer_damage = 1;   // Usually always = 1, but can be varied to simulate damage
var T_Chirp = 0.4;      // Turning force needed to cause tire squeal, or "chirp"
var Turn_Effect = 4;    // Power loss when turning (Bigger number is less effect) was 4
var UpShift = 1800;     // 2000Specify RPM to shift to higher gear (+500 if accelerator floored) was 2500

// Features you can turn off - Set to zero for OFF, non-zero (1) for ON  
var Eng_Snd_On = 1;     // Engine sound
var Horn_Snd_On = 1;    // Horn sound
var Squeal_On = 0;      // Tire squeal sound
var RV_Mirror_On = 1;   // Rear_View Mirror
var Car_Hud_On = 1;     // On-screen displays
var Joy_Hat_On = 1;
var Event_type;
var anim_speed = 0;

var numcollisions_pos[2] = 0,0;  // Scroll position of the coll display (calculated)
var anycollision = 0;
var movewdmain = 0;
var movewdfirst = 0;

var hasbraked=0;
var hasbraked2=0;
var hasbraked3=0;
var hasbraked4=0;
var hasbraked5=0;
var_nsave filehandle;
var_nsave stringhandle;
var_nsave startcount;

var stantrans = 0;  //0 = auto; 1= manual
var clutchpedalin = 0;
var leftturnsignal = 0;  //0 = off; 1 = on;
var rturnsignal = 0;

var n1 = 1;
var n2 = 1;
var n3 = 1;
var n4 = 1;
var n5 = 1;
var n5a = 1;
var n6 = 1;
var n7 = 1;
var n8 = 1;
var n9 = 1;
var n10 = 1;
var n11 = 1;
var n12 = 1;
var n13 = 1;
var n14 = 1;
var latdev1 = 0;
var latdev2 = 0;
var latdev3 = 0;
var latdev4 = 0;
var latdev5 = 0;
var latdev5a = 0;
var latdev6 = 0;
var latdev7 = 0;
var latdev8 = 0;
var latdev9 = 0;
var latdev10 = 0;
var latdev11 = 0;
var latdev12 = 0;
var latdev13 = 0;
var latdev13 = 0;
var latdev14 = 0;
var latdevsq1 = 0;
var latdevsq2 = 0;
var latdevsq3 = 0;
var latdevsq4 = 0;
var latdevsq5 = 0;
var latdevsq5a = 1;
var latdevsq6 = 0;
var latdevsq7 = 0;
var latdevsq8 = 0;
var latdevsq9 = 0;
var latdevsq10 = 0;
var latdevsq11 = 0;
var latdevsq12 = 0;
var latdevsq13 = 0;
var latdevsq14 = 0;
var sumlatdev1 = 0;
var sumlatdev2 = 0;
var sumlatdev3 = 0;
var sumlatdev4 = 0;
var sumlatdev5 = 0;
var sumlatdev5a = 1;
var sumlatdev6 = 0;
var sumlatdev7 = 0;
var sumlatdev8 = 0;
var sumlatdev9 = 0;
var sumlatdev10 = 0;
var sumlatdev11 = 0;
var sumlatdev12 = 0;
var sumlatdev13 = 0;
var sumlatdev14 = 0;
var meanlatdev1 = 0;
var meanlatdev2 = 0;
var meanlatdev3 = 0;
var meanlatdev4 = 0;
var meanlatdev5 = 0;
var meanlatdev5a = 0;
var meanlatdev6 = 0;
var meanlatdev7 = 0;
var meanlatdev8 = 0;
var meanlatdev9 = 0;
var meanlatdev10 = 0;
var meanlatdev11 = 0;
var meanlatdev12 = 0;
var meanlatdev13 = 0;
var meanlatdev14 = 0;
var meanlatdevL30v2 = 0;
var meanlatdevL30v3 = 0;
var meanlatdevL30 = 0;
var meanlatdevL34 = 0;
var sumoflatdev = 0;
var meanlatdevL29 = 0;

var sqsumoflatdev = 1;
var stdL30a = 0;
var stdL30b = 0;
var stdL30 = 0;
var stdL30v2 = 0;
var stdL30v3 = 0;
var stdL34a = 0;
var stdL34b = 0;
var n1to14 = 0;

var endonceL30 = 0;
var endonceL28 = 0;
var endonceL34 = 0;//sets end scenario
var rmse = 0;


var ms = 0;
var ms2 = 0;
var n = 0;
var fullscreen = 0; //0 = windowed; 1 = fullscreen
var showselectwheelpedalset = 0;//default show only first getstarted
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
//   Define sound variables
SOUND wham_wav ="wham.wav";
SOUND turn_signal = "tsignal.wav";
SOUND collision = "wham.wav";

SOUND getstartedL1_wav = "getstartedL1.wav";
SOUND followingL2_wav = "followingL2.wav";
SOUND passingL3_wav = "passingL3.wav";
SOUND passingoncomL4_wav = "passingoncomL4.wav";
SOUND passingtrucksL5_wav = "passingtrucksL5.wav";
SOUND turnleftL6_wav = "turnleftL6.wav";
SOUND turnleftL7_wav = "turnleftL7.wav";
SOUND diagonalparkL8_wav = "diagonalparkL8.wav";
SOUND parallelparkurbanL9_wav = "parallelparkurbanL9.wav";
SOUND constrhazardL10_wav = "constrhazardL10.wav";
SOUND vanaheadL11_wav = "vanaheadL11.wav";
SOUND hazardsL12_wav = "hazardsL12.wav";
SOUND parkingtwolaneL13_wav = "parkingtwolaneL13.wav";
SOUND pedsxwalkL14_wav = "pedsxwalkL14.wav";
SOUND trafficjamL15_wav = "trafficjamL15.wav";
SOUND rightturnurbanL16_wav = "rightturnurbanL16.wav";
SOUND quickparkurbanL17_wav = "quickparkurbanL17.wav";
SOUND parallelparkurbanL18_wav = "parallelparkurbanL18.wav";
SOUND leftturnfogL19_wav = "leftturnfogL19.wav";
SOUND	passingfogL20_wav = "passingfogL20.wav";
SOUND freewayentranceL21_wav = "freewayentranceL21.wav";
SOUND freewayentryheavyL22_wav = "freewayentryheavyL22.wav";
//SOUND nightdrivingruralL23_wav = "nightdrivingruralL23.wav";
SOUND freewayexitleftlaneL24_wav = "freewayexitleftlaneL24.wav";
SOUND freewayentryfogL25_wav = "freewayentryfogL25.wav";
SOUND freewayexitleftfogL26_wav = "freewayexitleftfogL26.wav";
SOUND nightdrivingruralL27_wav = "nightdrivingruralL27.wav";
SOUND curvesandstraightsL28_wav = "curvesandstraightsL28.wav";
SOUND drivetestruralL29_wav = "drivetestruralL29.wav";
SOUND	drivetesturbanL30_wav = "drivetesturbanL30.wav";

SOUND leftturnnightL33_wav = "leftturnnightL33.wav";
SOUND nighturbanhazardsL34_wav = "nighturbanhazardsL34.wav";
SOUND passnightL35_wav = "lesson35passnight.wav";
SOUND turnleftintoparklotahead_wav = "lesson34turnleftintoparking.wav";

SOUND proceedthruintersectahead_wav = "proceedthruintersectahead.wav";
SOUND turnleftattrafficltahead_wav = "turnleftattrafficltahead.wav";
SOUND turnaroundinlotreturnstartpos_wav = "turnaroundinlotreturnstartpos.wav";
SOUND	enterfrwyontherightahead_wav = "enterfrwyontherightahead.wav";
SOUND	exitfrwyrightahead_wav = "exitfrwyrightahead.wav";
SOUND	turnleftatstopsignahead_wav = "turnleftatstopsignahead.wav";
SOUND turnleftonstreetahead_wav = "turnleftonstreetahead.wav";
SOUND turnrightatstopsignahead_wav = "turnrightatstopsignahead.wav";
SOUND turnrightattrafficltahead_wav ="turnrightattrafficltahead.wav";
SOUND	turnrtintoparklotahead_wav = "turnrtintoparklotahead.wav";
SOUND endofscenariopressESCkey_wav = "endofscenariopressESCkey.wav";
SOUND movetothecenterlane_wav = "movetothecenterlane.wav";
SOUND	movetotherightlane_wav ="movetotherightlane.wav";
var_nsave instruction_handle;
var_nsave navigation_handle;
var_nsave collision_handle;  //collision sound
var_nsave signal_handle;      //turn signal sound
var soundtest = 0;   // Used for the horn (calculated)
var soundtest2 = 0;  // Used for the tire squeal (calculated)
SOUND horn_sound = "Car_Horn.wav";   // Horn sound file
var_nsave Horn_handle; // Handle for horn sound (calculated)
SOUND tire_squeal = "Tire_Squeal.wav"; // Tire squeal sound file
var_nsave Squeal_handle; // Handle for tire squeal sound (calculated)
SOUND engsound = "Car_Engine.wav";  // Engine sound	file
var eng_pitch;        // frequency parameter for tune engine sound (calculated)
var_nsave enghandle;  // Handle for engine sound (calculated)
var floor_trace = 2; // Required for merge leaf build option

SOUND distractortextmsg_wav = "distractortextmsg.wav";
var_nsave Msgs_handle;

// Other general variables 

var screen_hold = 0; // Hold until splash screens have completed (calculated)
var x640 = 0.625;    // Scale factor to convert 1024x768 to 640x480
var x800 = 0.78125;  // Scale factor to convert 1024x768 to 800x600
var blinkx = 0;



	
	
// On-Screen Messages  
STRING Steer_kb =
"(S)Steer with arrow keys";
STRING Steer_ms =
"(S)Steer with mouse"; 
STRING Steer_js ="(S)Steer with wheel";  

STRING Throttle_kb =  "(T)Throttle on arrow keys";
STRING Throttle_ms =  "(T)Throttle with mouse";
STRING Throttle_js = "(T)Throttle on accelerator pedal";
STRING esckey_str = "(ESC)Main menu/pause"; 
STRING noturnsignal_str =
		"Use your turn signal within 100 feet of a turn";
STRING pressbrake_str = 
			"Please Press Accelerator Now to Calibrate Pedals
	
	(If unable to calibrate, close program and Reset to Default in 
	Controller Properties/Setting Tab. Do not manually calibrate.)";
	
STRING turnleftPineTree_str = "Turn LEFT on street ahead (Pine Tree)";
STRING turnleftprkingtobrdwy_str = "Turn LEFT on street ahead (Broadway)";
STRING turnleftprkingbrdwy_str = "Turn LEFT into PARKING LOT ahead";
STRING turnrtbrdwytofirst_str = "Turn RIGHT at TRAFFIC LIGHT ahead (FIRST AVE)";
STRING turnleftfirsttomain_str = "Turn LEFT at TRAFFIC LIGHT ahead (MAIN ST)";
STRING turnrightmaintomrkt_str = "Turn RIGHT at STOP SIGN ahead (MARKET ST)";
STRING turnrightmrkttocenter_str = "Turn RIGHT at STOP SIGN ahead (CENTER ST)";
STRING turnrtctrtofirst_str = "Turn RIGHT at TRAFFIC LIGHT ahead (FIRST AVE)";
STRING turnrightctrto3rd_str = "Turn RIGHT at STOP SIGN ahead (THIRD ST)";
STRING turnright3rdtoMain_str = "Turn RIGHT at TRAFFIC LIGHT ahead (MAIN ST)";
STRING turnleftMainto2nd_str =  "Turn LEFT at TRAFFIC LIGHT ahead (SECOND AVE)";
STRING turnrightMaintobrdwy_str = "Turn RIGHT at STOP SIGN ahead (BROADWAY)";

STRING turnrightmaintofourth_str = "Turn RIGHT at STOP SIGN ahead (FOURTH AVE)";
STRING turnrightfourthtocommerce_str = "Turn RIGHT at STOP SIGN ahead (COMMERCE ST)";
STRING turnrightcommercetomrkt_str = "Turn RIGHT at STOP SIGN ahead (MARKET ST)";
STRING turnrightmrkttobrdwy_str = "Turn RIGHT at STOP STOP SIGN ahead (BROADWAY)";	
STRING proceedthrubrdwy_str = "PROCEED thru INTERSECTION ahead (BROADWAY)";
STRING procthrufirst_str = "PROCEED thru INTERSECTION ahead (FIRST AVE)";
STRING gothrufirstonbrdwy_str = "PROCEED thru INTERSECTION ahead (FIRST AVE)";

STRING proceedthrufirst_str = "PROCEED thru INTERSECTION ahead (FIRST AVE)";
STRING proceedthrusecondave_str = "PROCEED thru INTERSECTION ahead (SECOND AVE)";
STRING proceedthruthirdave_str = "PROCEED thru INTERSECTION ahead (THIRD AVE)";
STRING proceedthrufirstbrdwy_str = "PROCEED thru INTERSECTION ahead (FIRST AVE)";

STRING turnrightprkingbrdwy_str = "Turn RIGHT into PARKING LOT ahead";
STRING turnrightglenwood_str = "Turn RIGHT at STOP SIGN ahead (GLENWOOD RD)";
STRING turnrightparkplace_str = "Turn RIGHT at STOP SIGN ahead (PARK PLACE)";
STRING turnrightwestrd_str = "Turn RIGHT at STOP SIGN ahead (WEST RD.)";
STRING turnrightsouthrd_str = "Turn RIGHT at STOP SIGN ahead (SOUTH RD.)";
STRING enterfrwyonright_str = "Enter FREEWAY on the RIGHT ahead";
STRING movetocenterlane_str = "Move to CENTER LANE";
STRING movetorightlane_str = "Move to RIGHT LANE";
STRING exitfrwyright_str = "Exit FREEWAY on the RIGHT ahead";
STRING returntostart_str = "Turn Around in Lot Ahead and Return to Starting Position";

FONT system_font = "Arial",1,14; //14 pt. bold Arial truetype



BMAP speed1024 = "speedo.pcx";   // the speedometer dial for 1024x768
BMAP speed800 = "speedo800.pcx"; // the speedometer dial for 800x600
BMAP speed640 = "speedo640.pcx"; // the speedometer dial for 640x480
BMAP tach1024 = "tach2.pcx";      // the tachometer dial for 1024x768
BMAP tach800 = "tach800.pcx";    // the tachometer dial for 800x600
BMAP tach640 = "tach640.pcx";    // the tachometer dial for 640x480
BMAP turnsignal = "leftarrow.bmp";   // turn signal left display
BMAP rtturnsignal = "rightarrow.bmp"; //turn signal right display
BMAP leftblink = "leftblink.bmp";
BMAP instructtext = "instructtext.bmp";
BMAP numcoll = "numcollisions.pcx";
BMAP seltransveh = "seltransveh00.bmp"; //select automatic and pass car
BMAP stantransbuttonSEL = "stantransbuttSEL.bmp"; //standard trans selected button; //standard trans selected button
BMAP stantransbuttonUNSEL= "stantransbuttUNSEL.bmp"; //standard trans selected button
BMAP autotransbuttonSEL= "autotransbuttSEL.bmp";
BMAP autotransbuttonUNSEL= "autotransbuttUNSEL.bmp";
BMAP passcarbuttonSEL = "passcarbuttSEL.bmp";
BMAP passcarbuttonUNSEL = "passcarbuttUNSEL.bmp";
BMAP truckbuttonSEL = "truckbuttSEL.bmp";
BMAP truckbuttonUNSEL = "truckbuttUNSEL.bmp";
BMAP closeselecttransveh_bmp = "closeseltransveh.bmp";
BMAP saveLoad00_load_mouse_bmp = "arrow_blue.pcx";
BMAP*	saveLoad00_tmp_mouse_bmp; //was BMAP*
BMAP daysrem = "gearpix.pcx";

BMAP seldisplayoptions_bmp = "seldisplayoptions.bmp";
BMAP alertswarnsSEL_bmp = "alertswarnssel.bmp";
BMAP alertswarnsUNSEL_bmp = "alertswarnsunsel.bmp";
BMAP instructionsSEL_bmp = "instructionssel.bmp";
BMAP instructionsUNSEL_bmp = "instructionsunsel.bmp";
BMAP performmeasuresSEL_bmp = "performmeasuressel.bmp";
BMAP performmeasuresUNSEL_bmp = "performmeasuresunsel.bmp";
BMAP closedisplayoptions_bmp = "closedisplayoptions.bmp";

BMAP displayDistractSEL_bmp = "displayDistractSEL.bmp";
BMAP displayDistractUNSEL_bmp = "displayDistractUNSEL.bmp";



/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// Internal Calculations - Can be read, and used elsewhere, but can not be changed here
///////////////////////////////////////////////////////////////////////////////////////
var accelerator = 0;    // Accelerator calculated from joystick throttle or keyboard
var actor_scale = 0;
var absdist = 0;       
var Air_Resistance = 0; // Air resistance force (calculated from drag & speed)
var Airborne = 0;       // Set to one if my_height >= 5  (calculated)
var axle_rpm = 0;       // Rotation speed of the axles/wheels, in rpm (calculated)
var Bounce_Dist = 0;    // Distance to bounce after landing (calculated)
var Bounce_Speed = 0;   // Landing speed after being airborne (calculated)
var brakepedal=0;		  // Brakepedal value
var clutchpedal=0;		//clutch pedal value
var calc_rpm = 0;       // Calculated rpm (Theoretical)
var car_accel = 0;      // Acceleration (calculated within the physics routine)
var car_indic = 0;      // Car indicator 0 = normal, 1 = braking, 2 = backing up 
var car_speed = 0;      // Actual speed, uses distance traveled (Calculated)
var car_velocity = 0;   // Calculated from road force/2,     (theoretical speed)
var Corner_Squeal = 0;  // Amount of corner lean force (calculated)
var dist_x = 0;
var dist = 0;
var dist_y = 0;
var Down_Shift = 0;     // Down Shift forced by driver (SHIFT key sets it to 1)
var Drive_Torq = 0;     // Drive train torq plus braking (Calculated)
var Drop_Time = 0;      // Time the car spent falling  (Calculated - changed each jump)
var DTime = 0;          // Saved time spent falling (Calculated - changed each jump)
var drivereverse = 0;   // Driver/reverse toggle for auto, 0 = drive; 1 = reverse
var eng_pitch = 0;
var enghandle = 0;
var event_type;

var gear_ratio[8];      // Gear ratios for 6 forward, and 1 reverse (gear zero)  and 1 neutral
var Grav = 32.1;        // Gravitational constant in feet/sec*sec (fixed - don't change)
var Hang_Time = 0;      // Time the car was airborne (calculated - changed each jump)
var HTime = 0;          // Saved value of Hang Time (calculated - changed each jump)
var Impact_Angle = 0;   // Saved value of the angle at impact, after falling (calculated - changed each jump)
var Impact_Speed = 0;   // Saved value of the speed at impact, after falling (calculated - changed each jump)
var key_press1 = 0;     // If steering toggle pressed = 1 (calculated)(stops key bounce)
var key_press2 = 0;     // If throttle toggle pressed = 1 (calculated)(stops key bounce)
var lookup_torque = 0;  // Torque varies with rpm - calculated in physics routine
var Max_torq = 0;       // Maximum engine torque, in ft lbs (calculated only during car_init)
var Old_MyZ = 0;        // Saved previous Z height (calculated)
//var my = 0;
var my_floornormal;
var my_height = 0;
var my_movemode;
var my_type;
var my_speed_x;
var my_floorspeed;
var my_floorspeed_x=0;
var my_floorspeed_y=0;
var my_floornormal_x=0;
var my_floornormal_y=0;
var my_floornormal_z=0;
var my_dist = 0;
var my_height_passable;
//var my.ENABLE__TRIGGER;
var in_passable;
var on_passable;
var in_solid;
var movement_scale = 0;
var MODE_DRIVING = 0;
var Resistance = 0;     // Rolling resistance (Based on Drag value)(calculated)
var Road_Force = 0;     // Force being applied to the road (calculated)
var Rolling_Resistance=0; // Rolling resistance (Resistance and Speed) (calculated) 
var rpm = 0;            // Engine RPM (calculated)
var snd_stop;
var snd_tune;
var sneang = 0;         // Angle of the speedometer needle (calculated)
var steer_force = 0;      // Used instead of aforce.pan (calculated)
var steer_ratio = 0;    // Determines steering quickness, by speed (calculated)
var steer_speed=0;      // Used instead of aspeed.pan (calculated)
var steering = 0;       // steering force  -6 to +6 (calculated)
var Steering_Toggle=2;  // 0 = keyboard, 1 = Mouse, 2 = joystick (calculated)
var T_Eng_Resis = 0;    // Amount of engine resistance (calculated)
var T_brake = 0;        // Holds brake_torque with +/- sign (calculated)
var T_wheel = 0;        // Torque delivered to the drive wheel (calculated)
var Throttle_Toggle=2;  // 0 = keyboard, 1 = Mouse, 2 = joystick (calculated)
var Throttle = 0;       // Value -20 to +100 (accelerator -.2 to +1.0) (calculated)
var tneang = 0;         // Angle of the speedometer needle  (calculated)  
var Torq_Drive_Train=0; // Torq through the drive train  (calculated)
var Torq_Engine = 0;    // Amount of engine torque  (calculated)
var type_player = 0;
var Use_Gear = 7; //was 0      // Gear in use = gear - Down_Shift (forced)  (calculated)
var vec_scale;
var vecTo=0;
var vecFROM=0;
var Vert_Accel = 0;     // Car_Init will set to -Grav / Car_Weight (calculated)
var Vert_Dist = 0;      // Vertical distance traveled in one time period (calculated)
var Vert_Speed = 0;     // Vertical speed calculated from vertical distance moved
var vertical_speed = 0; // Vertical speed while climbing or descending a hill (calculated)  
var Was_Airborne = 0;   // If just finished being airborne, will be set to 1 
// The following variable holds how far the wheel travels in one rotation (calculated) 
var wheel_dist = 0;     // Wheel_radius * 2 * pi (in feet) (calculated)
var wheel_radius_feet = 0; // Wheel radius in feet  (calculated)
var path_nodepos = 0;

var time_elapsed = 0;
var highbeam = 0;
var latdev = 0;
var meanlatdev;
var scenariotime = 0;
var sumlatdev = 0;
var msL30 = 0;
var rmseL30 = 0;
var msL34 = 0;
var rmseL34 = 0;
var squaresL30 = 0;
var nsquaresL30 = 0;
var squaresL34 = 0;
var nsquaresL34 = 0;
var std1 = 0;
var std2 = 0;
var std3 = 0;
var std4 = 0;
var std5 = 0;
var std6 = 0;
var std7 = 0;
var std8 = 0;
var std9 = 0;
var std10 = 0;
var std11 = 0;
var std12 = 0;
var std13 = 0;
var std14 = 0;
var stdL34 = 0;

var startonce = 0;//used to prevent instruction at end of scenario
//var endonceL30 = 0;//prevent end scenario at beginning
//var endonceL28 = 0;//prevent end scenario at beginning

var verbalflag = 0;//default verbalize = 0
var alertsflag = 0;//default show; 1 = no show
var performflag = 0;//default show; 1 = no show
var instructionsflag = 0;//default show; 1 = no show
var getstartedflag = 0;//was 0
var startdemocount = 0;//0 = no demo; 1 = demo;
var failtostoponred = 0;
var rightturnonredOK = 0;//0=illegal;1=legal

var displaydistractflag = 1;// show distractor panel; 1 = hide distractor (default)

var noshowdistract1flag = 0;
var noshowdistract2flag = 0; //stop reshowing same msg in session if 1
var noshowdistract3flag = 0;
var noshowdistract4flag = 0; //stop reshowing same msg in session if 1
var noshowdistract5flag = 0;
var noshowdistract6flag = 0; //stop reshowing same msg in session if 1
var noshowdistract7flag = 0;
var noshowdistract8flag = 0; //stop reshowing same msg in session if 1
var noshowdistract9flag = 0;
var noshowdistract10flag = 0; //stop reshowing same msg in session if 1
var noshowdistract11flag = 0;
var noshowdistract12flag = 0; //stop reshowing same msg in session if 1
var noshowdistract13flag = 0;
var noshowdistract14flag = 0; //stop reshowing same msg in session if 1
var noshowdistract15flag = 0;
var noshowdistract16flag = 0; //stop reshowing same msg in session if 1
var noshowdistract17flag = 0;
var noshowdistract18flag = 0; //stop reshowing same msg in session if 1
var noshowdistract19flag = 0;
var noshowdistract20flag = 0; //stop reshowing same msg in session if 1
var noshowdistract21flag = 0;
var noshowdistract22flag = 0; //stop reshowing same msg in session if 1
var noshowdistract23flag = 0;
var noshowdistract24flag = 0; //stop reshowing same msg in session if 1
var noshowdistract25flag = 0;
var noshowdistract26flag = 0; //stop reshowing same msg in session if 1
var noshowdistract27flag = 0;
var noshowdistract28flag = 0; //stop reshowing same msg in session if 1
var noshowdistract29flag = 0;
var noshowdistract30flag = 0; //stop reshowing same msg in session if 1
var noshowdistract31flag = 0; //stop reshowing same msg in session if 1
var noshowdistract32flag = 0; //stop reshowing same msg in session if 1
var noshowdistract33flag = 0;
var noshowdistract34flag = 0; //stop reshowing same msg in session if 1
var noshowdistract35flag = 0;
var noshowdistract36flag = 0; //stop reshowing same msg in session if 1
var noshowdistract37flag = 0;
var noshowdistract38flag = 0; //stop reshowing same msg in session if 1
var noshowdistract39flag = 0;
var noshowdistract40flag = 0; //stop reshowing same msg in session if 1

// Function Protypes and Function List
// Major Functions
function car_init();            // Sets car parameters and initializes physics values
// In action loop:
function car_player_intentions(); // Gets Player inputs - throttle and steering
function car_steering();        // Calculates turning speed 
function car_physics();         // Calculates speed, vectors, acceleration, etc.
function car_scan_floor();		  // scan surface under ME entity, sets values
function car_move_gravity();	  // handle movement on solids
function collision_event();
// Helper Functions
function main_display_text();
//function lesson2_txt();
function Adjust_Screen();  // Adjust on-screen display if 800x600 or 640x480 (at init only)
function car_gear();       // Performs gear shifting functions
//function car_horn();       // Sounds the horn - needs horn_sound sound file
function car_motion();     // Sets car_indic - normal=0, braking=1, backing-up=2
function car_squeal();     // Sound of squealing tires - needs tire_squeal sound file
function car_toggle();     // Check toggles for steering and throttle input types
function check_brake();    // Check to see if we are (or should be) braking
function Drop_Hang();      // Saves "Hang & Drop" time - resets some variables
function drivereverse_toggle(); //toggles drive/revers when button pressed
function In_Air();         // Controls movement if we are in the air   
function On_Ground();      // Controls movement if we are on the ground 
function tune_esound();    // Tunes engine sound to RPM - needs engine sound file              
function update_views();   // Updates the picture in the rear-view mirror
function show_geardisp();  // Selects gear numbers for the Tachometer display
function show_hud();       // Shows the on-screen (HUD) displays (at init only)
function sneedle_roll();   // Sets the angle of the speedometer needle
function tneedle_roll();   // Sets the angle of the tachometer needle
function Ahead_View();	   // View through the windshield
function Tail_view();      // View from behind the vehicle
function Helo_View();      // Helicopter view, above and behind the vehicle
function Follow_View();    // Same as Helicopter view, but distance varies with speed
function Overhead_View();  // A satellite view, centered on the vehicle
function car_view();		   // Update Car Cam view
function cycle_car_view(); // Toggle selector function, to switch views
function show_turnsignals();  //Show turn signals
function show_brakelights();  // show brake lights
function clearInstructText();
function show_numcollisionsdisp(); // show number of collisions
function scanvehicles;
function scan_event;
function fullscreen_toggle; //toggles window F10
function windowed; //F12



//function varynightlevels();
function	autotransbuttSEL();
function	stantransbuttSEL();
function	passcarbuttSEL();
function truckbuttSEL();
function	closeselecttransveh(); //close button
function bounce_event;
function unselectalertswarns();
function selectalertswarns();
function selectperformmeasures();
function unselectperformmeasures();
function selectinstructions();
function unselectinstructions();
function selectscenariosumm();
function unselectscenariosumm();
function selectverbalize();
function unselectverbalize();
function closedisplayoptions();
function closeseldistractormsg();

function grab_screen();
function saveSUMMARY();
//function joyhat();

//DISTRACTOR
function hidedisplaydistract(); 
function showdisplaydistract();
function displaydistractmsg();//displays distractor msgs every 2 min
function closeseldistractormsg();



///////////////////////////////////////////////
//   Defines a rear view mirror              //
///////////////////////////////////////////////
//  Change the variables in this function    //
//  to re-size, or move the rear view mirror //
///////////////////////////////////////////////


VIEW camera2_view = //top rear view mirror
{
	pos_x = 862;  // was 662 x distance from upper left corner of screen
	pos_y = 20;    // y distance from top of screen
	size_x = 179; // x size of view window, in pixels
	size_y = 97; // y size of view window, in pixels,was 150
	arc = -80;
	layer = 1;
	//flags = VISIBLE; // Makes the view visible
}
VIEW camera3_view =//left rear view mirror
{
	pos_x = 19;  // x distance from upper left corner of screen
	pos_y = 485;    // y distance from top of screen
	size_x = 146; // x size of view window, in pixels
	size_y = 95; // y size of view window, in pixels,was 150
	arc = -60;
	layer = 1;
	//flags = VISIBLE; // Makes the view visible
}
VIEW camera4_view = //right rear view mirror
{
	pos_x = 1202;  // was 860 x distance from left corner of screen
	pos_y = 486;    // y distance from top of screen
	size_x = 147; // x size of view window, in pixels
	size_y = 94; // y size of view window, in pixels,was 150
	arc = -60;
	layer = 1;
	//flags = VISIBLE; // Makes the view visible
}
VIEW camera5_view =  //truck left rear view mirror
{
	pos_x = 13;//
	pos_y = 270;
	size_x = 100;//was 90
	size_y = 173;//was 170
	arc = -60;
	layer = 1;
}
VIEW camera6_view = //truck right rear view mirror
{
	pos_x = 917;//
	pos_y = 270;
	size_x = 100;
	size_y = 173;
	arc = -60;
	layer = 1;
	//flags = VISIBLE; // Makes the view visible
}
/////////////////////////////////////////////////////////////
// This function keeps the rear view mirror image updated  //
//  It Is called from the Player_Car action                //
///////////////////////////////////////////////////////////// 
 function update_views()//called by Player_Car loop
{
	camera2_view.genius = player;
	camera2_view.arc = -60;    // View is 80 degrees wide, and "mirrored"
	camera2_view.x = player.x; // Where rear-view mirror is located in the vehicle
	camera2_view.y = player.y - 19;
	camera2_view.z = player.z - 2; //was -4
	camera2_view.pan = player.pan - 180;  // Look behind
	camera2_view.roll = -player.roll;         
	camera2_view.tilt = -player.tilt +5;  // was +5 mirror tilt up(+) and down (-)
	
	camera3_view.x = player.x;
	camera3_view.y = player.y - 19;
	camera3_view.z = player.z - 2;//was -2
	camera3_view.genius = player;
	camera3_view.arc = -60;    // View is 80 degrees wide, and "mirrored"
	camera3_view.pan = player.pan -210;
	camera3_view.roll = -player.roll;
	camera3_view.tilt = -player.tilt +10;
	
	camera4_view.x = player.x;
	camera4_view.y = player.y - 19;
	camera4_view.z = player.z - 2;
	camera4_view.genius = player;
	camera4_view.arc = -60;    // View is 80 degrees wide, and "mirrored"
	camera4_view.pan = player.pan -150;
	camera4_view.roll = -player.roll;
	camera4_view.tilt = -player.tilt +10;
	
	camera5_view.x = player.x;
	camera5_view.y = player.y - 19;
	camera5_view.z = player.z - 2;
	camera5_view.genius = player;
	camera5_view.arc = -60;    // View is 80 degrees wide, and "mirrored"
	camera5_view.pan = player.pan -210;
	camera5_view.roll = -player.roll;
	camera5_view.tilt = -player.tilt +10;
	
	camera6_view.x = player.x;
	camera6_view.y = player.y - 19;
	camera6_view.z = player.z - 2;
	camera6_view.genius = player;
	camera6_view.arc = -60;    // View is 80 degrees wide, and "mirrored"
	camera6_view.pan = player.pan -150;
	camera6_view.roll = -player.roll;
	camera6_view.tilt = -player.tilt +10;
	
	//if(car_weight == 2600)
		//{
		//camera2_view.VISIBLE = ON; 
		//camera5_view.VISIBLE = OFF;
		//camera6_view.VISIBLE = OFF;
		//}
	//if(car_weight == 16000)
		//{
		//camera2_view.VISIBLE = OFF; 
		//camera5_view.VISIBLE = ON;
		//camera6_view.VISIBLE = ON;
		//}
  
}



//Below for driver info and vehicle/trans selection
//
PANEL displayG27G29SEL_pan =
{
	bmap = displayG27G29SEL_bmp;//
	pos_x = 533;//was 430 
	pos_y = 270;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  SHOW; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
//	on_click = hideG27G29();//click to unselect
}

PANEL displayG27G29UNSEL_pan =
{
	bmap = displayG27G29UNSEL_bmp;//
	pos_x = 533;     // 
	pos_y = 270;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  overlay; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	on_click = showG27G29();//click to show G29 selected
}

PANEL displayT150T300SEL_pan =
{
	bmap = displayT150T300SEL_bmp;//show distractor display selected
	pos_x = 533;     // was 430
	pos_y = 320;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  SHOW; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
//	on_click = hideT150T300();//click to unselect
}

PANEL displayT150T300UNSEL_pan =
{
	bmap = displayT150T300UNSEL_bmp;//show verbalize UNselected
	pos_x = 533;     // 
	pos_y = 320;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  overlay; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	on_click = showT150T300();//click to show T150 selected
}
PANEL displayTMXTMXProSEL_pan =
{
	bmap = displayTMXTMXproSEL_bmp;//show display selected
	pos_x = 533;     // was 430
	pos_y = 370;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  SHOW; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	//on_click = hideTMXTMXPro();//click to unselect
}

PANEL displayTMXTMXProUNSEL_pan =
{
	bmap = displayTMXTMXProUNSEL_bmp;//show UNselected
	pos_x = 533;     // 
	pos_y = 370;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  overlay; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	on_click = showTMXTMXPro();//click to show TMX sel
}

PANEL selectwheelpedalset_pan =
		{
		pos_x = 508;
		pos_y = 200;
		layer = 5;
		bmap = selectwheelpedalset_bmp;//dialog
		}

PANEL  closewheelpedalset_pan =
		{
			bmap = closewheelpedalset_bmp;
			pos_x = 645;// 
			pos_y = 420;   // 
			scale_y = 1.0;
			scale_x = 1.0;
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 6;//was 11
			on_click = closewheelpedalset();//button
		}

PANEL drivernamedisp =
	{
		pos_x = 875;     // was 575
		pos_y = 555;   // Use 4 and 600 for 1024
		
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
		flags = overlay; // set flags
		layer = 3;
		digits(20,20,"%.0f",panel_font,1,drivername_str);
		//bmp = driverinfo_bmp;
		//window = 0, 0, 20, 20, gears, gear_pos.x, gear_pos.y;
		}
		
PANEL selecttransveh_pan =
		{
			bmap = seltransveh;
			pos_x = 623;// was 423
			pos_y = 290;// was 190
			scale_y = 1.0;
			scale_x = 1.0;
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 3;
		}
PANEL seldisplayoptions_pan =
		{
			bmap = seldisplayoptions_bmp;
			pos_x = 514;// was 423
			pos_y = 150;//was 190 
			scale_y = 1.0;
			scale_x = 1.0;
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 3;
		}	
PANEL alertswarnsSEL_pan =
		{
			bmap = alertswarnsSEL_bmp;
			pos_x = 538;//was 448 
			pos_y = 240;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			//flags = VISIBLE;
			on_click = unselectalertswarns();
		}	
PANEL alertswarnsUNSEL_pan =
		{
			bmap = alertswarnsUNSEL_bmp;
			pos_x = 538;     // 
			pos_y = 240;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = selectalertswarns();
		}
PANEL performmeasuresSEL_pan =
		{
			bmap = performmeasuresSEL_bmp;
			pos_x = 538;     // 
			pos_y = 280;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = unselectperformmeasures();
		}
PANEL performmeasuresUNSEL_pan =
		{
			bmap = performmeasuresUNSEL_bmp;
			pos_x = 538;     // 
			pos_y = 280;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = selectperformmeasures();
		}
PANEL instructionsSEL_pan =
		{
			bmap = instructionsSEL_bmp;
			pos_x = 538;     // 
			pos_y = 320;   // 
			scale_y = 1.0;
			scale_x = 1.0;
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = unselectinstructions();
		}
PANEL instructionsUNSEL_pan =
		{
			bmap = instructionsUNSEL_bmp;
			pos_x = 538;     // 
			pos_y = 320;   // 
			scale_y = 1.0;
			scale_x = 1.0;
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = selectinstructions();//click to select instructions
		}
PANEL scenariosummSEL_pan =
		{
			bmap = scenariosummSEL_bmp;
			pos_x = 538;     // 
			pos_y = 360;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = unselectscenariosumm();//click to unselect summary
		}
PANEL scenariosummUNSEL_pan =
		{
			bmap = scenariosummUNSEL_bmp;
			pos_x = 538;     // 
			pos_y = 360;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 11;
			on_click = selectscenariosumm();//click to select scenario summary
		}
PANEL verbalizeUNSEL_pan =
		{
			bmap = verbalizeUNSEL_bmap;//show verbalize UNselected
			pos_x = 538;     // 
			pos_y = 400;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = selectverbalize();//click to select verbalize
		}
PANEL verbalizeSEL_pan =
		{
			bmap = verbalizeSEL_bmap;//show verbalize selected
			pos_x = 538;     // 
			pos_y = 400;   // 
			scale_y = 1.0;
			scale_x = 1.0;
			//flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = unselectverbalize();//click to unselect verbalize
		}
		
PANEL displayDistractSEL_pan =
{
	bmap = displayDistractSEL_bmp;//show distractor display selected
	pos_x = 538;     // 
	pos_y = 440;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  SHOW; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	on_click = hidedisplaydistract();//click to unselect
}

PANEL displayDistractUNSEL_pan =
{
	bmap = displayDistractUNSEL_bmp;//show verbalize UNselected
	pos_x = 538;     // 
	pos_y = 440;   // 
	scale_y = 1.0;
	scale_x = 1.0;
	//flags =  overlay; //set flags  was refresh, d3d, overlay;
	layer = 5;//was 11
	on_click = showdisplaydistract();//click to show dispaly selected
}

PANEL  closedisplayoptions_pan =
		{
			bmap = closedisplayoptions_bmp;
			pos_x = 714;// was 618
			pos_y = 515;   // 
			scale_y = 1.0;
			scale_x = 1.0;
		//	flags =  overlay; //set flags  was refresh, d3d, overlay;
			layer = 5;//was 11
			on_click = closedisplayoptions();
		}
	
PANEL stantransbuttSEL_pan = //SELECTED STAN TRANS BUTTON
 	{
 	pos_x = 585;
 	pos_y = 310;
	layer = 11;
	bmap = stantransbuttonSEL; //standard trans selected button
	}
	
PANEL stantransbuttUNSEL_pan = //UNSELECTED STAN TRANS BUTTON
 	{
 	pos_x = 585;
 	pos_y = 310;
	layer = 11;
	//flags = overlay;
	bmap = stantransbuttonUNSEL; //standard trans selected button
	on_click = stantransbuttSEL(); //SELECT THE BUTTON
	}
PANEL autotransbuttSEL_pan =
 	{
 	pos_x = 445;
 	pos_y = 310;
	layer = 11;
	//flags = overlay;
	bmap = autotransbuttonSEL; //standard trans selected button
	//on_click = autotransbuttSEL();
	}
PANEL autotransbuttUNSEL_pan =
 	{
 	pos_x = 445;
 	pos_y = 310;
	layer = 11;
	//flags = overlay;
	bmap = autotransbuttonUNSEL; //standard trans selected button
	on_click = autotransbuttSEL(); //SELECT THE BUTTON
	}
PANEL passcarbuttSEL_pan =
	{
 	pos_x = 445;
 	pos_y = 386;
	layer = 11;
	//flags = overlay;
	bmap = passcarbuttonSEL; //standard trans selected button
	//on_click = 
	}
PANEL	passcarbuttUNSEL_pan = //UNSELECTED PASS CAR BUTTON
	{
 	pos_x = 445;
 	pos_y = 386;
	layer = 11;
	//flags = overlay;
	bmap = passcarbuttonUNSEL; //standard trans selected button
	on_click = passcarbuttSEL();	
	}
PANEL	truckbuttSEL_pan =
	{
 	pos_x = 585;
 	pos_y = 386;
	layer = 11;
	//flags = overlay;
	bmap = truckbuttonSEL; //standard trans selected button
	//on_click = truckbuttSEL();	
	}
PANEL	truckbuttUNSEL_pan =
	{
 	pos_x = 585;
 	pos_y = 386;
	layer = 11;
	//flags = overlay;
	bmap = truckbuttonUNSEL; //standard trans selected button
	on_click = truckbuttSEL();	
	}
PANEL closeseltransveh_pan =
 	{
 	pos_x = 607;
 	pos_y = 435;
	layer = 11;
	//flags = overlay;
	bmap = closeselecttransveh_bmp; //standard trans selected button
	on_click = closeselecttransveh();
	}
	

	STRING depressclutch_str = "Accelerate, Depress Clutch Pedal or Put Shifter in Neutral";
		
	TEXT depressclutch_txt =
		{
		pos_x = 350; //was 380
		pos_y = 280;//was 200
		scale_x = 1.0;
		scale_y = 1.0;
		font = big20_font;
		string (depressclutch_str); //press clutch pedal
		}
		
	//below is for DEMO
	
STRING daysremain9_str = "You have 9 Simulator Starts Remaining";
STRING daysremain8_str = "You have 8 Simulator Starts Remaining";
STRING daysremain7_str = "You have 7 Simulator Starts Remaining";
STRING daysremain6_str = "You have 6 Simulator Starts Remaining";
STRING daysremain5_str = "You have 5 Simulator Starts Remaining";
STRING daysremain4_str = "You have 4 Simulator Starts Remaining";
STRING daysremain3_str = "You have 3 Simulator Starts Remaining";
STRING daysremain2_str = "You have 2 Simulator Starts Remaining";
STRING daysremain1_str = "You have 1 Simulator Start Remaining";
STRING daysremain0_str = "You have 0 Simulator Starts Remaining";
STRING daysremainNO_str = "You have No Evaluation Time Remaining - EXITING";


//STRING idnumber_str = "    ";
STRING text_str = ".txt";
STRING dummyname_str;
STRING drivername_str ="           "; // long empty string 11

//DISTRACTOR

STRING distractTorF_str = "Ans. True or False";
STRING distractorans_str = "               ";
STRING distract1_str = 
"How old are you (yrs)?";
STRING distract2_str = 
"In what year did you or
will you receive your 
driver's license?";
STRING distract3_str = 
"What is the city of your 
birth?";
STRING distract4_str = 
"Have you had a traffic 
accident in the past two 
years?";
STRING distract5_str = 
"Two solid lines in the 
middle of the road means 
that no vehicles may pass";//ans true
STRING distract6_str =
"It is illegal for a 
person to drive with 
a blood alcohol level 
of 4 hundredths of a 
percent or higher.";//ans = false
STRING distract7_str =
"A flashing yellow 
signal means you 
should stop then 
yield to cross 
traffic.";//false
STRING distract8_str =
"To see vehicles in 
your blind spot, 
look over your
shoulder.";//ans =t
STRING distract9_str =
"A solid yellow 
median line in 
your lane means 
you cannot pass.";//ans = t
STRING distract10_str =
"If a traffic signal 
light is not working,
you should stop then 
yield to cross traffic";//ans = t
STRING distract11_str =
"When passing another 
vehicle it is safe to 
return to your lane if 
you see the vehicle's
headlights in your 
rear view mirror.";//ans =f
STRING distract12_str =
"A flashing red light
at an intersection means
stop and wait for the 
green light";//ans = f
STRING distract13_str = 
"When you are merging on
to the freeway, you should
be driving at or near the 
same speed as the traffic 
on the freeway.";//ans = t
STRING distract14_str =
"When parking your 
vehicle parallel to 
the curb on a level 
street your wheels 
must be within 18 
inches of the curb.";//ans =t
STRING distract15_str =
"If you have a green
light, but traffic is 
blocking the 
intersection enter the 
intersection and wait 
until traffic clears.";//ans = f
STRING distract16_str =
"You may drive off of a 
paved roadway to pass 
another vehicle if the 
shoulder is wide enough.";//ans. = f
STRING distract17_str =
"It is always illegal 
to park your vehicle 
in a bike lane.";//ans = f
STRING distract18_str =
"You can be given a 
speeding ticket if 
the road or weather
conditions require a 
slower speed.";//ans = t
STRING distract19_str =
"Before changing lanes, 
you should check your 
mirror and slow down";//ans = f
STRING distract20_str = 
"You may not go around or 
under a railroad crossing 
gate under any 
circumstances";//ans = t
STRING distract21_str =
"It is against the law 
to enter an intersection
when the light is yellow";//ans = f
STRING distract22_str =
"It is never legal to text
and drive";//ans =t
STRING distract23_str =
"You must honk your horn
before passing a bicyclist
on the roadway";//ans = f
STRING distract24_str =
"When parking downhill 
next to a curb, turn 
your front wheels into 
the curb";//ans = t
STRING distract25_str = 
"Decreasing your 
following distance 
will help you avoid
being hit from behind.";//and = f
STRING distract26_str =
"Roadways are the 
most slippery the 
first rain after a 
dry spell";//ans = t
STRING distract27_str =
"When passing another 
vehicle, you should 
assume they will 
maintain a constant 
speed";//ans = t
STRING distract28_str =
"You may not park your
vehicle next to a red 
painted curb.";//ans = t
STRING distract29_str =
"Unless otherwise 
posted, the speed 
limit in a 
residential area 
is 25 mph.";//ans = t
STRING distract30_str = 
"On a green arrow, 
you must yield to 
any vehicle, or 
pedestrians in the 
intersection.";//ans = t
STRING distract31_str = 
"A school bus ahead 
of you in your lane 
is stopped with red 
lights flashing.Stop 
as long as the red
lights are flashing.";//ans =t
STRING distract32_str = 
"You may drive in a 
bike lane whenever 
bicyclists are not 
present";//ans =t
STRING distract33_str =
"Driving under the
influence of 
medications
which impair your 
driving is never 
permitted.";//ans = t
STRING distract34_str =
"Diving too close to the
rear bumber of another
vehicle can result in a
traffic violation.";//ans = t
STRING distract35_str =
"A solid yellow line 
next to a broken line 
means that vehicles 
next to the broken line 
may not pass.";//ans =f
STRING distract36_str =
"When driving in fog,
you should use your
high beams.";//ans = f

STRING distract37_str =
"If you see orange
construction cones in
a roadway you must be
prepared for workers
and equipment ahead.";//ans = t

STRING distract38_str =
"U-turns in residential
districts are legal
across two sets of
yellow lines.";//ans =f

STRING distract39_str =
"You must obey
instructions from a
school crossing guard
at all times.";//ans = t

STRING distract40_str =
"It is illegal to park
your vehicle in a
bike lane.";//ans =f 

TEXT daysremaining9_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain9_str);
		}
TEXT daysremaining8_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain8_str);
		}	
TEXT daysremaining7_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain7_str);
		}
TEXT daysremaining6_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain6_str);
		}
TEXT daysremaining5_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain5_str);
		}
TEXT daysremaining4_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain4_str);
		}
TEXT daysremaining3_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain3_str);
		}
TEXT daysremaining2_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain2_str);
		}
TEXT daysremaining1_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain1_str);
		}
TEXT daysremaining0_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremain0_str);
		}	
TEXT daysremainingNO_txt =
		{
			pos_x = 400; //was 570
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (daysremainNO_str);
		}		
//

TEXT distractTorF_txt =
	{
		pos_x = 905;//was 730
		pos_y = 695;
		layer = 6;
		font = distract_font;
		string (distractTorF_str);//ans True or False
	}	
TEXT distractorans_txt =  //text object for inkey entry
{
	
	pos_x = 905; //was 710 displays distract text
	pos_y = 725; //was 480
	scale_x = 1.0; //1.0;
	scale_y = 1.0;
	font = distract_font;
	string (distractorans_str);
	layer = 6;
	
}	
TEXT distract1_txt =
		{
			pos_x = 905;//was 710
			pos_y = 605;//was 625
			layer = 6;
			font = distract_font;
			string (distract1_str);
		}
		
TEXT distract2_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract2_str);
		}
		
TEXT distract3_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract3_str);
		}
		
TEXT distract4_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract4_str);
		}
TEXT distract5_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract5_str);
		}		
TEXT distract6_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract6_str);
		}	
TEXT distract7_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract7_str);
		}
TEXT distract8_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract8_str);
		}	
TEXT distract9_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract9_str);
		}
TEXT distract10_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract10_str);
		}	
TEXT distract11_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract11_str);
		}	
TEXT distract12_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract12_str);
		}
TEXT distract13_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract13_str);
		}	
TEXT distract14_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract14_str);
		}	
TEXT distract15_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract15_str);
		}			
TEXT distract16_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract16_str);
		}	
TEXT distract17_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract17_str);
		}			
TEXT distract18_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract18_str);
		}
TEXT distract19_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract19_str);
		}
TEXT distract20_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract20_str);
		}
TEXT distract21_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract21_str);
		}
TEXT distract22_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract22_str);
		}	
TEXT distract23_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract23_str);
		}
TEXT distract24_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract24_str);
		}
TEXT distract25_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract25_str);
		}	
TEXT distract26_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract26_str);
		}
TEXT distract27_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract27_str);
		}
TEXT distract28_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract28_str);
		}
TEXT distract29_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract29_str);
		}
TEXT distract30_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract30_str);
		}	
TEXT distract31_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract31_str);
		}	
TEXT distract32_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract32_str);
		}
TEXT distract33_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract33_str);
		}	
TEXT distract34_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract34_str);
		}
TEXT distract35_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract35_str);
		}
TEXT distract36_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract36_str);
		}
TEXT distract37_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract37_str);
		}	
TEXT distract38_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract38_str);
		}
TEXT distract39_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract39_str);
		}
TEXT distract40_txt =
		{
			pos_x = 905;
			pos_y = 605;
			layer = 6;
			font = distract_font;
			string (distract40_str);
		}	
	
//////////////////////////////////////  
//  This function sounds the horn  
//  Can be either joystick button 3
//  or keyboard key "H"            
//  (These can be reassigned)
//////////////////////////////////////

/*function car_horn
{
	while(1)  // Repeat forever
	{ 
		
		if (snd_playing(Horn_handle)==0)//joy_buttons & 1024 for g27
			{
			Horn_handle = snd_loop (horn_sound, 100, 0);
			}
		else 
			{
				if(snd_playing(Horn_handle)) //buttons & 1024joy_4==0
				{snd_stop(Horn_handle);}
			}
		wait(1);
	}
}  
*/
//Functions for wheel/pedal select
//
/*function hideG27G29()//on-click button shows UNSEL for G29 NO set select
{
{
	displayG27G29SEL_pan.VISIBLE = OFF;//hide select  button
	displayG27G29UNSEL_pan.VISIBLE = ON;//show unsel  button
	displayT150T300SEL_pan.VISIBLE = OFF;//hide select  button
	displayT150T300UNSEL_pan.VISIBLE = ON;//show unsel  button
	displayTMXTMXProUNSEL_pan.VISIBLE = ON;//show unsel button
	displayTMXTMXProSEL_pan.VISIBLE = OFF;//show unsel button
	displayG27G29flag = 0;//set flag not show(default setting)
	displayT150T300flag = 0;
	displayTMXTMXProflag = 0;
}
*/
function showG27G29()//on-click button displayG27G29UNSEL_pan button
{
	displayG27G29UNSEL_pan.VISIBLE = OFF;//hide unselect  button
	displayG27G29SEL_pan.VISIBLE = ON;//show selected  button
	displayT150T300SEL_pan.VISIBLE = OFF;//hide select  button
	displayT150T300UNSEL_pan.VISIBLE = ON;//show unsel  button
	displayTMXTMXProUNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayTMXTMXProSEL_pan.VISIBLE = OFF;//show unsel button
	displayG27G29flag = 1;//set flag for Logitech (default setting is 1)
	displayT150T300flag = 0;
	displayTMXTMXProflag = 0;
}
/*function hideT150T300()//on-click button hideT150T300select_pan button NO set select
{
	displayT150T300SEL_pan.VISIBLE = OFF;//hide select distract button
	displayT150T300UNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayTMXTMXProUNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayG27G29UNSEL_pan.VISIBLE = ON;//hide unselect distract button
	displayG27G29SEL_pan.VISIBLE = OFF;//show selected dis button
	displayT150T300flag = 0;//set flag not show(default setting)
	displayG27G29flag = 0;
	displayTMXTMXProflag = 0;
}
*/
function showT150T300()//on-click button deselect unsel and showT150T300select_pan button
{
	displayT150T300SEL_pan.VISIBLE = ON;//hide select distract button
	displayT150T300UNSEL_pan.VISIBLE = OFF;//show unsel distract button
	displayTMXTMXProUNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayTMXTMXProSEL_pan.VISIBLE = OFF;//hide select distract button
	displayG27G29UNSEL_pan.VISIBLE = ON;//hide unselect distract button
	displayG27G29SEL_pan.VISIBLE = OFF;//show selected dis button
	displayG27G29flag = 0;
	displayT150T300flag = 1;//set flag for Thrustmaster
	displayTMXTMXProflag = 0;//set flag not show(default setting)
}
/*
function hideTMXTMXPro()//on-click button hideTMXTMXPro select_pan button NO set selected
{
	displayT150T300SEL_pan.VISIBLE = OFF;//hide select distract button
	displayT150T300UNSEL_pan.VISIBLE = ON;//show unsel distract button	
	displayTMXTMXProSEL_pan.VISIBLE = OFF;//hide select distract button
	displayTMXTMXProUNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayG27G29UNSEL_pan.VISIBLE = OFF;//hide unselect distract button
	displayG27G29SEL_pan.VISIBLE = ON;//show selected dis button
	displayTMXTMXProflag = 0;//set flag not show(default setting)
	displayG27G29flag = 0;
	displayT150T300flag = 0;//set flag for Thrustmaster
	
}
*/
function showTMXTMXPro()//on-click unsel button showTMXTMXPro select_pan button
{
	displayTMXTMXProSEL_pan.VISIBLE = ON;//hide select distract button
	displayTMXTMXProUNSEL_pan.VISIBLE = OFF;//show unsel distract button
	displayT150T300SEL_pan.VISIBLE = OFF;//hide select distract button
	displayT150T300UNSEL_pan.VISIBLE = ON;//show unsel distract button
	displayG27G29SEL_pan.VISIBLE = OFF;//show selected dis button
	displayG27G29UNSEL_pan.VISIBLE = ON;//hide unselect distract button
	displayT150T300flag = 0;//set flag not show(default setting)
	displayG27G29flag = 0;
	displayTMXTMXProflag = 1;
}
function closewheelpedalset()//button closes wheel/pedal set dialog
{
	selectwheelpedalset_pan.VISIBLE = OFF;//hide dialog
	displayG27G29SEL_pan.VISIBLE = OFF;
	displayG27G29UNSEL_pan.VISIBLE = OFF;
	displayT150T300SEL_pan.VISIBLE = OFF;
	displayT150T300UNSEL_pan.VISIBLE = OFF;
	displayTMXTMXProSEL_pan.VISIBLE = OFF;//hide select distract button
	displayTMXTMXProUNSEL_pan.VISIBLE = OFF;//show unsel distract button
	closewheelpedalset_pan.VISIBLE = OFF;//hide close button
	
}
//////////////////////////////////////////////////////
/// Test for tire squeal, due to car acceleration, or sharp turns
//  NOTE:  When to squeal, is arbitrary, based on the value of "car_accel", and
//   the "A_Chirp" (Acceleration) and "T_Chirp" (Turning force) variables.  These
//   can be set to different levels, in "Other table values you can adjust",
//     near the beginning of this script.
//   The squeal indicates a power loss due to tires losing traction with the road.
//   Losing traction because of acceleration tire slip, is not implemented. 
//   Power loss due to turning, is implemented.   
//
function car_squeal()//called once by car_init
{
	while(1)  // Repeat forever
	{ 
		if(( (abs(car_accel) > A_Chirp) || (abs(Corner_Squeal) > T_Chirp))&& (snd_playing(Squeal_handle) == 0) )
		{
			Squeal_handle = snd_play (tire_squeal, 40, 0);
		}
		else 
		{
			if( (abs(car_accel) <= A_Chirp ) && (abs(Corner_Squeal) <= T_Chirp) ){snd_stop(Squeal_handle);}
		}
		wait(1);
	}
}  
////////////////////////////////////
//       Check car motion         //
////////////////////////////////////
// Sets car indicator "car_indic" //
//  0 = normal forward motion     //
//  1 = brakes are being applied  //
//  2 = backing up                //
////////////////////////////////////
function car_motion()
{
	if ( (abs(accelerator) > 0.03) && ( car_velocity >= 1) ) {car_indic = 0;} // NOT braking
	//else {car_indic = 1;}  // We are braking
	if ( ( accelerator <= 0.03) && ( car_velocity > 1) ) {car_indic = 1;} // Braking
	if ( brakepedal < 0){car_indic = 1;} //Braking

	if ( ( accelerator <= -0.03) && ( car_velocity <= 0) ) {car_indic = 2;} // Backing up
}
///
//SELECT AUTOMATIC TRANSMISSION
//
function	autotransbuttSEL() //click on UNselected auto trans button
{
	autotransbuttSEL_pan.VISIBLE = ON;//show selected auto trans button
	autotransbuttUNSEL_pan.VISIBLE = OFF;//hide unselected auto trans button
	stantransbuttSEL_pan.VISIBLE = OFF; //hide selected stan trans button
	stantransbuttUNSEL_pan.VISIBLE = ON; //show UNselected stan trans button
	num_gears = 6;
	Use_gear  = 1; //
	stantrans = 0; //set var to auto trans
}
//
//SELECT STANDARD TRANSMISSION
//

function	stantransbuttSEL()//click on UNSELected stan trans button
{
	stantransbuttUNSEL_pan.VISIBLE = OFF; //hide unselected stan trans button
	stantransbuttSEL_pan.VISIBLE = ON; //show selected stan trans button
	autotransbuttSEL_pan.VISIBLE = OFF; //hide selected auto trans button
	autotransbuttUNSEL_pan.VISIBLE = ON; //show UNselected auto trans button
	stantrans = 1; //set to standard trans
	num_gears = 6; //6 forward
	Use_Gear = 7; //set use gear to neutral
}
//
//SELECT PASSENGER CAR
//
function	passcarbuttSEL() //select pass car,click on Unselected passcar button
{
	passcarbuttSEL_pan.VISIBLE = ON; //show selected pass car button
	passcarbuttUNSEL_pan.VISIBLE = OFF; //hide UNselected pass car button
	truckbuttSEL_pan.VISIBLE = OFF; //hide selected truck button
	truckbuttUNSEL_pan.VISIBLE = ON; //show  UNselected truck button
	camera2_view.pos_x = 662;//top rearview mirror
	camera2_view.pos_y = 20;
	camera2_view.size_x = 179;
	camera2_view.size_y = 97;
	camera5_view.VISIBLE = OFF;
	camera6_view.VISIBLE = OFF;
	Brake_Torque = 75000;   //was 100000 Stopping force (arbitrary number)
	Car_Weight = 2600;       // Total car weight, in pounds  
	differential_ratio = 2.73; // Ratio of the differential gear  
	Drag = 0.35;             // Air friction (A Corvette is 0.29)
	gear_efficiency = 0.8;   // Overall gear efficiency
	Horse_power = 160;       // Rated enigne horsepower - will be converted to Max_Torq  
	num_gears = 6; //was 6          // Number of forward gears (at least 1, but no more than 6)
// Specify actual gear ratios in the Car_Init() function (near the end of this script)
	wheel_radius_inch = 15.0; // Wheel radius, in inches
	Acel_Val = 5.0;     // Acceleration value - increase to accelerate slower
}
//
//SELECT TRUCK
//
function truckbuttSEL()//click on UNselected truck button
{
	truckbuttSEL_pan.VISIBLE = ON;//show selected truck button
	truckbuttUNSEL_pan.VISIBLE = OFF; //hide  UNselected truck button
	passcarbuttSEL_pan.VISIBLE = OFF; //hide selected pass car button
	passcarbuttUNSEL_pan.VISIBLE = ON; //show UNselected pass car button
	camera2_view.VISIBLE = OFF;
	camera3_view.VISIBLE = OFF;
	camera4_view.VISIBLE = OFF;
	camera5_view.VISIBLE = ON;
	camera6_view.VISIBLE = ON;
	
	Brake_Torque = 140000;   //was 100000 Stopping force (arbitrary number)
	Car_Weight = 16000;// 16000 Total car weight, in pounds 
	differential_ratio = 4.33; // was 3.33, Ratio of the differential gear  
	Drag = 0.35;             // Air friction (A Corvettte is 0.29)
	gear_efficiency = 0.8;   // Overall gear efficiency
	Horse_power = 200; //was 180      // Rated engine horsepower - will be converted to Max_Torq  
	num_gears = 6; //was 6          // Number of forward gears (at least 1, but no more than 6)
// Specify actual gear ratios in the Car_Init() function (near the end of this script)
	wheel_radius_inch = 15.0; // Wheel radius, in inches
	A_Chirp = 0.2;      // Amount of acceleration to cause tire squeal, or "chirp"
	Acel_Val = 3.0 ;   //was 5.0  // Acceleration value - increase to accelerate slower
}

function	closeselecttransveh() //close button
{
	selecttransveh_pan.VISIBLE = OFF; //close seltrabsveh panel
	autotransbuttSEL_pan.VISIBLE = OFF;
	autotransbuttUNSEL_pan.VISIBLE = OFF;
	stantransbuttSEL_pan.VISIBLE  = OFF;
	stantransbuttUNSEL_pan.VISIBLE  = OFF;
	passcarbuttSEL_pan.VISIBLE = OFF;
	passcarbuttUNSEL_pan.VISIBLE = OFF;
	truckbuttSEL_pan.VISIBLE = OFF;
	truckbuttUNSEL_pan.VISIBLE = OFF;
	closeseltransveh_pan.VISIBLE = OFF;
	mouse_pointer = 0;
	mouse_mode = 0;
	freeze_mode = 0;

	
} 
function closefullscreendialog()
{
	fullscreenviewing_pan.VISIBLE = OFF;
	closefullscreen_pan.VISIBLE = OFF;
}

function selectalertswarns()//on-click show alerts
{
	alertswarnsUNSEL_pan.VISIBLE = OFF;
	alertswarnsSEL_pan.VISIBLE = ON;
	alertsflag = 0;
}
function unselectalertswarns()//on-click do not show alerts
{
	alertswarnsSEL_pan.VISIBLE = OFF;
	alertswarnsUNSEL_pan.VISIBLE = ON;
	alertsflag = 1;
}
function selectperformmeasures()//on-click show perform
{
	performmeasuresUNSEL_pan.VISIBLE = OFF;
	performmeasuresSEL_pan.VISIBLE = ON;
	performflag = 0;
}
function unselectperformmeasures()//on-click do not show perform
{
	performmeasuresSEL_pan.VISIBLE = OFF;
	performmeasuresUNSEL_pan.VISIBLE = ON;
	performflag = 1;
}
function selectinstructions()//on-click show instruction
{
	instructionsUNSEL_pan.VISIBLE = OFF;
	instructionsSEL_pan.VISIBLE = ON;
	instructionsflag = 0;
}
function unselectinstructions()//on-click do not show instruction
{
	instructionsSEL_pan.VISIBLE = OFF;
	instructionsUNSEL_pan.VISIBLE = ON;
	instructionsflag = 1;
}
function selectscenariosumm()//on-click show scenario summ
{
	scenariosummUNSEL_pan.VISIBLE = OFF;
	scenariosummSEL_pan.VISIBLE = ON;
	scenariosummflag = 0;
}
function unselectscenariosumm()//on-click do not show instruction
{
	scenariosummSEL_pan.VISIBLE = OFF;
	scenariosummUNSEL_pan.VISIBLE = ON;
	scenariosummflag = 1;
}
function selectverbalize()//on-click verbalize
{
	verbalizeUNSEL_pan.VISIBLE = OFF;
	verbalizeSEL_pan.VISIBLE = ON;//show selected
	verbalflag = 0;//verbalize; default
}
function unselectverbalize()//on-click do not verbalize
{
	verbalizeSEL_pan.VISIBLE = OFF;
	verbalizeUNSEL_pan.VISIBLE = ON;
	verbalflag = 1;
}

function hidedisplaydistract()//on-click button displayDistrSEL_pan button
{
	displayDistractSEL_pan.VISIBLE = OFF;//hide select distract button
	displayDistractUNSEL_pan.VISIBLE = ON;//show unsel distract button
	displaydistractflag = 1;//do not show distractor panel (default setting)
}

function showdisplaydistract()//on-click button displayDistrUNSEL_pan
{
	displayDistractUNSEL_pan.VISIBLE = OFF;//hide unselect distract button
	displayDistractSEL_pan.VISIBLE = ON;//show selected display distractor button
	displaydistractflag = 0;//flag to show distractor panel(default setting is 1)
	
}

function closeseldistractormsg()//closes msg about text distractor
{
	seldistractormsg_pan.VISIBLE = OFF;
	closeseldistractormsg_pan.VISIBLE = OFF;//close button
}

function displaydistractmsg()	//display msgs called by Player_Car action
	{
		while(1)//loop until break condition 
		{
		if((distractDisplay_ent.VISIBLE == ON) && (seldistractormsg_pan.VISIBLE == OFF) && (Steering_Toggle == 2)) //need G27 flag 0 == show; default is 1, hide
			{
			break;
			}
		wait(-1);
		}		
				
					if(noshowdistract1flag == 0)//msg has not been seen yet,1 = else skip it
						{
						wait(-60);
						wait(-60);	
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						
						distract1_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract1_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;//was 625
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract1_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract1_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract1flag = 1;//skip this msgs in future
						}
						
					if(noshowdistract2flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract2_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract2_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract2_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract2_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract2flag = 1;
						}
						
						if(noshowdistract3flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract3_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract3_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract3_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract3_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract3flag = 1;
						}
						
						if(noshowdistract4flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract4_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract4_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract4_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract4_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract4flag = 1;
						}
						
						if(noshowdistract5flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distractTorF_txt.VISIBLE = ON;
						distract5_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract5_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract5_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract5_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract5flag = 1;
						}
						
						if(noshowdistract6flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract6_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract6_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract6_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract6_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract6flag = 1;
						}
						
						
						
						if(noshowdistract7flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract7_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract7_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract7_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract7_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract7flag = 1;
						}
					
						
						if(noshowdistract8flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract8_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract8_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract8_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract8_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract8flag = 1;
						}
			
						
						if(noshowdistract9flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract9_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract9_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract9_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract9_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract9flag = 1;
						}
						
						if(noshowdistract10flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract10_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract10_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract10_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract10_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract10flag = 1;
						}
						
						if(noshowdistract11flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract11_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract11_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract11_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract11_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract11flag = 1;
						}
						
						
						if(noshowdistract12flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract12_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract12_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract12_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract12_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract12flag = 1;
						}
						
						if(noshowdistract13flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract13_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract13_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract13_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract13_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract13flag = 1;
						}
						
						if(noshowdistract14flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract14_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract14_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract14_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract14_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract14flag = 1;
						}
						
						if(noshowdistract15flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract15_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract15_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract15_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract15_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract15flag = 1;
						}	

						
						if(noshowdistract16flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract16_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract16_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract16_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract16_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract16flag = 1;
						}
						
						
						if(noshowdistract17flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract17_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract17_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract17_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract17_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract17flag = 1;
						}
		
						
						if(noshowdistract18flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract18_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract18_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract18_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract18_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract18flag = 1;
						}
	
						
						if(noshowdistract19flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract19_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract19_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract19_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract19_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract19flag = 1;
						}
					
						
						if(noshowdistract20flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract20_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract20_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract20_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract20_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract20flag = 1;
						}	
						
						
						if(noshowdistract21flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract21_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract21_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract21_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract21_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract21flag = 1;
						}
					
						
						if(noshowdistract22flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract22_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract22_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract22_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract22_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract22flag = 1;
						}	
					
						
						if(noshowdistract23flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract23_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract23_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract23_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract23_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract23flag = 1;
						}
						
						
						if(noshowdistract24flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract24_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract24_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract24_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract24_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract24flag = 1;
						}	
	
						
						if(noshowdistract25flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract25_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract25_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract25_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract25_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract25flag = 1;
						}	
						
						
						if(noshowdistract26flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract26_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract26_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract26_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract26_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract26flag = 1;
						}		
						
						if(noshowdistract27flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract27_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract27_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract27_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract27_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract27flag = 1;
						}
						
						if(noshowdistract28flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract28_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract28_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract28_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract28_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract28flag = 1;
						}
						
						if(noshowdistract29flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract29_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract29_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract29_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract29_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract29flag = 1;
						}
						
						if(noshowdistract30flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract30_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract30_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract30_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract30_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract30flag = 1;
						}	
						
						if(noshowdistract31flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract31_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract31_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract31_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract31_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract31flag = 1;
						}	
						
						if(noshowdistract30flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract32_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract32_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract32_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract32_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract32flag = 1;
						}	
						
						
						if(noshowdistract33flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract33_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract33_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract33_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract33_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract33flag = 1;
						}
						
						if(noshowdistract34flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract34_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract34_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract34_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract34_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract34flag = 1;
						}		
	
						
						if(noshowdistract35flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract35_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract35_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract35_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract35_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract35flag = 1;
						}		
						
						if(noshowdistract36flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract36_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract36_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract36_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract36_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract36flag = 1;
						}	
						
						if(noshowdistract37flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract37_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract37_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract37_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract37_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract37flag = 1;
						}	
						
						if(noshowdistract38flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract38_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract38_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract38_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract38_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract38flag = 1;
						}			
		
						
						if(noshowdistract39flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract39_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract39_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract39_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract39_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract39flag = 1;
						}	

						
						if(noshowdistract40flag == 0)//msg has not been seen,else skip it
						{
						wait(-60);
						wait(-60);
						snd_stop(Msgs_handle);	
						instruction_handle = snd_play(distractortextmsg_wav,100,0);//chime
						distract40_txt.VISIBLE = ON;
						distractTorF_txt.VISIBLE = ON;
						distractorans_txt.VISIBLE = ON;//answer
						
						if(fullscreen == 1)//FULLSCREEN
						{
						distract40_txt.pos_y = 550;
						distractorans_txt.pos_y = 635;
						distractTorF_txt.pos_y = 625;
						} 
						if(fullscreen == 0)//WINDOWED
						{
						distract40_txt.pos_y = 605;
						distractorans_txt.pos_y = 715;
						}
						
						inkey(distractorans_str);
						str_cpy(distractorans_str,"                "); 
						distract40_txt.VISIBLE = OFF;
						distractTorF_txt.VISIBLE = OFF;
						distractorans_txt.VISIBLE = OFF;//answer
						noshowdistract40flag = 1;
						}	
					
		//end first conditional for distract display shown AND G27	
	

}//END OF FUNCTION Display distract msg


function closedisplayoptions()//on-click close display options
{
	closedisplayoptions_pan.VISIBLE = OFF;
	alertswarnsSEL_pan.VISIBLE = OFF;
	alertswarnsUNSEL_pan.VISIBLE = OFF;
	performmeasuresSEL_pan.VISIBLE = OFF;
	performmeasuresUNSEL_pan.VISIBLE = OFF;
	instructionsUNSEL_pan.VISIBLE = OFF;
	instructionsSEL_pan.VISIBLE = OFF;
	seldisplayoptions_pan.VISIBLE = OFF;
	scenariosummSEL_pan.VISIBLE = OFF;
	scenariosummUNSEL_pan.VISIBLE = OFF;
	verbalizeUNSEL_pan.VISIBLE = OFF;
	verbalizeSEL_pan.VISIBLE = OFF;
	displayDistractSEL_pan.VISIBLE = OFF;
	displayDistractUNSEL_pan.VISIBLE = OFF;
	if(displaydistractflag == 0)
		{
		seldistractormsg_pan.VISIBLE = ON;//show msg to user re distractor
		closeseldistractormsg_pan.VISIBLE = ON;//show close button
		freeze_mode = 1;//freeze sim
		}
	
	while(seldistractormsg_pan.VISIBLE == ON)// // move it over the screen
  			{ 
  			mouse_mode = 1;
    		MOUSE_POS.X = mouse_cursor.x;
    		MOUSE_POS.Y = mouse_cursor.y;
    		wait(1);
  			}
  	mouse_mode = 0;
  	freeze_mode = 0;
  			
	//open slect trans
		if(seldisplayoptions_pan.VISIBLE == OFF && selectEXM == 1 && seldistractormsg_pan.VISIBLE == OFF)
		{
	
			if(stantrans == 0) && (car_weight == 2600) //&& (int(joy_rot.x) > 0))
				{
				autotransbuttSEL_pan.VISIBLE = ON;
				autotransbuttUNSEL_pan.VISIBLE = OFF;
				stantransbuttSEL_pan.VISIBLE  = OFF;
				stantransbuttUNSEL_pan.VISIBLE  = ON;
				passcarbuttSEL_pan.VISIBLE = ON;
				passcarbuttUNSEL_pan.VISIBLE = OFF;
				truckbuttSEL_pan.VISIBLE = OFF;
				truckbuttUNSEL_pan.VISIBLE = ON;
				}
		if(stantrans == 1) && (car_weight == 2600) //&& (int(joy_rot.x) < 0))
				{
				autotransbuttSEL_pan.VISIBLE = OFF;
				autotransbuttUNSEL_pan.VISIBLE = ON;
				stantransbuttSEL_pan.VISIBLE  = ON;
				stantransbuttUNSEL_pan.VISIBLE  = OFF;
				passcarbuttSEL_pan.VISIBLE = ON;
				passcarbuttUNSEL_pan.VISIBLE = OFF;
				truckbuttSEL_pan.VISIBLE = OFF;
				truckbuttUNSEL_pan.VISIBLE = ON;
				}
		if(stantrans == 0) && (car_weight == 16000) //&& (int(joy_rot.x) < 0))
				{
				autotransbuttSEL_pan.VISIBLE = ON;
				autotransbuttUNSEL_pan.VISIBLE = OFF;
				stantransbuttSEL_pan.VISIBLE  = OFF;
				stantransbuttUNSEL_pan.VISIBLE  = ON;
				passcarbuttSEL_pan.VISIBLE = OFF;
				passcarbuttUNSEL_pan.VISIBLE = ON;
				truckbuttSEL_pan.VISIBLE = ON;
				truckbuttUNSEL_pan.VISIBLE = OFF;
				}
		if(stantrans == 1) && (car_weight == 16000)// && (int(joy_rot.x) < 0))
				{
				autotransbuttSEL_pan.VISIBLE = OFF;
				autotransbuttUNSEL_pan.VISIBLE = ON;
				stantransbuttSEL_pan.VISIBLE  = ON;
				stantransbuttUNSEL_pan.VISIBLE  = OFF;
				passcarbuttSEL_pan.VISIBLE = OFF;
				passcarbuttUNSEL_pan.VISIBLE = ON;
				truckbuttSEL_pan.VISIBLE = ON;
				truckbuttUNSEL_pan.VISIBLE = OFF;
				}
			selecttransveh_pan.VISIBLE = ON;
			closeseltransveh_pan.VISIBLE = ON;
		}
}

function closedrivsumm()//called by close button on drive summary
{
	closedrivsumm_pan.VISIBLE = OFF;
	drivsimsumm_pan.VISIBLE = OFF;
	savedrivsumm_pan.VISIBLE = OFF;
	toprearmirror_pan.VISIBLE = OFF;
}
function saveSUMMARY()//called by save button on Driver Summary dialog, all vars loaded
{
	wait(-.5);
						
						
						str_cpy(dummyname_str,"");
						str_cat(dummyname_str,filename_str);
						str_cat(dummyname_str,scenarioname_str);
						str_cat(dummyname_str,"SUMMARY");//bigmama1234L1..SUMMARY
						str_cat(dummyname_str,text_str);
						filehandle=file_open_append(dummyname_str);//summary_str);//dummy holds current file name
						
						file_str_write(filehandle,"Filename:  ");
						file_str_write(filehandle,dummyname_str);
						file_str_write(filehandle,"; ");
						//file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle,"Date: ");
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,"; ");
						//file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle,"Time: ");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"; ");
						//file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle,scenarioname_str);//e.g.,L19TrnFog
						
						file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle," ");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle," ");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle," Speed too Slow(sec.):");
						file_str_write(filehandle," ");
						file_var_write(filehandle,speedtooslow);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle,linefeed_str);
					
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle," ");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle," ");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,";");
						
						
						file_str_write(filehandle," MeanLatDevL30(ft.): ");
						file_str_write(filehandle," ");
						file_var_write(filehandle,meanlatdevL30);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle," MeanLatDevL30v2(ft.): ");
							file_str_write(filehandle," ");
						file_var_write(filehandle,meanlatdevL30v2);
							file_str_write(filehandle,"; ");
						file_str_write(filehandle," MeanLatDevL30v3(ft.): ");
							file_str_write(filehandle," ");
						file_var_write(filehandle,meanlatdevL30v3);
							file_str_write(filehandle,"; ");
							
						file_str_write(filehandle," Road Edge(sec.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,overroadedge);
						file_str_write(filehandle,"; ");
						file_str_write(filehandle," Median(sec.): ");
						file_str_write(filehandle," ");
						file_var_write(filehandle,overmedian);
						file_str_write(filehandle,"; ");
						
						file_str_write(filehandle," Brake RT(sec.): ");
						
						file_var_write(filehandle,brakeRT);
						file_str_write(filehandle,linefeed_str);
						file_str_write(filehandle,passingscores_str);
						
						file_str_write(filehandle,measuresdef_str);
						
					
						wait (-.3);  // wait 1 frame until the bitmap can be saved

  						savescreenmsg_pan.VISIBLE = ON;
  						wait(-3);
  						savescreenmsg_pan.VISIBLE = OFF;  //game_save (altscreen, 1, SV_BMAPS);
  						closedrivsumm_pan.VISIBLE = OFF;
						savedrivsumm_pan.VISIBLE = OFF;
						drivsimsumm_pan.VISIBLE = OFF;
						
						meanlatdevsumm = 0;
						str_cpy(dummyname_str,"");//clear string
						str_cpy(scenarioname_str,"");
						
}
function grab_screen() //called by save button on driver summary dialog
{
	level_load ("");
	wait(-.5);

	mouse_mode = 0;
	randomize();//seed random number
	screenfilenum = (random(100));
	str_cat(filename_str,scenarioname_str);//add scenarioname to drivername and id
	str_cpy(screenfile_str,filename_str);
  file_for_screen(screenfile_str,screenfilenum);  // saves a screenshot"C:\\BRSimData\\drivsummscreen.bmp"
  //bmap_for_screen (whitebackgrd_bmp, 1, 0);
  wait (-.5);  // wait 1 frame until the bitmap can be saved
  	
  savescreenmsg_pan.VISIBLE = ON;
  wait(-3);
  savescreenmsg_pan.VISIBLE = OFF;  //
  closedrivsumm_pan.VISIBLE = OFF;
  savedrivsumm_pan.VISIBLE = OFF;
  drivsimsumm_pan.VISIBLE = OFF;
}
//////////////////////////////////////////////////////////////////////////////////
//  Gear Shift Function car_gear()                                              //
// Upshift and Downshift RPM can be set in "Other table values you can adjust", //
//     near the beginning of this script.  This function also controls the      //
//     forced downshift, when the keyboard "Shift" key is pressed.              //
//////////////////////////////////////////////////////////////////////////////////
function car_gear()  //part of player loop
{
	
	//if((car_velocity == 0) && (joy_3 !=0)){gear = 0;} //put gear into reverse with button 3
		//else {gear = 1;}
	//if ((car_velocity == 0) && (drivereverse == 0)) {gear=1;}
	//if ( (car_indic == 2) || (car_velocity <= 0) && (joy_3 != 0) )
		//{gear = 0; throttle -= accelerator * car_tstrength;}  // Shift into reverse gear
		//else
		//{
			//gear = max(gear,1);  //  Shift out of reverse gear, if needed
			
			//Logitech G27 automatic
			//
	if (stantrans == 0) //automatic
		{
		if ((rpm < 1200) && (gear > 1) )  // DnShift
		 	{gear -= 1;} // Downshift if rpm is low
		else //upshift
		   {
				if (( gear < 2 ) && ( calc_rpm > UpShift)&&(Car_velocity >25)) //was 30//&& (key_shift == 0) ) // Don't upshift if top gear or forced downshift
			    	{
			    	gear += 1;
			    	Use_Gear = gear;//gear;  //was 4determines gear ratio used
					} // Upshift
				if (( gear < 3 ) && ( calc_rpm > UpShift)&&(Car_velocity >40)) //was 60//&& (key_shift == 0) ) // Don't upshift if top gear or forced downshift
			    	{
			    	gear += 1;
			    	Use_Gear = gear;
					} // Upshift 
				 if (( gear < 4 ) && ( calc_rpm > UpShift)&&(Car_velocity >60)) //was 85&& (key_shift == 0) ) // Don't upshift if top gear or forced downshift
			    	{
			    	gear += 1;
			    	Use_Gear = gear;
					}
				 if (( gear < 5 ) && ( calc_rpm > UpShift)&&(Car_velocity >80)) //was 100//&& (key_shift == 0) ) // Don't upshift if top gear or forced downshift
			    	{
			    	gear += 1;
			    	Use_Gear = gear;
					} 
				 if (( gear < 6 ) && ( calc_rpm > UpShift)&&(Car_velocity >100))
				 	{
			    	gear += 1;
			    	Use_Gear = gear;
					} 
		   }     
				//if (calc_rpm > UpShift ) {gear += 1;} // Delay if floored
				//else
				//{
			//  Check to see if the driver wants to force a downshift&& (Accelerator >= 0.9)
			if (gear > 1) // Make sure we are in a gear higher than number one+ 500
			{ 
			Use_Gear = gear;  // - (key_shift || mouse_left); // Sets gear to use - possible down shift
			}     // key_shift will = 1, if "Shift" key is pressed, OR the
			// left mouse button is pressed - otherwise it will be 0
			else 
			{ 
			Use_Gear = gear;  // Don't allow a down shift, even if "Shift" is pressed
			}
		  		
		}//end of stantrans=0 conditional
		  
	//Logitech G27 Manual
			
if (stantrans == 1) //standard trans selected
		{
				
			if(use_gear == 7 ) //use_gear at startup is 7,also if clutch depress
					{
					gear = 7;//default at start	
					geardisp.VISIBLE = OFF;
					}
			else
					{
					geardisp.VISIBLE = ON; //if shifter in gear display gear
					}
		
				/////////
				/////////Use clutch to set gear
				////////
			if(clutchpedal <= 70)//clutch not pressed
					{
					
					gear = 7;//set gear to neutral
					use_gear= gear;
					geardisp.VISIBLE = OFF;
					}
					
			 	if(clutchpedal <= 70) && 
			 		((joy_buttons & 4)||(joy_buttons & 8) 					///
					||(joy_buttons & 16)||(joy_buttons & 32)
					||(joy_buttons & 64)||(joy_buttons & 128)
					||(joy_buttons & 256)) //was joy_12 if in gear and clutch NOT pressed
			 	
			 		{
					clutchpedalin = 1; //set clutchpedalin var to 1 need clutch to  shift
					gear = 7;//set to neutral
					use_gear= gear;
					geardisp.VISIBLE = OFF;
					}
				
				if((clutchpedal > 70) && (joy_buttons & 4)  && (clutchpedalin == 1))//  )
					{
					gear = 1;//sets to First gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				
				if((clutchpedal > 70) && (joy_buttons & 8) && (clutchpedalin == 1))
					{
					gear = 2;//sets to Second gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				if((clutchpedal > 70) && (joy_buttons & 16) && (clutchpedalin == 1))//  )
					{
					gear = 3;//sets to  gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				if((clutchpedal > 70) && (joy_buttons & 32) && (clutchpedalin == 1))//
					{
					gear = 4;//sets to  gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				if((clutchpedal > 70) && (joy_buttons & 64) && (clutchpedalin == 1))
					{
					gear = 5;//sets to  gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	 
					}
				if((clutchpedal > 70) && (joy_buttons & 128) && (clutchpedalin == 1))
					{
					gear = 6;//sets to Sixth gear when clutch released
					Use_Gear = gear;
					drivereverse = 0;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				if((clutchpedal > 70) && (joy_buttons & 256) && (clutchpedalin == 1))
					{
					gear = 0;//sets to Reverse gear when clutch released
					Use_Gear = gear;
					drivereverse = 1;
					geardisp.VISIBLE = ON;
					clutchpedalin = 0;	
					}
				if((joy_buttons & 4 == 0) && (joy_buttons & 8 == 0) 					///
						&& (joy_buttons & 16 == 0)	&& (joy_buttons & 32 == 0)
						&& ((joy_buttons & 64) == 0)&& ((joy_buttons & 128) == 0)
						&& ((joy_buttons & 256) == 0))//shifter in neutral 
					{
					clutchpedalin = 0;
					gear = 7;//set gear in use to neutral
					use_gear = gear; 
					geardisp.VISIBLE = OFF;
					}
					
			//while(1)
			//{
				if((stantrans == 1) && (use_gear >= 0) && (use_gear < 7)  && (calc_rpm < 600) && (car_velocity < 10)
						&& (selecttransveh_pan.VISIBLE == OFF))//&& (clutchpedal <= 70)clutch not pressed and shifter in gear(use_gear >= 0) && (use_gear < 7)
				{
					depressclutch_txt.VISIBLE = ON;
					wait(-.5);
					depressclutch_txt.VISIBLE = OFF;
					wait(-.5);
				} 
				
			//wait(1);
				//}
				
		}	//end of standardtrans = 1 conditional		
			
}	//end of gear function

////////////////////////////////////////////////////////////////////////////////////////
		//  FUNCTION Check_Brake()
		//  Decides when to apply the brakes
		//  Do not "slam" brakes on, if going very slow
		//  Uses a +/- 0.03 "dead spot" in the accelerator, as the brake pedal
		//
	function check_brake()
	{
			if ( car_indic != 1 ) {T_brake = 0;} // Release brake, set braking force to 0
			else
			{
				if ( abs(car_velocity) >= 1)
				{
					T_Brake = (sign(car_velocity)) * (-Brake_Torque);
					Torq_Drive_Train = 0;  
				}
				else {T_brake = 0;} // Going too slow for hard braking force
			}
			// Check for pedal brake using Y axis. If brake value other than zero, brake applies
			//  Same braking action as the throttle brake, but the engine is still engaged
			//  If both brake types are used, they will add to each other (quick stop!)
			//else 
			//{
			if (brakepedal < 0) {T_Brake = (sign(car_velocity))*(-Brake_Torque/2);}
				//Torq_Drive_Train = 0; // If braking, disconnect the engine power
			else
				{T_Brake = 0;}  //if no brake pedal action, set brake to zero
			//if (throttle > 0)	{T_Brake = 0;}  //Release brake if throttle pressed
			//}
			
			//((joy_1==1)||(key_x==1))(Button for hand brake,You can change "joy_1" or "key_x")
	}    


		//////////////////////////////////////////////////////////
		// FUNCTION In_Air()  My_Height is >=5   Airborne is = 1
		//
		//  Calculates Vert_Speed, Vert_Dist, modifies absdist.z
		//

		function In_Air()
		{
			Vert_Speed += Vert_Accel * time_step * 300; // Vert_Accel is Grav / Car_Weight
			Vert_Dist = Vert_Speed * time_step;  // Calculate vertical distance moved in 1 time period 
			//  ( Distance = Rate * Time )
			absdist.z = Vert_Dist;  // Modify our world coordinate height
			Was_Airborne = 1;      // Set flag that we have been airborne
			Hang_Time += time;    // Sum of time in the air
			if (Vert_Dist < 0) {Drop_Time += time;}  // Time spent falling
		}
		////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////
		//  FUNCTION On_Ground()  My_Height < 5  Airborne is = 0
		//
		//  Produces Vert_Dist (as measured), saves Old_AbsdistZ
		//  Calculates Vert_Speed from climbing or descending on a road
		//   if we are on the surface of the road, otherwise, still falling
		//   due to gravity.
		//
		//
		function On_Ground()
		{
			player = me;
			if (Was_Airborne == 1) { Drop_Hang();}  // save Hang time, and Drop time
			//Handle landing, and dampen shock absorber "bounce" 
			if (my_height > 0)  // Still in the air  (Could also have hit a bump...)
			{
				if (my_height >= 3) { Bounce_Speed = -2;} 
				else {Bounce_Speed = -1;} // Fall slower
				
				Bounce_Dist = Bounce_Speed * time_step;  // Calculate vertical distance moved in 1 time period 
				//  ( Distance = Rate * Time )
				absdist.z = Bounce_Dist;         // Modify our world coordinate height
			}
			if (my_height == 0) // Vertical Distance moved by the ground (Vert_Dist) is measured
			{
				Vert_Dist = my.z - Old_MyZ;  // Compare with previous height
				Vert_Speed = Vert_Dist / time_step; // Rate = Dist / Time
			}
			if (my_height < 100) { absdist.z += -my_height; }  // Don't fall below the road was 0
			Old_MyZ = my.z;  // Set previous height to the current height
		} 
		
		//////////////////////////////////////////////////////////////
		//  FUNCTION Drop_Hang()  Saves values for Hang Time and Drop Time
		//
		//  Saves Drop_Time to DTime and Hang_Time to HTime
		//  Resets Drop_Time and Hang_Time to zero
		//  Also clears the "Was_Airborne" flag
		//  Resets airborne falling speed, and prepares to land
		//
		function Drop_Hang()
		{
			Was_Airborne = 0;
			DTime = Drop_Time;  // Time we spent falling - this jump only
			Drop_Time = 0;      // Reset for next fall
			HTime = Hang_Time;  // Time we spent in the air - this jump only
			Hang_Time = 0;      // Reset for next fall
			Impact_Angle = my_floornormal.z;  // Angle at which we landed
			Impact_Speed = Vert_Speed;        // Speed at which we landed
			Old_MyZ = my.z;  // Make previous height the current height
		}
		////////////////////////////////////////////  
		//  Tune Engine Sound                     //
		////////////////////////////////////////////
		//   Set engine pitch according to RPM    //
		////////////////////////////////////////////
		function tune_esound()
		{
			player = me;
			if (Eng_Snd_On == 0) {return;}
			if (snd_playing(enghandle) != 1) {enghandle = snd_loop(engsound,20,0);} // start playing engine sound
			if( (rpm > 0) && (my_movemode == MODE_DRIVING) ) 
			// if engine running & we are driving
			{
				eng_pitch = rpm/50;   // tune the sound depending on rpm was 15
				snd_tune (enghandle,20,eng_pitch,0);//
			}
			else  // Engine is stopped, or we are walking
			{
				snd_stop (enghandle);  // stop playing engine sound
			}
		} 
		function trigger_event() 
		{
			if (event_type == EVENT_TRIGGER)
			{
				collision_handle = snd_play(collision,100,0);
				wait(3);
				
			}
			
		}
function bounce_event()
{
  if (event_type == EVENT_ENTITY)
  {
    wait(-2);
    ent_remove(me); // disappear when hit
  }
}

		////////////////////////////////////////////////////////
		// Screen text for steering mode - keyboard or joystick
		TEXT steering_text = 
		{
			pos_x = 55;
			pos_y = 637;
			layer = 3;
			font = 	panel_font;				//panel_font;
			string(Steer_kb);
			//flags = NOFILTER;
		}
		//////////////////////////////////////////////////////
		// Screen text for throttle mode - keyboard or joystick
		TEXT throttle_text =
		{
			pos_x = 55;
			pos_y = 649;
			layer = 3;
			font = panel_font;
			string(Throttle_kb);
			//flags = NOFILTER;
		}
		
		
		///turn instructions L6
		//
		TEXT turnleftPineTree_txt
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnleftPineTree_str);
			
		}
		//
		//turn instructions rural test
		//
		
		TEXT  enterfrwyonright_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(enterfrwyonright_str);
			
		}
		TEXT  movetocenterlane_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(movetocenterlane_str);
			
		}
		TEXT  movetorightlane_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(movetorightlane_str);
			
		}
		TEXT  exitfrwyright_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(exitfrwyright_str);
			
		}
		
		TEXT  turnrightsouthrd_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnrightsouthrd_str);
		}
		
		TEXT  turnrightwestrd_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnrightwestrd_str);
		}
		
		TEXT  turnrightparkplace_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnrightparkplace_str);
		}
	
		TEXT turnrightglenwood_txt =
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnrightglenwood_str);
		}
		//
		//turn instructions urban test
	
		
		TEXT turnleftprkingtobrdwy_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string(turnleftprkingtobrdwy_str);
		}
		
		TEXT turnrtbrdwytofirst_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrtbrdwytofirst_str);
			}
		
			
		TEXT turnrightmaintomrkt_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightmaintomrkt_str);
			}
			
		TEXT turnrightmrkttocenter_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightmrkttocenter_str);
			}
			
		TEXT turnrtctrtofirst_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrtctrtofirst_str);
			}
			TEXT turnrightctrto3rd_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightctrto3rd_str);
			}	
			
		TEXT turnleftfirsttomain_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnleftfirsttomain_str);
			}
			
		TEXT turnrightmaintofourth_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightmaintofourth_str);
			}
			
		TEXT 	gothrufirstonbrdwy_txt
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (gothrufirstonbrdwy_str);
			}
		
		
		TEXT proceedthrubrdwy_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthrubrdwy_str);
			}
			
		TEXT procbrdwythrufirst_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthrufirst_str);
			}
		
		TEXT proceedthrufirstave_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthrufirst_str);
			}
			
		TEXT proceedthrusecondave_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthrusecondave_str);
			}
		
		TEXT proceedthruthirdave_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthruthirdave_str);
			}
			
		TEXT turnrightfourthtocommerce_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightfourthtocommerce_str);
			}
			
		TEXT turnrightcommercetomrkt_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightcommercetomrkt_str);
			}	
		TEXT turnrightmrkttobrdwy_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightmrkttobrdwy_str);
			}	
		TEXT proceedthrufirstbrdwy_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (proceedthrufirstbrdwy_str);
			}
			
		TEXT turnrightprkingbrdwy_txt = //end of scenario
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightprkingbrdwy_str);
			}
			
		TEXT 	turnright3rdtoMain_txt =
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnright3rdtoMain_str);
		}
		
		TEXT 	turnleftMainto2nd_txt =
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnleftMainto2nd_str);
		}
		
		TEXT turnleftprkingbrdwy_txt =
			{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnleftprkingbrdwy_str);
		}
		
		TEXT 	turnrightmaintobrdwy_txt=
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (turnrightMaintobrdwy_str);
		}
		TEXT 	returntostart_txt =
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (returntostart_str);
		}
			
			
		TEXT ESC_text =
		{
			pos_x = 55;
			pos_y = 625;
			layer = 4;
			font = panel_font;
			string(esckey_str);
			//flags = NOFILTER;
		}
		TEXT noturnsignal_txt =
		{
			pos_x = 400; //was 570
			pos_y = 350;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (noturnsignal_str);
		}	

		///////////////////////////////////////////////////
		//////  Put the gear display on the screen

		
		//PANEL instructtextpanel =
		//{
			//bmap = instructtext; //background panel for text
			//pos_x = 259;
			//pos_y = 630;
			//flags = VISIBLE;
			//layer = 10;
		//}

		PANEL speedexceeddisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 600;   // was 530
			digits(0,0,"%.0f",panel_font,1,speedexceed);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
		}
			PANEL speedslowdisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 610;   // was 540
			digits(0,0,"%.0f",panel_font,1,speedtooslow);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
		}	
		PANEL overroadedgedisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 620;   // was 550
			digits(0,0,"%.0f",panel_font,1,overroadedge);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
		}
		PANEL overmediandisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 630;   // was 560
			digits(0,0,"%.0f",panel_font,1,overmedian);
			//flags = visible; // set flags
			layer = 3;
		}
		PANEL noturnsignalcountdisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 610;   // was 540
			digits(0,0,"%.0f",panel_font,1,noturnsignalcount);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
		}

		PANEL brakeRTdisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 550;   // Use 4 and 600 for 1024
			digits(0,0,"%.1f",panel_font,1,brakeRT);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
		}
	
		PANEL followtooclosedisp =
		{
			pos_x = 806;     // was 806
			pos_y = 610;   // was 560
			digits(0,0,"%.0f",panel_font,1,followtooclose);
			//	  alpha = 70;    // Set transparency level (Commercial version or higher)
			//flags = visible; // set flags
			layer = 3;
			
		}
	
		PANEL numcollisionsdisp =
		{
			pos_x = 806;     // Position the  display was 165
			pos_y = 590;   // was 520
			digits(0,0,"%.0f",panel_font,1,numcollisions);
			layer = 3;
			
		}
	
		///////////////////////////////////////
		/// Put turn signal on screen
		/////////////////////////////////////////////////////////

		ENTITY turnsignalleft =
		{
			type = "leftarrow.bmp";
			layer = 5;
			ambient = 100;
			x = 215;				//pos_x = 210; 
			y = 52; //was 30
			z = -38.0;			// Position the turnsignalleft
			//pos_y = 500;    // 
			//size_x = 118;
			scale_x = 0.15;  // Scaled width of arrow - use 0.15 for 1024
			scale_y = 0.14;  // Scaled length of arrow - use 0.25 for 1024
			scale_z = 0.22;  // Thickness - not really used
			
			//	  alpha = 70;     // Set transparency level (Commercial version or higher)
			flags =  OVERLAY;   // set flags  refresh, d3d, overlay
			view  = camera;
		}
		
		ENTITY rightturnsignal =
		{
			type = "rightarrow.bmp";
			layer = 5;
			ambient = 100;
			x = 215;// Position the instrument panel right turnsignal //was 210
			y = 40;  //was 8 left-right position was 57
			z = -38;    // 
			//size_x = 118;
			scale_x = 0.15;  // Scaled width of arrow
			scale_y = 0.14;  // Scaled length of arrow
			scale_z = 0.22;  // Thickness - not really used
			//	  alpha = 70;     // Set transparency level (Commercial version or higher)
			flags =   OVERLAY; // set flags  refresh, d3d, overlay
			view = camera;
		}
		ENTITY leftblinker
		{
			type = "leftblink.bmp";
			layer = 5;
			ambient = 100;
			scale_x = .06;
			scale_y = .12;
			flags =  OVERLAY;
		}
		ENTITY rightblinker
		{
			type = "rightblink.bmp";
			layer = 5;
			ambient = 100;
			scale_x = .06;
			scale_y = .12;
			flags = OVERLAY;
		}
	

		///////////////////////////
		//  Display the gear numbers in the window ///
		/////////////////////////////////////////////////////////
	function show_turnsignals()//caaled by car_init once
	{
		leftturnsignal = 0;
		rturnsignal = 0;
		
		while(1)  // run forever
			{
				//Logitech G27G29 Left Turn Signals
				
				if ((joy_6) && (displayG27G29flag == 1) || (leftturnsignal == 1)) 
				{
					signal_handle = snd_play(turn_signal,50,0);
					
					noturnsignal_txt.VISIBLE=OFF;
					leftturnsignal = 1;  //set flag to 1 after loop begins
					
					turnsignalleft.VISIBLE = ON;//turn indicator lt ON
					wait(-.2);//was -.3
					
					if (joy_6)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);//turn OFF for 2 sec
						}//
					
					turnsignalleft.VISIBLE = OFF;//turn indicator lt OFF
					wait(-.2);
					
					if (joy_6)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}//
					
				} //end of left turn conditional G27G29
				wait(1);//was 1
			//
			//Logitech G27 Right Turn Signals
			////if ((joy_5) || (leftturnsignal == 1))  // A pressed left turn
			
				if ((joy_5) && (displayG27G29flag == 1) || (rturnsignal == 1))  // A pressed right turn
				{
					signal_handle = ent_playsound(my,turn_signal,100);
					noturnsignal_txt.VISIBLE=OFF;
					rturnsignal = 1;  //set flag to  1 after loop begins
					
					rightturnsignal.VISIBLE = ON;
					wait(-.2);
					
					if (joy_5) //stop right turn signalling cycle
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}
				
					rightturnsignal.VISIBLE = OFF;
					wait(-.2);
					
					if (joy_5) //stop right turn signalling
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop	
						wait(-.2);
						}
				wait(1);//was 1
				} //end of right turn conditional G27G29
				//if ((joy_6) || (leftturnsignal == 1))  // A pressed left turn
				//
				//
		//T150 Left Turn Signals
				//
				if ((joy_1) && (displayT150T300flag == 1) || (leftturnsignal == 1))
				{
					signal_handle = snd_play(turn_signal,50,0);	
					noturnsignal_txt.VISIBLE=OFF;
					leftturnsignal = 1;  //set flag to 1 after loop begins
					
					turnsignalleft.VISIBLE = ON;//turn indicator lt ON
					wait(-.2);//was -.3
					
					if (joy_1)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);//turn OFF for .2 sec
						}//
					
					turnsignalleft.VISIBLE = OFF;//turn indicator lt OFF
					wait(-.2);
					
					if (joy_1)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}//
					wait(1);//was -.1
				} //end of left turn conditional T150T300
			
			//
			//T150 Right Turn Signals
			//For T150
			
				if ((joy_2) && (displayT150T300flag == 1) || (rturnsignal == 1)) // A pressed right turn
				{
					signal_handle = ent_playsound(my,turn_signal,100);
					noturnsignal_txt.VISIBLE=OFF;
					rturnsignal = 1;  //set flag to  1 after loop begins
					
					rightturnsignal.VISIBLE = ON;
					wait(-.2);
					
					if (joy_2) //stop right turn signalling cycle
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}
				
					rightturnsignal.VISIBLE = OFF;
					wait(-.2);
					
					if (joy_2) //stop right turn signalling
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop	
						wait(-.2);
						}
			
				} //end of right turn conditional T150T300
				
			wait(1);//was -.1
			
		//	} //end of loop
	
		//
		//TMX or TMXPro LEFT TURN SIGNAL
		//
		
				if ((joy_1) && (displayTMXTMXProflag == 1) || (leftturnsignal == 1))
				{
					signal_handle = snd_play(turn_signal,50,0);	
					noturnsignal_txt.VISIBLE=OFF;
					leftturnsignal = 1;  //set flag to 1 after loop begins
					
					turnsignalleft.VISIBLE = ON;//turn indicator lt ON
					wait(-.2);//was -.3
					
					if (joy_1)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);//turn OFF for .2 sec
						}//
					
					turnsignalleft.VISIBLE = OFF;//turn indicator lt OFF
					wait(-.2);
					
					if (joy_1)//stop signal when pressed again and set flag
						{
						snd_stop(signal_handle);
						turnsignalleft.VISIBLE = OFF;
						leftturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}//
					wait(1);//was -.1
				} //end of left turn conditional TMX
			
			//
			//TMX Right Turn Signals
			//For T150
			
				if ((joy_2) && (displayTMXTMXProflag == 1) || (rturnsignal == 1)) // A pressed right turn
				{
					signal_handle = ent_playsound(my,turn_signal,100);
					noturnsignal_txt.VISIBLE=OFF;
					rturnsignal = 1;  //set flag to  1 after loop begins
					
					rightturnsignal.VISIBLE = ON;
					wait(-.2);
					
					if (joy_2) //stop right turn signalling cycle
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop
						wait(-.2);
						}
				
					rightturnsignal.VISIBLE = OFF;
					wait(-.2);
					
					if (joy_2) //stop right turn signalling
						{
						snd_stop(signal_handle);
						rightturnsignal.VISIBLE = OFF;
						rturnsignal = 0; //set var to zero to end loop	
						wait(-.2);
						}
			
				} //end of right turn conditional TMX
				
			wait(1);//was -.1
			
			} //end of While loop
	} //end of function	TURN SIGNAL

		function show_geardisp()
		{
			gear_pos.x = Use_Gear * 20; // Each gear number is 20 pixels wide
			wait(1);
		
		}


		function show_numcollisionsdisp()
		{

				numcollisions_pos.x = numcollisions * 15; // Each number is 15 pixels wide
			
		}

		///////////////////////////////
		// Add the throttle arrow   ///
		///////////////////////////////
	/*	entity tarrow
		{
			type = "car_arrow.bmp";
			layer = 5;             // displays over lower layers
			//flags = overlay, nofilter;       
			ambient = 100;
			scale_x = 0.15;
			scale_y = 0.15;
			scale_z = 0.15;    
			view  = camera;
			x = 200;      // distance ahead of the view
			y = 28.6;     // left-right distance 0 = center (use - 77 for 1024) was 9
			z = -75.9;    // vertical distance   0 = center (use - -75.9 for 1024)
		}
		*/
		//////////////////////////////////////////////////
		//    Set the angle of the speedometer needle
		function sneedle_roll()
		{
			sneang = (car_speed-48)*(-420/140);  // -70 / 286 degrees / 140 mph
			sneedle.roll = maxv(-143,sneang-9);  //143// Speedometer can't go below zero
		}
		/////////////////////////////////////////////////////   
		//    Set the angle of the tachometer needle
		function tneedle_roll()
		{
			tneang = (rpm-3500)*(-286/7000);  // 286 degrees / 7000 rpm
			tneedle.roll = maxv(-143,(minv(tneang,143)));  // limits RPM 0 => 7000
		}
		


		/////////////////////////////////////////////////////         
		//    Set the position of the throttle arrow
	
		
		STRING endscenario_str =
		"End of Scenario. Use Arrow Keys to Select Main Menu Item.";
		
		STRING endscenariopressESC_str =
		"End of Scenario. Press ESC key to Load a Scenario or Quit Simulator.";
		
	
		
		STRING selautopasscar_str =
		"You have selected Automobile with Automatic 
		Transmission. If you wish to change your selection,
		you must re-load the 'Getting Started' lesson. Use
		the ESC key to open the menu, then select Load Lesson.";
		
		STRING selmanualpasscar_str =
		"You have selected Automobile with Manual Transmission. 
		If you wish to change your selection, you must re-load 
		the 'Getting Started' lesson. Use the ESC key to open 
		the menu, then select Load Lesson.";
		
		STRING selautotruck_str =
		"You have selected Delivery Truck with Automatic
		Transmission. If you wish to change your selection,
		you must re-load the 'Getting Started' lesson. Use 
		the ESC key to open the menu, then select Load Lesson.";
		
		
		STRING selmanualtruck_str =
		"You have selected Delivery Truck with Manual Transmission.
		 If you wish to change your selection, you must re-load 
		 the 'Getting Started' lesson. Use the ESC key to open the 
		 menu, then select Load Lesson.";
		
		STRING getstarted1_str = 
		"This is a safe area where you can become 
		familiar with the simulated car's performance
		and handling. Practice maneuvering around and
		through the cones ahead. Parking practice areas
		are next to the fences on the right. Do not leave
		roadways, you may not be able to get back on. When 
		you wish to pause, resume or end a lesson, load a
		new lesson or need help with view control, turn 
		signals, drive/reverse toggle and other issues, press
		the ESC key for the main menu, F10 Full Screen, F12 for
		Window. Accelerate when this message disappears.";
		
		
	   STRING getstarted2_str =
		"Controls(see Help for more info):
		KEY R - Toggle Drive/Reverse
		KEY H - Toggle Low/High Beams
		KEY F10 - Full Screen
		KEY F12 - Window
		ESC Key - Pauses simulator and shows main menu
		ENTER key - execute menu selection
		ARROW Keys - Navigate menu
		POV Button - 360 deg view around vehicle
		Left paddle - Lft turn signal, press to start, again to stop
		Right paddle - Rt turn signal, press to start, again to stop";
    
		
	/*	STRING getstarted3_str =
		"Use the \"A\" (or Button 3) key
		for the left turn signal, the \"D\"
		key (or Button 4) for the right turn
		signal.Use key \"H\" (or Button 6) for
		the horn. Try these controls now.";

		STRING getstarted4_str = 
		"Try maneuvering around the row of
		cones on the right or left ahead,
		then drive through the double row
		of cones. Use the\"PageUp\" key for
		increasing steering sensitivity, the 
		\"PageDown\" key for decreasing sensitivity.
		Try these controls now.";

		STRING getstarted5_str = 
		"Continue to practice in this area
		and on the surrounding roads until
		you feel comfortable with the
		simulator. When you wish to proceed
		to the next lesson, press the ESC key
		and select \"Load Lesson\" from the
		main menu. See the user manual for
		more information on simulator operations."; 
	*///
		// Strings for Lesson 2//
		//
		STRING lesson2_str = 
		"Follow the vehicle you see ahead. DO NOT
		PASS. KEEP PACE but maintain a SAFE DISTANCE
		at all times. To follow safely, use the
		3 sec. rule: As the vehicle passes an
		object next to the road (sign, tree,
		etc.), count 3 sec. You should not pass
		the same object before the count ends.
		Accelerate when this message disappears."; 

		STRING lesson2a_str =
		"At the intersection, come to a FULL
		stop. Look BOTH ways before proceeding.";
		//
		////Strings for Lesson 3
		//
		STRING lesson3_str =
		"There is slow traffic ahead. Pass when legal  
		and safe to do so. Make sure the passing lane 
		is clear of traffic. Use your turn signal when 
		moving in and out of the passing lane. Return 
		to your lane only when you see the passed 
		vehicle in your rearview mirror. Accelerate 
		when this message disappears."; 
		

		STRING lesson4_str =
		"There is slow traffic ahead. Pass when legal
		and safe to do so. There is traffic coming
		from the opposite direction. Allow enough
		time to pass to safely avoid the oncoming 
		traffic. Use your turn signal when moving 
		in and out of the passing lane. Pass as many
		cars as you can before the scenario ends. 
		Accelerate when this  message disappears.";
	

		STRING lesson5_str =
		"Pass the semi-trucks ahead. Semi-trucks
		are very long and wide. Allow extra time to 
		pass these large vehicles to avoid oncoming
		traffic. Use your turn signal when moving 
		in and out of the passing lane. Pass as many
		trucks as you can before the scenario ends.
		Accelerate when this message disappears.";

		STRING lesson6_str =
		"Turn left at the next intersection.
		Begin signalling your turn about 100 feet
		before you reach the intersection. Watch for
		oncoming traffic and traffic behind you. You need
		to judge the distance and speed of the oncoming
		traffic in order to safely make the turn. You 
		must complete the turn before the scenario ends. 
		Accelerate when this message disappears.";
		
		STRING lesson7_str =
		"Turn left at the next intersection. Oncoming 
		traffic will be heavy and fast. Signal your turn
		about 100 feet before the intersection. Watch
		for traffic behind you. You will need to judge 
		the gap between oncoming cars accurately in order
		safely make the turn. Complete the turn before 
		the scenario ends. Accelerate when this message 
		disappears.";

		STRING lesson8_str =
		"There is a diagonal parking place ahead
		on the right between the two SUVs.  Park 
		your vehicle there and then back out. Watch 
		for traffic behind you when backing.  You 
		will need to use the View Control to perform 
		this task. Complete this task before the scenario 
		ends. Accelerate when this message disappears.";

		STRING lesson9_str =
		"There are several parking spaces ahead on the
		right. The spaces are of varying sizes. Parallel 
		park between any two of these vehicles. Start by 
		moving up along side the car in front of the space 
		with one to two feet of clearance. Then back up about 
		half the length of your car and turn into the space
		at about a 45 degree angle. You will need to use
		the View Control to perform this task. Repeat this task
		with each of the spaces until you can perform it without 
		hitting any vehicles. When finished, press the ESC key
		to load a new lesson or quit the simulator.";
		

		STRING lesson10_str =
		"There is road construction ahead. Slow down and 
		watch for vehicles and pedestrians. Continue through
		the construction area towards the intersection.  
		Complete this task before the scenario ends. 
		Accelerate when this message disappears.";
		

		STRING lesson11_str =
		"There is a van ahead that appears to be having 
		trouble. If you decide to go around it, check for 
		traffic coming from behind you, then signal. 
		Return to the right lane after passing. Complete 
		this task before the scenario ends. Accelerate 
		when this message disappears.";

		STRING lesson12_str =
		"Urban environments can present road hazards 
		from unexpected places. Stay in the right 
		lane and watch for hazards that may enter
		you lane including traffic overtaking you.
		If a hazard appears, you must safely avoid it
		and continue forward on this street. Complete 
		this task before the scenario ends. Accelerate 
		when this message disappears.";

		STRING lesson13_str =
		"There is a parking lot on the left ahead.
		Enter and park in this lot. You will have to
		avoid oncoming traffic in two lanes not just
		one. Make sure you allow enough to time to cross
		these lanes. Remember to signal one hundred feet
		ahead of your turn. Complete this task before the
		scenario ends. Accelerate when this message
		disappears.";

		STRING lesson14_str =
		"At the main intersection ahead, turn
		left. Watch for opposing traffic and 
		for pedestrians in crosswalks. Remember
		to signal your turn. Complete this task 
		before the scenario ends. Accelerate when
		this message disappears.";

		STRING lesson15_str =//TRAFFIC JAM URBAN
		"Continue straight through the intersection
		ahead. When passing through intersections
		in heavy traffic, always make sure you 
		will not block cross traffic should the 
		traffic flow stop. Complete this task 
		before the scenario ends. Accelerate when
		this message disappears.";

		STRING lesson16_str =//RIGHT TURN URBAN
		"Turn right at the main intersection ahead. This is 
		First Ave. Park in the lot of the medical building 
		which is the third building on the left hand side of
		First Ave. Most accidents occur at intersections,
		so stay alert and use your view control to watch
		for peds and traffic. Complete  this task before 
		the scenario ends. Accelerate when this message 
		disappears.";

		STRING lesson17_str =//Quick Parking URBAN
		"Street parking is available on the right ahead. 
		Some parking spaces are large enough to drive 
		in without parallel parking. Simply turn into
		one of these spaces as quickly as possible. Make 
		sure the car is parked with enough space from 
		other cars so you do not become penned in. Now  
		drive out of the spot and try the lesson over
		again until you are comfortable driving in and 
		out of parking spots. Always watch out for other 
		moving vehicles on the street and signal your
		intentions. Complete this task before the scenario
		ends. Accelerate when this message disappears.";


		STRING lesson18_str =//Parallel Parking URBAN
		"Street parking is available on the right ahead. 
		Parking spaces are only large enough for parallel 
		parking. Find a space and parallel park. Then move
		out of the spot and try parking parallel in another 
		spot. Watch out for traffic behind you and in the
		adjacent lane. Complete this task before the scenario
		ends. Accelerate when this message disappears.";
		

		STRING lesson19_str = //Left Turn FOG
		"Judging your distance from traffic is critical
		in conditions of reduced visibility such as fog
		or haze. Turn left at the next intersection. Watch
		for oncoming traffic and allow for a safe distance
		to make the turn. Signal your turn. Complete the
		task before the scenario ends.  Accelerate when 
		this message disappears.";

		STRING lesson20_str =//Passing FOG
		"Judging your distance from oncoming traffic will
		be impaired in conditions of reduced visibility.
		Pass the slow traffic ahead. Watch for oncoming 
		traffic and allow for a safe distance from
		traffic before passing. Complete the task before 
		the scenario ends.  Accelerate when this message 
		disappears.";

		STRING lesson21_str =//Freeway Entrance
		"This is the freeway entrance road. Freeway entry 
		requires you to accelerate and merge with freeway 
		traffic. Do NOT expect traffic to slow for you.
		You must be able to judge the speed of freeway
		traffic and match it to allow a safe merger.
		Once you are on the freeway, move to the left 
		(fast) lane. Be sure to signal your turns in and
		out of lanes. Complete the task before the scenario 
		ends. Accelerate when this message disappears.";
		

		STRING lesson22_str =//Freeway Entrance Heavy
		"This freeway entrance lesson is made more
		difficult by heavy freeway traffic. Acclerate
		to match freeway traffic speed. Do NOT expect
		traffic to slow for you. Once you are on the 
		freeway move to the left (fast) lane.  Complete
		the task before the scenario ends. Accelerate
		when this message disappears.";

		STRING lesson23_str =//freeway exit right lane
		"Exiting a freeway requires planning and control 
		of speed. Plan ahead to exit and reduce speed 
		only as needed to safely exit the freeway.
		Signal before you exit to communicate your 
		intentions to other drivers. Complete the
		task before the scenario ends. Accelerate to 
		keep pace with traffic when this message 
		disappears.";

		STRING lesson24_str =//freeway exit left lane
		"This scenario requires that you maneuver from the
		left (fast) lane to the far right (exit) lane in order to
		safely exit the freeway. Freeway exit is about one mile
		from where you are now. While moving to the right lane to 
		exit, maintain speed with surrounding traffic. You must 
		maneuver without getting too close to traffic. Before 
		changing lanes, check to make sure the exit lane 
		is clear, then signal your intentions.  Exit the freeway
		before the scenario ends. Accelerate to keep pace with 
		traffic when this message disappears.";


		STRING lesson25_str =//freeway fog entry
		"Fog and other weather phenomenon can affect
		your ability to judge speed relative to other
		traffic. Enter the freeway and merge with other
		traffic then move to the left lane. Complete the
		task before the scenario ends. Accelerate when 
		this message disappears.";

		STRING lesson26_str =//EXIT FRWY FROM LEFT FOG
		"Reduced visibility also affects your ability
		to plan ahead because road signs and exits are
		more difficult to see in advance. Exiting from
		the fast lane of a freeway takes more planning
		and care in avoiding traffic under foggy conditions.
		Move to the right (exit) lane when able. Complete the
		task before the scenario ends. Accelerate when 
		this message disappears.";

		STRING lesson27_str =//NIGHT DRIVING RURAL
		"Night driving speeds are limited by the distance
		you can see ahead with your headlights. If you cannot
		stop within the distance of your headlights, you are
		driving too fast. Drive up this road until you reach
		Pine Tree Rd, then turn right. Turn right again at the
		next intersection. In the steering pad, practice driving
		around the cones, then leave the steering pad and drive 
		around on the surrounding roads. Experiment with high and
		low beam headlights (key H to toggle low/high beams).

		Press the ESC key when you wish to quit or reload lesson.
		Accelerate to begin.";


		STRING lesson28_str =//CURVES and STRAIGHTS
		"This a test of your ability to control your speed
		and lane position. Keep your speed within 5 mph of
		the posted speed limit. DO NOT cross the road median or 
		the road edge at any time. Accelerate when this message
		disappears.";
		
		STRING lesson29_str =//DRIVE TEST RURAL v.1,2,3
		"This is a driving test in a rural highway  environment.
		 Instructions for navigating this environment will be 
		 displayed on the windshield. Follow the instructions 
		 exactly. Pass slower traffic when safe to do so. Press 
		 the ESC key when test is completed or if restarting the
		 test is desired. Accelerate when this message disappears.";
		 
		STRING lesson30_str = //DRIVE TEST URBAN v.1,2,3
		"This is a driving test in an urban traffic environment.
		 Instructions for navigating this environment will be 
		 displayed on the windshield. Follow the instructions 
		 exactly. Press the ESC key when test is completed or 
		 if restarting the test is desired. Accelerate when 
		 this message disappears.";
		 
		STRING lesson31_str = //CURVES and STRAIGHTS NIGHT
		"This is a test of your ability to maintain control of
		your vehicle at night in both curve and straight road
		conditions. Maintain the speed limit if possible but do
		not cross the median or leave the road surface. Use high
		beam headlights (key H) when needed. Press the ESC key 
		when test is completed or if restarting the test is desired. 
		Accelerate when this message disappears.";
		
		STRING lesson32_str = //Parking URBAN NIGHT
		"Parking in urban environments is made more difficult in
		night driving conditions where visibility is limited. The
		parking spaces on the right between vehicles in cases allow
		enough space for regulr drive-in parking or parallel parking.
		Practice both of these methods while watching out for
		traffic. Press the ESC key when practice is completed.
		Accelerate when this message disappears.";
		
		STRING lesson33_str =   //Left Turn NIGHT
		"Turn left at the next intersection. Oncoming 
		traffic will be at high speed. Make sure your
		headlights are on low beam (key H). Signal your turn
		about 100 feet before the intersection. You will need 
		to judge the gap between oncoming cars accurately in 
		order to safely make the turn. Complete the turn before 
		the scenario ends. Accelerate when this message 
		disappears.";
		
		STRING lesson34_str =  //Night Urban Hazards
		"Potential urban driving hazards become even more 
		of a problem at night due to reduced visibility.
		Stay alert for vehicles and pedestrians that may
		enter the roadway at any time. Abide by the speed 
		limit (25 MPH) and avoid potential conflicts with 
		other vehicles. Accelerate when this message 
		disappears.";
		 
		STRING lesson35_str = //Pass Opposing Night
		"There is slow traffic ahead. Pass when legal
		and safe to do so. There is traffic coming
		from the opposite direction. Allow enough
		time to pass to safely avoid the oncoming 
		traffic. Use your turn signal when moving 
		in and out of the passing lane. Maintain the
		posted speed limit (40 mph). Pass as many
		cars as you can before the scenario ends. 
		Accelerate when this  message disappears.";
		

		STRING collision_str =
		"You have hit something.
		Maneuver around it to continue.";

		STRING backoff_str =
		"You are Too Close to the Traffic Ahead. BACK OFF!";

		STRING keeppace_str =
		"You are Too Far from the Traffic Ahead. KEEP PACE!";

		STRING speedlimit_str =
		"You are over the speed limit. SLOW DOWN!";
		
		STRING slowspeedwarn_str = 
		"You are driving too slowly. SPEED UP!";
		
		STRING speedexceed_str = 
		"Speed Exceedance:";   //label for speed exceed

		STRING noturnsignal_str =
		"Use your turn signal within 100 feet of a turn";

		STRING missedturn_str =
		"You missed your turn. Reload lesson and restart.";

		STRING numcollisions_str ="Number of Collisions:";
		
		STRING speedexceed_str ="Exceed Speed Limit (sec.):";
		STRING speedslow_str ="Speed Too Slow (sec.):";
		STRING overroadedge_str ="Over Road Edge (sec.):";
		STRING overmedian_str = "Over Median (sec.):";
		
		STRING noturnsignalcount_str = "No Turn Signal (sec.):"; //label for no turn
		
		STRING followtooclose_str = "Following Too Close (sec.):";
		
		STRING brakeRT_str = "Brake RT(sec.):";
		
		
		
		//////
		/////

		
		TEXT selautopasscar_txt =
		{
			pos_x = 675; //was 570
			pos_y = 585; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = system_font;
			string (selautopasscar_str);
			//flags = VISIBLE; //not visible until HUD loaded	
		}

		TEXT selmanualpasscar_txt =
		{
			pos_x = 675; //was 570
			pos_y = 585; //was 480
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = system_font;
			string (selmanualpasscar_str);
			//flags = VISIBLE; //not visible until HUD loaded	
		}

		TEXT selautotruck_txt =
		{
			pos_x = 675; //was 570
			pos_y = 585;
			scale_x = 1.0; //1.0;
			scale_y = 1.0;
			font = system_font;
			string (selautotruck_str);
			//flags = CENTER_X | CENTER_Y ; //not visible until HUD loaded
		}

		TEXT selmanualtruck_txt =
		{
			pos_x = 675; //was 570
			pos_y = 585;
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (selmanualtruck_str);
			//flags = CENTER_X | CENTER_Y ; //not visible until HUD loaded
		}

		TEXT getstarted1_txt = //lesson label on lesson dialog
		{
			pos_x = 675; //was 675
			pos_y = 585;//was 565
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (getstarted1_str);
			//flags = CENTER_X | CENTER_Y ; //not visible until HUD loaded
		}
		TEXT getstarted2_txt =
		{
			pos_x = 670; //was 570
			pos_y = 585;
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (getstarted2_str);
			//flags = NOFILTER; //not visible until HUD loaded
		}


		TEXT lesson2_txt =    //following
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson2_str);
			//flags = CENTER_X | CENTER_Y ; //not visible until HUD loaded	
		}
		TEXT lesson2a_txt=  //intersection text
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson2a_str);
			//flags = CENTER_X | CENTER_Y ; //not visible until HUD loaded	
		}
		TEXT lesson3_txt =   //pass, no traffic
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson3_str);
		}
		TEXT lesson4_txt =  //pass traffic
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson4_str);
		}
		TEXT lesson5_txt =        //pass large truck
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson5_str); 
		}

		TEXT lesson6_txt =     //left turn light
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson6_str);
		}
		TEXT lesson7_txt =    //left turn heavy
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson7_str);
		}
		TEXT lesson8_txt =    //diagonal parking
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson8_str);
		}

		TEXT lesson9_txt =    //parallel parking
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson9_str);
		}
		TEXT lesson10_txt =    //road construction
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson10_str);
		}
		TEXT lesson11_txt =      //urban, slow van
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson11_str);
		}

		TEXT lesson12_txt =      //
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson12_str);
		}

		TEXT lesson13_txt =      //
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson13_str);
		}
		TEXT lesson14_txt =      //
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson14_str);
		}

		TEXT lesson15_txt =      //
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson15_str);
		}

		TEXT lesson16_txt =      //urban, slow van
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson16_str);
		}

		TEXT lesson17_txt =      //
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson17_str);
		}

		TEXT lesson18_txt =      //urban, slow van
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson18_str);
		}

		TEXT lesson19_txt =      //urban, slow van
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson19_str);
		}
		TEXT lesson20_txt =      //urban, slow van
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson20_str);
		}

		TEXT lesson21_txt =      //freeway entry
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson21_str);
		}

		TEXT lesson22_txt =      //freeway entry heavy traffic
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson22_str);
		}
		TEXT lesson23_txt =      //freeway exit
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson23_str);
		}
		TEXT lesson24_txt =      //freeway exit from fast lane
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson24_str);
		}
		TEXT lesson25_txt =      //freeway entry fog
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson25_str);
		}
		TEXT lesson26_txt =      //freeway exit fog
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson26_str);
		}
		TEXT lesson27_txt =      //urban traffic fog
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson27_str);
		}
		TEXT lesson28_txt =      //hills and curves
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson28_str);
		}
		TEXT lesson29_txt =      //drive test rural
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson29_str);
		}
		TEXT lesson30_txt =      //drive test urban
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson30_str);
		}
		TEXT lesson31_txt =      //curves and straights NIGHT
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson31_str);
		}
		TEXT lesson32_txt =      //parking urban night
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson32_str);
		}
		TEXT lesson33_txt =      //Left Turn Night
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson33_str);
		}
		TEXT lesson34_txt =      //Night Urban Hazards
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson34_str);
		}
		TEXT lesson35_txt =      //Pass Opposing Night
		{
			pos_x = 640;
			pos_y = 585;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (lesson35_str);
		}
		TEXT endscenario_txt =      //End of Scenario, Press ESC key
		{
			pos_x = 500; //was 570
			pos_y = 320;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (endscenario_str);
		}
		
		TEXT endscenariopressESC_txt =      //End of Scenario, Press ESC key
		{
			pos_x = 500; //was 570
			pos_y = 320;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (endscenariopressESC_str);
		}
		//
		//
							
		TEXT collision_txt =      //Collided with object warning
		{
			pos_x = 530; //was 400
			pos_y = 300;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (collision_str);
			
		}
		TEXT numcollisions_txt =      //num coll label
		{
			pos_x = 630; //was 570
			pos_y = 590;//was 520
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (numcollisions_str);
			
		}
		
		TEXT speedexceed_txt =    //label for speeding count
		{
			pos_x = 630; //was 570
			pos_y = 600;//was 540
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (speedexceed_str);
		}
	
		TEXT speedslow_txt =    //label for speeding count
		{
			pos_x = 630; //was 570
			pos_y = 610;//was 540
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (speedslow_str);
		}
		TEXT overroadedge_txt =    //label for speeding count
		{
			pos_x = 630; //was 570
			pos_y = 620;//was 200550
			scale_y = 1.0;
			font = system_font;
			string (overroadedge_str);
		}
		TEXT overmedian_txt =    //label for speeding count
		{
			pos_x = 630; //was 570
			pos_y = 630;//was 560
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (overmedian_str);
		}
		
		TEXT noturnsignalcount_txt = //label
		{
			pos_x = 630; //was 570
			pos_y = 610;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (noturnsignalcount_str);
		}
		TEXT brakeRT_txt =   //label for brake RT
		{
			pos_x = 630; //was 570
			pos_y = 550;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (brakeRT_str);
		}
		
		TEXT followtooclose_txt =  //label
		{
			pos_x = 630; //was 630
			pos_y = 610;//was 560
			scale_x = 1.0;
			scale_y = 1.0;
			font = system_font;
			string (followtooclose_str);
		}
	

////////////////WARNINGS////////
		
		TEXT slowspeedwarn_txt =
		{
			pos_x = 500; //was 570
			pos_y = 340;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (slowspeedwarn_str);
		}
		
		TEXT backoff_txt =      //following backoff warning
		{
			pos_x = 500; //was 570
			pos_y = 340;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (backoff_str);
		}
		TEXT keeppace_txt =      //too far behind warning
		{
			pos_x = 500; //was 570
			pos_y = 330;//was 480
			
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (keeppace_str);
		}
		TEXT speedlimit_txt =    //you are speeding warning
		{
			pos_x = 500; //was 400
			pos_y = 290;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (speedlimit_str);
		}

		TEXT missedturn_txt // missed turn warning
		{
			pos_x = 500; //was 570
			pos_y = 280;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (missedturn_str);
		}
		TEXT pressbrake_txt // missed turn warning
		{
			pos_x = 500; //was 570
			pos_y = 280;//was 200
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (pressbrake_str); //press brake to re-calibrate
		}
		

		////////////////////////////////////////////////////////////
		// Show the on-screen displays (HUD)
		// Set any of these to "OFF" to keep them from being displayed
		////////////////////////////////////////////////////////////
		function clearInstructText()
		
		{
			endonceL28 = 0;
			endonceL30 = 0;
			drag = .35;
			startonce = 0;
			endscenariopressESC_txt.VISIBLE = OFF;
			collision_txt.VISIBLE = OFF;
			numcollisions_txt.VISIBLE = OFF; 
			backoff_txt.VISIBLE = OFF; 
			keeppace_txt.VISIBLE = OFF; 
			speedlimit_txt.VISIBLE = OFF; 
			speedexceed_txt.VISIBLE = OFF;
			speedslow_txt.VISIBLE = OFF;
			overmedian_txt.VISIBLE = OFF;
			overroadedge_txt.VISIBLE = OFF;
			overmediandisp.VISIBLE = OFF;
			overroadedgedisp.VISIBLE = OFF;
			slowspeedwarn_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			numcollisionsdisp.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			speedexceeddisp.VISIBLE = OFF;
			speedslowdisp.VISIBLE = OFF;
			
			missedturn_txt.VISIBLE = OFF;
			followtooclose_txt.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			getstarted1_txt.VISIBLE = OFF;
			getstarted2_txt.VISIBLE = OFF;
			selautopasscar_txt.VISIBLE = OFF;
			selautotruck_txt.VISIBLE = OFF;
			selmanualtruck_txt.VISIBLE = OFF;
			selmanualpasscar_txt.VISIBLE = OFF;
			lesson2_txt.VISIBLE = OFF;
			lesson3_txt.VISIBLE = OFF;
			lesson4_txt.VISIBLE = OFF;
			lesson5_txt.VISIBLE = OFF;
			lesson6_txt.VISIBLE = OFF;
			lesson7_txt.VISIBLE = OFF;
			lesson8_txt.VISIBLE = OFF;
			lesson9_txt.VISIBLE = OFF;
			lesson10_txt.VISIBLE = OFF;
			lesson11_txt.VISIBLE = OFF;
			lesson12_txt.VISIBLE = OFF;
			lesson13_txt.VISIBLE = OFF;
			lesson14_txt.VISIBLE = OFF;
			lesson15_txt.VISIBLE = OFF;
			lesson16_txt.VISIBLE = OFF;
			lesson17_txt.VISIBLE = OFF;
			lesson18_txt.VISIBLE = OFF;
			lesson19_txt.VISIBLE = OFF;
			lesson20_txt.VISIBLE = OFF;
			lesson21_txt.VISIBLE = OFF;
			lesson22_txt.VISIBLE = OFF;
			lesson23_txt.VISIBLE = OFF;
			lesson24_txt.VISIBLE = OFF;
			lesson25_txt.VISIBLE = OFF;
			lesson26_txt.VISIBLE = OFF;
			lesson27_txt.VISIBLE = OFF;
			lesson28_txt.VISIBLE = OFF;
			lesson29_txt.VISIBLE = OFF;
			lesson30_txt.VISIBLE = OFF;
			lesson31_txt.VISIBLE = OFF;
			lesson32_txt.VISIBLE = OFF;
			lesson33_txt.VISIBLE = OFF;
			lesson34_txt.VISIBLE = OFF;
			lesson35_txt.VISIBLE = OFF;
			
			collision_txt.VISIBLE = OFF;
			
			speeddial.visible = OFF;      // Speedometer dial
			geardisp.visible = OFF;       // Gear numbers in the tachometer
			tachdial.visible = OFF;       // Tachometer dial
			sneedle.VISIBLE = OFF;
			tneedle.VISIBLE = OFF;
			highbeams.VISIBLE = OFF;//icon off
			//tarrow.VISIBLE = OFF;
			endscenariopressESC_txt.VISIBLE = OFF;
			endscenariopressESC_txt.VISIBLE = OFF;
			speedlimit_txt.VISIBLE = OFF;
			noturnsignal_txt.VISIBLE=OFF;	
			backoff_txt.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			depressclutch_txt.VISIBLE = OFF;
			keeppace_txt.VISIBLE = OFF;
			selautotruck_txt.VISIBLE = OFF;
			selautopasscar_txt.VISIBLE = OFF;
			selmanualpasscar_txt.VISIBLE = OFF;
			selmanualtruck_txt.VISIBLE = OFF;
			speedexceed_txt.VISIBLE = OFF;
			
			
			distractDisplay_ent.VISIBLE = OFF;//hide distractor display
		
			daysremaining0_txt.VISIBLE = OFF;
			daysremaining1_txt.VISIBLE = OFF;
			daysremaining2_txt.VISIBLE = OFF;
			daysremaining3_txt.VISIBLE = OFF;
			daysremaining4_txt.VISIBLE = OFF;
			daysremaining5_txt.VISIBLE = OFF;
			daysremaining6_txt.VISIBLE = OFF;
			daysremaining7_txt.VISIBLE = OFF;
			daysremaining8_txt.VISIBLE = OFF;
			daysremaining9_txt.VISIBLE = OFF;
		
			turnleftprkingtobrdwy_txt.VISIBLE=OFF;
			
			turnrtbrdwytofirst_txt.VISIBLE=OFF;

			turnleftfirsttomain_txt.VISIBLE=OFF;

			turnrightmaintomrkt_txt.VISIBLE=OFF;
				
			turnrightmrkttocenter_txt.VISIBLE = OFF;
			turnrtctrtofirst_txt.VISIBLE=OFF;
			turnleftfirsttomain_txt.VISIBLE=OFF;
			proceedthrusecondave_txt.VISIBLE = OFF;
			proceedthruthirdave_txt.VISIBLE = OFF;
			turnrightmaintofourth_txt.VISIBLE=OFF;
			proceedthrubrdwy_txt.VISIBLE=OFF;
			turnrightfourthtocommerce_txt.VISIBLE=OFF;
			proceedthrufirstave_txt.VISIBLE = OFF;
			turnrightcommercetomrkt_txt.VISIBLE=OFF;
			turnrightmrkttobrdwy_txt.VISIBLE=OFF;
			proceedthrufirstbrdwy_txt.VISIBLE=OFF;
			turnrightprkingbrdwy_txt.VISIBLE=OFF;
			endscenariopressESC_txt.VISIBLE=OFF;
			turnrightctrto3rd_txt.VISIBLE = OFF;
			procbrdwythrufirst_txt.VISIBLE=OFF;
			turnrightmaintomrkt_txt.VISIBLE=OFF;
				
			endscenariopressESC_txt.VISIBLE=OFF;
			turnrightglenwood_txt.VISIBLE=OFF;
			turnrightparkplace_txt.VISIBLE=OFF;
			turnrightwestrd_txt.VISIBLE=OFF;
			turnrightsouthrd_txt.VISIBLE=OFF;
			enterfrwyonright_txt.VISIBLE=OFF;
			movetocenterlane_txt.VISIBLE=OFF;
			movetorightlane_txt.VISIBLE=OFF;
			exitfrwyright_txt.VISIBLE=OFF;
			
			numcollisions = 0;
			speedexceed = 0;
			speedtooslow = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			overmedian = 0;
			overroadedge = 0;
			speedtooslow = 0;
			brakeRT = 0;
			rmse = 0;
			meanlatdev = 0;
			//fog_color = 0;
			gear = 1;
			rpm = 550;
			throttle = 0;
			snd_stopall(4); //stop all sounds
		}


		function main_display_text()// Title and instruction for lesson
		{
			//getstarted1_txt.VISIBLE = ON;
			wait(1);
			//getstarted1_txt.VISIBLE = OFF;
			/*
			wait(-1);
			getstarted2_txt.VISIBLE = ON;
			wait(-20);
			txt_setinvisible(getstarted2_txt,-1);
			wait(-1);
			getstarted3_txt.VISIBLE = ON;
			wait(-15);
			txt_setinvisible(getstarted3_txt,-1);
			wait(-1);
			getstarted4_txt.VISIBLE = ON;
			wait(-15);
			txt_setinvisible(getstarted4_txt,-1);
			getstarted5_txt.VISIBLE = ON;
			wait(-15);
			txt_setinvisible(getstarted5_txt,-1);
			*/
		}
	
	function show_hud() //called by Player_Car action loop
		{
			//Steering_text.visible = ON;  // Keyboard or Joystick text
			//Throttle_text.visible = ON;  // Keyboard or Joystick text
			//ESC_text.visible = ON;
			//c_setminmax(me); 
		//	speeddial.visible = ON;      // Speedometer dial
		//	geardisp.visible = ON;       // Gear numbers in the tachometer
		//tachdial.visible = ON;       // Tachometer dial
		//	sneedle.visible = ON;        // Speedometer needle
			//tneedle.visible = ON;        // Tachometer needle
			//tarrow.visible = ON;         // Throttle thermometer arrow
		
			//show_turnsignals();          // show turnsignals when control selected
			main_display_text();			 // show getstarted instruction text
			//show_numcollisionsdisp();
			show_geardisp();             // Select gear numbers for the Tachometer display	
		}


		//////////////////////////////////////////////////////////////////
		//Brake light function
		///////////////////////////////////////////////////////////////// 

		function show_brakelights()
		{
			
			vec_set(leftblinker.x,my.x);
			vec_set(leftblinker.y,my.y);
			vec_set(leftblinker.z,my.z);
			vec_set(rightblinker.x,my.x);
			vec_set(rightblinker.y,my.y);
			vec_set(rightblinker.z,my.z);
			leftblinker.x = leftblinker.x - 12; //was 14
			leftblinker.y = leftblinker.y - 62; //was 69
			leftblinker.z = leftblinker.z - 19;
			rightblinker.x = rightblinker.x + 19; //was 21
			rightblinker.y = rightblinker.y - 62; //was 69
			rightblinker.z = rightblinker.z - 18;
			//leftblinker.LIGHT = ON;	
			leftblinker.ambient=100;
			leftblinker.bright = ON;
			//leftblinker.red = 255;
			//leftblinker.lightrange = 500;
			leftblinker.INVISIBLE = OFF; // turn left brakelight on
			leftblinker.PASSABLE = ON;
			leftblinker.SPOTLIGHT = ON;
			leftblinker.scale_x = .06;
			leftblinker.scale_y = .12;
			rightblinker.ambient=100;
			rightblinker.bright = ON;
			//rightblinker.lightrange = 300;
			rightblinker.INVISIBLE = OFF; // turn right brakelight on
			rightblinker.PASSABLE = ON;
			rightblinker.spotlight = ON;
			rightblinker.scale_x = .06;
			rightblinker.scale_y = .12;
		}

		// Adjusts on-screen display if resolution is 800x600 or 640x480
		// DO NOT make changes here!  Use "view rear_view" and other
		// panel (or function) routines instead. Then your changes will 
		// work in all three screen resolutions.
		// Make your changes for 1024x768, and they will be scaled here.
		//     x800 is the 0.78125 scale factor for 800x600
		//     x640 is the 0.625 scale factor for 640x400
		/////////////////////////////////////////////////////////////////
		function Adjust_Screen() 
		{
			if (video_mode == 7)  // Check for 800x600 screen resolution
			{
				//  Adjust the position and size of the rear-view mirror
				camera2_view.pos_x *= x800;
				camera2_view.pos_y *= x800;
				camera2_view.size_x *= x800;
				camera2_view.size_y *= x800;
				// Adjust the speedometer dial      
				speeddial.bmap = speed800; // Use a smaller bit map
				speeddial.pos_x *= x800;   // Position the speedometer
				speeddial.pos_y *= x800; 
				sneedle.scale_x *= 0.9;    // Scale the needle
				sneedle.scale_y *= 0.9; 	    
				// Adjust the tachometer dial
				tachdial.bmap = tach800;   // Use a smaller bit map
				tachdial.pos_x *= x800;    // Position the tachometer
				tachdial.pos_y *= x800;
				tneedle.scale_x *= 0.9;    // Scale the needle
				tneedle.scale_y *= 0.9;

				// Positon the Gear Number display
				geardisp.pos_x *= x800;    // Position the Gear Number dispaly
				geardisp.pos_y *= x800; 
				// Change the size of the throttle thermometer arrow 
				//tarrow.scale_x *= 0.9;
				//tarrow.scale_y *= 0.9;
				// Adjust the On-Screen text
				steering_text.pos_x = 2;
				steering_text.pos_y *= x800; 
				throttle_text.pos_x = 2;
				throttle_text.pos_y *= x800; 
			}
			if (video_mode == 6)  // Check for 640x480 screen resolutoin
			{
				//  Adjust the position and size of the rear-view mirror    
				camera2_view.pos_x *= x640;
				camera2_view.pos_y *= x640;
				camera2_view.size_x *= x640;
				camera2_view.size_y *= x640;
				// Adjust the speedometer dial      
				speeddial.bmap = speed640; // Use a smaller bit map
				speeddial.pos_x *= x640;   // Position the speedometer
				speeddial.pos_y *= x640;
				sneedle.scale_x *= 0.9;    // Scale the needle
				sneedle.scale_y *= 0.9; 	    
				// Adjust the tachometer dial
				tachdial.bmap = tach640;   // Use a smaller bit map
				tachdial.pos_x *= x640;    // Position the tachometer
				tachdial.pos_y *= x640;  
				tneedle.scale_x *= 0.9;    // Scale the needle
				tneedle.scale_y *= 0.9;
				// Position the Gear Number display
				geardisp.pos_x *= 0.6;     // Position the Gear Number dispaly
				geardisp.pos_y *= 0.61;  
				// Change the size of the throttle thermometer arrow 
				//tarrow.scale_x *= 0.9;
				//tarrow.scale_y *= 0.9;
				// Adjust the On-Screen text
				steering_text.pos_x = 1;
				steering_text.pos_y *= x640;
				throttle_text.pos_x = 1;
				throttle_text.pos_y *= x640;   	       
			}  
		}
		function collision_event()
		{
			ent_playsound(my, wham_wav, 10);
			anycollision = 1;
			
			collision_txt.VISIBLE = ON;	//you have hit something
			wait(-3);
			collision_txt.VISIBLE = OFF;
			
		}
		
		function scan_event() 
		{
			//while(1)
			//{
				if ((event_type == EVENT_SCAN) && (alertsflag == 0))
				
  				{
  					followtooclose += .03;
     				backoff_txt.VISIBLE = ON;
     				wait(-1);
     				backoff_txt.VISIBLE = OFF;
  				}
  				if ((event_type == EVENT_SCAN) && (alertsflag != 0))	
  				{
  					followtooclose += .03;
  				}
  				
		}
	//
		
		function scanvehicles() // scan ahead of player for vehicles
		{
			if((car_velocity > 5) && (car_velocity <= 15)) // 5 to 10mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(20,0,180),SCAN_ENTS + IGNORE_ME);//cone was 5

				}
			if((car_velocity > 15) && (car_velocity <= 25))//10 to 15 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(20,0, 270),SCAN_ENTS + IGNORE_ME);//was 5
	
				}	
			if((car_velocity > 25) && (car_velocity <= 35))//15 to 20mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,360),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 35) && (car_velocity <= 45))//20 to 25 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,450),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 45) && (car_velocity <= 55))//25 to 30 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,540),SCAN_ENTS + IGNORE_ME);
		
				}
			if((car_velocity > 55) && (car_velocity <= 65))//30 to 35 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,630),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 65) && (car_velocity <= 75))//35 to 40 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0, 720),SCAN_ENTS + IGNORE_ME);
			
				}	
			if((car_velocity > 75) && (car_velocity <= 85))//40 to 45
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0, 810),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 85) && (car_velocity <= 95))//45 to 50
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,900),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 95) && (car_velocity <= 105))//50 to 55 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,990),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 105) && (car_velocity <= 1080))//55 to 60 mph
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,675),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 115) && (car_velocity <= 1170))//60 to 65
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,1260),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 125) && (car_velocity <= 135))//65 to 70
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,1350),SCAN_ENTS + IGNORE_ME);
			
				}
			if((car_velocity > 135) && (car_velocity <= 145))//70 to 75
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,1440),SCAN_ENTS + IGNORE_ME);
				
				}
			if((car_velocity > 145) && (car_velocity <= 155))//75 to 80
 			 	{
 			 	c_scan(camera.x,camera.pan,vector(3,0,1530),SCAN_ENTS + IGNORE_ME);
			
				}
		}

		/////////////////////////////////////////////////////////////
		//  ACTIONS  for lessons
		//
		////////////////////////////////////////////////////////////// 
		//
		//text for getstarted Lesson 1 assigned to stopsign2119 behavior
		//
	
		/////////////////////////////////////////////////
		//  Car action  Player_Car                     //
		//  Should be set in WED, or called from       //
		//  another function                           //
		/////////////////////////////////////////////////
	
	
action signalflashing //assign to lightbulbs
{
	
	while(1)
	{
		my.INVISIBLE = ON; //hide
		wait(-1); // wait one second
		my.INVISIBLE = OFF;
    	wait(-1);
   }
    
}	


/////////
///LESSON 1 Get Started
/////////
	action textLesson1()     //assigned to stopsign in getstarted level
		{
			clearInstructText();
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			throttle = 0;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			rpm = 550;
		
			Throttle_Toggle = 3;
			snd_stop(engsound); 
			
		while((startup01_logo1_pan.VISIBLE == ON) || (startup01_logo2_pan.VISIBLE == ON))
				{
				mouse_mode = 0;
				wait(1);
				}	
if(showselectwheelpedalset == 0)//default show only first getstarted
{				
selectwheelpedalset_pan.VISIBLE = ON;//show dialog
displayG27G29SEL_pan.VISIBLE = ON;
displayT150T300UNSEL_pan.VISIBLE = ON;
displayTMXTMXProUNSEL_pan.VISIBLE = ON;
closewheelpedalset_pan.VISIBLE = ON;//show close button
showselectwheelpedalset = 1;//no show from now on
}
	var	old_mouse_mode;
			old_mouse_mode = mouse_mode;
			saveLoad00_tmp_mouse_bmp = mouse_map;
			mouse_map = saveLoad00_load_mouse_bmp;
			
		while(selectwheelpedalset_pan.VISIBLE == ON)
			{
  			mouse_mode = 1;
    		MOUSE_POS.X = mouse_cursor.x;
    		MOUSE_POS.Y = mouse_cursor.y;
    		wait(1);
  			}
  		//	else
  		//	{break;}
			wait(-.5);
			freeze_mode = 0;
  			mouse_mode = 0;
		
		//	getstartedflag += 0;//flag to stop showing days remaining
		//Run pressbrake only if G27 is used
		//G29 brake is joy_rot.x; G920 is joy_raw.z
		while (1)
				{
					 if((int(joy_raw.z) < 100) && (displayG27G29flag == 1)) || 
					 (int(joy_rot.x < 100) && (displayT150T300flag == 1)) || 
					 (int(joy_rot.x < 100) && (displayTMXTMXProflag == 1)) //accel pedals setting both wheels
					 //resets acclerator to 0
					 //if( int(joy_rot.x) > 0 )//for T150 throttle requires value > 0 to show msg
					 //if( int(joy_raw.y) < 100 ) //brake for T150
					 //if( int(joy_raw.z) < 100 )//throttle for G29
					 //Less than 0 no good
					 	{
					 	//freeze_mode = 1;
					 	pressbrake_txt.VISIBLE = ON;//changed to accelerator in text
					 //	wait(-.5);
					 	//pressbrake_txt.VISIBLE = OFF;
						}
					else
						{break;}//joy_raw.z other than => 100
					
					wait(-.5);
					freeze_mode = 0;
				}
			pressbrake_txt.VISIBLE = OFF;
			//
			//RESET TO ZERO FOR DEMO if KEYBOARD USED
			
			Throttle_Toggle = 2;
			Steering_Toggle = 2;
			
	
		//// Driver Information
		////
			drivernamelabel_txt.VISIBLE = ON; //enter name input after NAME
			driverinfo_pan.VISIBLE = ON;//dialog for driver info
			idnumberlabel_txt.VISIBLE = ON;//enter id number
			inkey(drivername_str);//enters keyboard input
			inkey(idnumber_str);
			str_cpy(filename_str,drivername_str);//copy name to filename
			str_cat(filename_str,idnumber_str);//add id to name
			
			driverinfo_pan.VISIBLE = OFF;
			drivernamelabel_txt.VISIBLE = OFF;
			idnumberlabel_txt.VISIBLE = OFF;
			
			//Show display options
			//
			
				
		
			scenariosummflag = 0;
			alertsflag = 0;//default show; 1 = no show
			performflag = 0;//default show; 1 = no show
			verbalflag = 0;//0 = verbalize; 1 = no verbalize resetflag if re-start
			instructionsflag = 0;
			//
			displaydistractflag = 1; //for reset when getstarted reloads
			//
			seldisplayoptions_pan.VISIBLE = ON;
			closedisplayoptions_pan.VISIBLE = ON;
			alertswarnsSEL_pan.VISIBLE = ON;
			performmeasuresSEL_pan.VISIBLE = ON;
			instructionsSEL_pan.VISIBLE = ON;
			scenariosummSEL_pan.VISIBLE = ON;
			displayDistractUNSEL_pan.VISIBLE = ON;//default de-selected, flag = 1
			verbalizeSEL_pan.VISIBLE = ON;
	
	//Set butons on sel trans veh page
	
	
			
	
		//	var	old_mouse_mode;
		//	old_mouse_mode = mouse_mode;
		//	saveLoad00_tmp_mouse_bmp = mouse_map;
		//	mouse_map = saveLoad00_load_mouse_bmp;
			
			
			
			while((seldisplayoptions_pan.VISIBLE == ON)  || (selecttransveh_pan.VISIBLE == ON))// // move it over the screen
  			{ 
  			mouse_mode = 1;
    		MOUSE_POS.X = mouse_cursor.x;
    		MOUSE_POS.Y = mouse_cursor.y;
    	
    		wait(1);
  			}
  			mouse_mode = 0;
  				////
		////Full Screen Viewing
		////
		fullscreenviewing_pan.VISIBLE = ON;
		closefullscreen_pan.VISIBLE = ON;
		
		var	old_mouse_mode;
			old_mouse_mode = mouse_mode;
			saveLoad00_tmp_mouse_bmp = mouse_map;
			mouse_map = saveLoad00_load_mouse_bmp;
			
		while(fullscreenviewing_pan.VISIBLE == ON)// // move it over the screen
  			{ 
  			mouse_mode = 1;
    		MOUSE_POS.X = mouse_cursor.x;
    		MOUSE_POS.Y = mouse_cursor.y;
    		wait(1);
    		}
		mouse_mode = 0;
		wait(-.2);
		////
  		
  			//if(int(joy_rot.x) > 0)
  				//{
				//Throttle_Toggle = 0;
				//}
			//snd_stop(engsound); 
			//if()
			///
			//Calibrate pedals
			//
			//NOT REQUIRED FOR DEMO with KEYBOARD
			//
			//if(throttle_toggle = 2)
				//{
					//while ((int(joy_rot.x) == 0) && (selecttransveh_pan.VISIBLE == OFF))
					//{
					//if ((int(joy_rot.x) == 0) && (selecttransveh_pan.VISIBLE == OFF))
					 	//{
					 	//pressbrake_txt.VISIBLE = ON;
					 	//wait(-.5);
					 	//pressbrake_txt.VISIBLE = OFF;
						//}
					//else{break;}
					//wait(-.5);
				//	}
				//}
		
			Eng_Snd_On = 1;
			enghandle = snd_loop (engsound,20, 0);
			//
		//below is for EXM shows user in text what they have chosen
	
			if (selecttransveh_pan.VISIBLE == OFF && selectEXM == 1)
				{
				if((stantrans == 0) && (car_weight == 2600)) //selautopasscar
					{
					selautopasscar_txt.VISIBLE = ON;
					selmanualpasscar_txt.VISIBLE = OFF;
					selautotruck_txt.VISIBLE = OFF;
					selmanualtruck_txt.VISIBLE = OFF;
					}
				if((stantrans == 1) && (car_weight == 2600)) //selmanualpasscar
					{
					selautopasscar_txt.VISIBLE = OFF;
					selmanualpasscar_txt.VISIBLE = ON;
					selautotruck_txt.VISIBLE = OFF;
					selmanualtruck_txt.VISIBLE = OFF;
					}
					
				if((stantrans == 0) && (car_weight == 16000))
					{
					selautopasscar_txt.VISIBLE = OFF;
					selmanualpasscar_txt.VISIBLE = OFF;
					selautotruck_txt.VISIBLE = ON;
					selmanualtruck_txt.VISIBLE = OFF;
					}
				if((stantrans == 1) && (car_weight == 16000))
					{
					selautopasscar_txt.VISIBLE = OFF;
					selmanualpasscar_txt.VISIBLE = OFF;
					selautotruck_txt.VISIBLE = OFF;
					selmanualtruck_txt.VISIBLE = ON;
					}
				}
		
			wait(1);
			
		//	-----------
			//below is for DEMO
		
		if((getstartedflag == 0) && (startdemocount == 1))
			{
		
			filehandle = file_open_read("startcount.txt");
			startcount = file_var_read(filehandle); //read current value
			
			//start count for evaluation copies
			if (startcount <= 1)
				{
				daysremaining9_txt.VISIBLE = ON;
				wait(-4);
				daysremaining9_txt.VISIBLE = OFF;
				}
			if (startcount == 2)
				{
				daysremaining8_txt.VISIBLE = ON;
				wait(-4);
				daysremaining8_txt.VISIBLE = OFF;
				}
			if (startcount == 3)
				{
				daysremaining7_txt.VISIBLE = ON;
				wait(-4);
				daysremaining7_txt.VISIBLE = OFF;
				}
			if (startcount == 4)
				{
				daysremaining6_txt.VISIBLE = ON;
				wait(-4);
				daysremaining6_txt.VISIBLE = OFF;
				}
			if (startcount == 5)
				{
				daysremaining5_txt.VISIBLE = ON;
				wait(-4);
				daysremaining5_txt.VISIBLE = OFF;
				}
			if (startcount == 6)
				{
				daysremaining4_txt.VISIBLE = ON;
				wait(-4);
				daysremaining4_txt.VISIBLE = OFF;
				}
			if (startcount == 7)
				{
				daysremaining3_txt.VISIBLE = ON;
				wait(-4);
				daysremaining3_txt.VISIBLE = OFF;
				}	
			if (startcount == 8)
				{
				daysremaining2_txt.VISIBLE = ON;
				wait(-4);
				daysremaining2_txt.VISIBLE = OFF;
				}	
			if (startcount == 9)
				{
				daysremaining1_txt.VISIBLE = ON;
				wait(-4);
				daysremaining1_txt.VISIBLE = OFF;
				}
			if (startcount == 10)
				{
				daysremaining0_txt.VISIBLE = ON;
				wait(-4);
				daysremaining0_txt.VISIBLE = OFF;
				}
			if (startcount > 10)
				{
				daysremainingNO_txt.VISIBLE = ON;
				wait(-4);
				daysremainingNO_txt.VISIBLE = OFF;
				exit;
				}
			//update file startcount
		filehandle = file_open_write("startcount.txt");
		startcount += 1;
		file_var_write(filehandle,startcount);
		getstartedflag = 1;
		}//end conditional
	
		//below is for EXM
		
		wait(-1);
			//trans and vehicle selected
			selautopasscar_txt.VISIBLE = OFF;
			selmanualpasscar_txt.VISIBLE = OFF;
			selautotruck_txt.VISIBLE = OFF;
			selmanualtruck_txt.VISIBLE = OFF;
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(getstartedL1_wav,100,0);
					}
			
			if(instructionsflag == 0)//show instructions if zero
			{
			getstarted1_txt.VISIBLE = ON;
			wait(-28);
			getstarted1_txt.VISIBLE = OFF;
			}
			
			if(verbalflag == 0)
				{
				snd_stop(instruction_handle);
				} 
				
			wait(-.5);
			
			if(instructionsflag == 0)//show instructions if zero
			{
			getstarted2_txt.VISIBLE = ON;
			wait(-20);
			getstarted2_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON;
			speedexceeddisp.VISIBLE = ON;
			}
			
			if((displaydistractflag == 0) && (seldistractormsg_pan.VISIBLE == OFF))//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
		
			while(1)
			{
				if((alertsflag == 0) && (car_velocity > 79)) //exceeds 45 mph
				{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}			
		}
	}//end action textlesson1
	
	action Player_Car
		{
			//while (screen_hold == 0) {wait (1);}  // Wait for splash screens to finish
			//  Initial values
			if(my.client == 0 ) {player = my;}  // Created on the server if client = 0
			my_type = type_player;
			my.ENABLE_SCAN = ON;    //  So AI cars can detect me
			my_movemode = MODE_DRIVING;
			my.ENABLE_IMPACT = ON; //detection for collision
			//my.ENABLE_DETECT = ON; //enabled for detection of scanned vehicles
			my.ENABLE_ENTITY = ON;
		
			my.event = collision_event;
			my.ENABLE_TRIGGER = ON; // Ability to trigger events
			//my.trigger_range = 13; //was 52
			my.PASSABLE = OFF;
			my.scale_x = 1.0;   // Adjust scale factors
			my.scale_y = 1.0;
			my.scale_z = 1.0;
			wait(1);	// wait 1 frame after creation
			//c_setminmax(my);
			//my.z = my.z+1
			wait(1);	// wait 1 frame after creation

		//	vec_set(my.min_x,vector(-20,-20,-20));
		//	vec_set(my.max_x,vector(20,20,20)); 
			
			disable_z_glide = 1;
			movement_scale = 1.00;
			actor_scale = 1.00;
			//my_speed_x = 0;
			Old_MyZ = my.z;   // Initialize previous height with current height
			ESC_text.pos_x = 55;
			ESC_text.pos_y = 625;
			
			
			steering_text.pos_x = 55; 
			steering_text.pos_y = 637;
			throttle_text.pos_x = 55; 
			throttle_text.pos_y = 649;
			geardisp.pos_x = 205;
			geardisp.pos_y = 610;
			
			throttle = 0;
			followtooclose = 0;
			drivereverse = 0;
			noturnsignalcount = 0;
			numcollisions = 0;
			speedexceed = 0;
			brakeRT = 0;
			brakeRT2 = 0;
			brakeRT3 = 0;
			brakeRT4 = 0;
			brakeRT5 = 0;
			latdev = 0;
			snd_stopall(4);//was 1
			//mouse_mode = 0;   // Hide mouse pointer
			//mouse_map = null; // Hide mouse pointer
			car_init();  //  Initialize variables
			
			backoff_txt.VISIBLE = OFF; 
			keeppace_txt.VISIBLE = OFF; 
			speedlimit_txt.VISIBLE = OFF; 
			speedexceed_txt.VISIBLE = OFF;
			speedslowdisp.VISIBLE = OFF;
			overroadedgedisp.VISIBLE = OFF;
			overmediandisp.VISIBLE = OFF;
			overmedian_txt.VISIBLE = OFF;
			overroadedge_txt.VISIBLE = OFF;
			slowspeedwarn_txt.VISIBLE = OFF;
			speedexceed_txt.VISIBLE = OFF;
			speedslow_txt.VISIBLE = OFF;
			
			noturnsignalcountdisp.VISIBLE = OFF;
			numcollisionsdisp.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			speedexceeddisp.VISIBLE = OFF;
			
			endscenariopressESC_txt.VISIBLE = OFF;
			collision_txt.VISIBLE = OFF;
			numcollisions_txt.VISIBLE = OFF; 
			
			turnleftprkingtobrdwy_txt.VISIBLE=OFF;
			
			turnrtbrdwytofirst_txt.VISIBLE=OFF;

			turnleftfirsttomain_txt.VISIBLE=OFF;

			turnrightmaintomrkt_txt.VISIBLE=OFF;
				
			turnrightmrkttocenter_txt.VISIBLE = OFF;
			turnrtctrtofirst_txt.VISIBLE=OFF;
			turnleftfirsttomain_txt.VISIBLE=OFF;
			proceedthrusecondave_txt.VISIBLE = OFF;
			proceedthruthirdave_txt.VISIBLE = OFF;
			turnrightmaintofourth_txt.VISIBLE=OFF;
			proceedthrubrdwy_txt.VISIBLE=OFF;
			turnrightfourthtocommerce_txt.VISIBLE=OFF;
			proceedthrufirstave_txt.VISIBLE = OFF;
			turnrightcommercetomrkt_txt.VISIBLE=OFF;
			turnrightmrkttobrdwy_txt.VISIBLE=OFF;
			proceedthrufirstbrdwy_txt.VISIBLE=OFF;
			turnrightprkingbrdwy_txt.VISIBLE=OFF;
			endscenariopressESC_txt.VISIBLE=OFF;
			turnrightctrto3rd_txt.VISIBLE = OFF;
			procbrdwythrufirst_txt.VISIBLE=OFF;
			turnrightmaintomrkt_txt.VISIBLE=OFF;
				
			endscenariopressESC_txt.VISIBLE=OFF;
			turnrightglenwood_txt.VISIBLE=OFF;
			turnrightparkplace_txt.VISIBLE=OFF;
			turnrightwestrd_txt.VISIBLE=OFF;
			turnrightsouthrd_txt.VISIBLE=OFF;
			enterfrwyonright_txt.VISIBLE=OFF;
			movetocenterlane_txt.VISIBLE=OFF;
			movetorightlane_txt.VISIBLE=OFF;
			exitfrwyright_txt.VISIBLE=OFF;
			
			turnleftPineTree_txt.VISIBLE=OFF;
			
			displaydistractmsg();
			
			while(1) //loop forever
			{
				player_car_move();  // Execute the functions in the action
				update_views();     // Update rear view mirror
				scanvehicles();
				show_hud();
				wait(1);            // Wait one tick, then repeat	
			}   
			
		}   // End of Action Player_Car
action lateraldev
	{
		while(1)
		{
		latdev +=player.x; //((player.x-player.y)*(player.x-player.y))/8;
		meanlatdev += latdev/total_secs;
		}
		wait(-1);
	}
	
action redfirstcycle10 //assign to red, red first trfc signal
{
my.INVISIBLE = OFF;//show red

wait(-13); //show and wait for other signal to show green, yellow	
while(1)
	{
	my.INVISIBLE = ON; //hide red
	wait(-13); // show while other shows green, then yellow
	my.INVISIBLE = OFF;//show red
	wait(-13);
	}
	
}

action redsecondcycle10 //assign to red, if green first trfc signal
{
my.INVISIBLE = ON; //hide
wait(-13); // hide for green, yellow on this signal
	while(1)
	{
	my.INVISIBLE = OFF;
	wait(-13); //show 
	my.INVISIBLE = ON;
	wait(-13); // hide for green, yellow on this signal
	}
}

action redgreencycle10 //assign to green bulb if red first trfc signal
{
my.INVISIBLE = ON; //off
wait(-13);	
	while(1)
	{
	my.INVISIBLE = OFF; //off	
	wait(-10); //show green for 10 second when other bulb is red
	my.INVISIBLE = ON;
	wait(-16); // hide for yellow, red on this trfc signal
	}
}

action redyellowcycle3  //assign yellow,use for red first trfc signal, on after red/green
{
my.INVISIBLE = ON;//
wait(-23); //wait for red/green
		while(1)
		{
		my.INVISIBLE = OFF;
		wait(-3); // show 3 second
		my.INVISIBLE = ON;//
		wait(-23); //	hide waiting for red, green	this signal
		
		}
}

action greenyellowcycle3  //assign yellow, use for green first trfc signal, on after green
{
my.INVISIBLE = ON;
wait(-10); //hide waiting for green this signal
		while(1)
		{
		my.INVISIBLE = OFF;
		wait(-3); // show 3 second
		my.INVISIBLE = ON;
		wait(-23);//hide for red, green

		}
}

action greenfirstcycle10 //assign green, if green first
{
my.INVISIBLE = OFF;
wait(-10); //on for 10 sec	
	while(1)
	{ 
	my.INVISIBLE = ON; //off
	wait(-16); // hide for yellow,red
	my.INVISIBLE = OFF;
	wait(-10); //on for 10 sec
	}
}

action writeL1vars()  //assign to stop sign
	{
		numcollisions = 0;
		speedexceed = 0;
		noturnsignalcount = 0;
		followtooclose = 0;
		brakeRT = 0;
		latdev = 0;
		meanlatdev = 0;
		
		while(1)
				{
					if(key_esc) //
						{
						//meanlatdev = latdev/total_secs;
					//	str_cpy(dummyname_str,"               ");
					//	str_cpy(dummyname_str, filename_str);
					//	str_cpy(scenarioname_str,"L1GetStart");
						
						
					//	str_cat(dummyname_str,"L1GetStart");
					//	str_cat(dummyname_str,text_str);	
						str_cpy(dummyname_str,"               ");
						str_cpy(scenarioname_str,"");
						str_cpy(dummyname_str, filename_str);
						
						str_cpy(scenarioname_str,"L1GetStart");
						str_cat(dummyname_str,"L1GetStart");
						str_cat(dummyname_str,text_str);	
					
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L1Getstarted ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev:");
						file_str_write(filehandle,",");
						file_var_write(filehandle, latdev);
					
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						}
				wait(1);
				}
		}
	action speedlimit45 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			wait(-5);
			while(1)
			{
				if(car_velocity > 80) //exceeds 45 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
	action speedlimit45warn
	{
		wait(-5);
		while(1)
			{
				if((car_velocity > 80) && (alertsflag == 0)) //exceeds 45 mph
				{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}
	}		
	
		action splimit45L29 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			//wait(-11);
			while(1)
			{
				if(car_velocity > 80) //exceeds 45 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}

	action splimit45warnL29
		{
			wait(-5);
			while(1)
			{
				if((car_velocity > 80) && (alertsflag == 0))//&& (player.y > 2690) && (player.x > -5320)//exceeds 45 mph
				{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}		
		}
		action splimit45L28 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			wait(-5);
			while(1)
			{
				//north section straight
				if((car_velocity > 82) && (player.x < 22000) && (player.x > -10144) && (player.y > 2672) && (player.y < 2896))//exceeds 45 mph
				{
					speedexceed += 1;		
				}
				if((car_velocity < 60) && (player.x < 22000) && (player.x > -9144) && (player.y > 2672) && (player.y < 2896))//below 40 mph
				{
					speedtooslow += 1;
				}
				
				//south section straight
				
				if((car_velocity > 82) && (player.x < 17760) && (player.x > 3800) && (player.y > -5184) && (player.y < -4720))//exceeds 45 mph
				{
					speedexceed += 1;		
				}
				//too slow
				if((car_velocity < 60) && (player.x < 17760) && (player.x > 3800) && (player.y > -5184) && (player.y < -4720))//below 40 mph
				{
					speedtooslow += 1;
				}
				
				wait(-1);
			}			
		}
		action splimit45warnL28
		{
			wait(-5);
			while(1)
			{
				//north section
			if((car_velocity > 82) && (alertsflag == 0) && (player.x < 22000) && (player.x > -10144) && (player.y > 2672) && (player.y < 2896))	
				{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
			//too slow
			//
			if((car_velocity < 60) && (alertsflag == 0) && (player.x < 22000) && (player.x > -9144) && (player.y > 2672) && (player.y < 2896))	
				{	
					slowspeedwarn_txt.VISIBLE = ON;
					wait(-3);
					slowspeedwarn_txt.VISIBLE = OFF;	
				}
				//south section
			if((car_velocity > 82) && (alertsflag == 0) && (player.x < 17760) && (player.x > 3800) && (player.y > -5184) && (player.y < -4720))//exceeds 45 mph
					{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
				//too slow
			if((car_velocity < 60) && (alertsflag == 0) && (player.x < 17760) && (player.x > 3800) && (player.y > -5184) && (player.y < -4720))//below 40 mph
					{	
					slowspeedwarn_txt.VISIBLE = ON;
					wait(-3);
					slowspeedwarn_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}		
		}
	action speedlimit65 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			wait(-5);
			while(1)
			{
				if(car_velocity > 110) //exceeds 65 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
		action speedlimit65L29 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			wait(-5);
			while(1)
			{
				if((car_velocity > 110) && (player.y < -4910) && (player.y > -12704)) //exceeds 65 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
	
	action speedlimit65warn
		{
			wait(-5);
			while(1)
			{
				if((car_velocity > 110) && (alertsflag == 0))//exceeds 65 mph
				{	
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}		
		}
		//
		//speed violation as event
		//
/*		action speedlimit25 //assigned to speed25mph_mdl_2372
		{
			speedloop:
			while(1)
			{
				if(car_velocity > 42)//exceeds 25 mph
				{
					speedexceed += 1;	
					break;
				}
				wait(-1);
			}
			while(1)
			{
				if(car_velocity < 42) 
				{
					goto speedloop;
				}
				else
				{
					speedexceed +=0;
				}
				wait(-1);
			}	
					
		}
	*/
	action speedlimit25L28 //assigned to sign
		{	
			wait(-5);
			while(1)
			{
				//north section first set curves
				if((car_velocity > 47) && (player.x > 25472))//exceeds 25 mph
				{
					speedexceed += 1;		
				}
				//north section
				if((car_velocity < 24)  && (player.x > 25472))//below 20 mph
				{
					speedtooslow += 1;		
				}
				//
				//south section first set curves
				//speed too fast
				if((car_velocity > 47) && (player.x > 20930) && (player.y < 800)  && (player.y > -5120))//exceeds 25 mph
				{
					speedexceed += 1;		
				}
				//south section first set curves
				//slow speed
				if((car_velocity < 24)  && (player.x > 20930) && (player.y < 800)  && (player.y > -5120))//below 20mph
				{
					speedtooslow += 1;		
				}
					//
				//South section last curves
				//
					if((car_velocity > 47)  && (player.x > -8400) && (player.x < 16) && (player.y < -5247)  && (player.y > -10300))//exceeds 25 mph
				{
					speedexceed +=1;	
				}
				//
				//slow speed
				//
				if((car_velocity < 24) && (player.x > -8400) && (player.x < -800) && (player.y < -5247)  && (player.y > -10300))//below 20 mph
				{
					speedtooslow +=1;
					
				}
				wait(-1);
			
			}			
		}//end action
		
		action speed25L28warn //assigned to speed25mph_mdl_2372
		{
			wait(-5);
			while(1)
			{	
				//North section first set curves
				if((car_velocity > 47)  && (alertsflag == 0) && (player.x > 25472) && (player.y >= 800))//exceeds 25 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;
				}
				if((car_velocity < 27)  && (alertsflag == 0) && (player.x > 25472) && (player.y >= 800))//below 20 mph
				{
					slowspeedwarn_txt.VISIBLE = ON;
					wait(-3);
					slowspeedwarn_txt.VISIBLE = OFF;		
				}
				//South section first set curves
					if((car_velocity > 47)  && (alertsflag == 0) && (player.x > 20930) && (player.y < 800)  && (player.y > -5120))//exceeds 25 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;		
				}
				//
				//slow speed warn
				//
					if((car_velocity < 24)  && (alertsflag == 0) && (player.x > 20930) && (player.y < 800)  && (player.y > -5120))//below 20mph
				{
					slowspeedwarn_txt.VISIBLE = ON;
					wait(-3);
					slowspeedwarn_txt.VISIBLE = OFF;		
				}
			
				
				//WARNINGS//
				
				//south section last set curves
				//
					if((car_velocity > 47)  &&  (alertsflag == 0) && (player.x > -8400) && (player.x < 16) && (player.y < -5247)  && (player.y > -10300))//exceeds 25 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;		
				}
				//slow speed warn
					if((car_velocity < 24)  && (alertsflag == 0) && (player.x > -8400) && (player.x < 16) && (player.y < -5247)  && (player.y > -10300))//exceeds 25 mph
				{
					slowspeedwarn_txt.VISIBLE = ON;
					wait(-3);
					slowspeedwarn_txt.VISIBLE = OFF;	
				}
				wait(-1);
			}			
		}//end action
		
			
			action speedlimit25 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			wait(-5);
			while(1)
			{
				if(car_velocity > 47) //exceeds 30 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
		action speedlimit25warn //assigned to speed25mph_mdl_2372
		{
			wait(-5);
			while(1)
			{
				if((car_velocity > 47)  && (alertsflag == 0))//exceeds 25 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;		
				}
				wait(-1);
			}			
		}
	action speedlimit20 //assigned to speed sign
		{
			wait(-5);
			while(1)
			{
				if(car_velocity > 40) //exceeds 20 mph by 5 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
	action speedlimit20warn //assigned to speed20mph
		{
			wait(-5);
			while(1)
			{
				if((car_velocity > 40)  && (alertsflag == 0))//exceeds 20 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;		
				}
				wait(-1);
			}			
		}	
	
	action speedlimit30 //assigned to bhouse1_mdl_2324 or generalstore.mdl
		{
			
			while(1)
			{
				if(car_velocity > 50) && (player.x > 25936) //exceeds 25 mph
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
		}
	action speedlimit30warn //assigned to speed25mph_mdl_2372
		{
			
			while(1)
			{
				if((car_velocity > 50)  && (alertsflag == 0) && (player.x > 25936))//exceeds 25 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;		
				}
				wait(-1);
			}			
		}
	action followingevent //asigned to oldhealthpotio_2153 or bwk3 or bhouse13 or 9
	{
		while(1)
		{
		if(event_type == EVENT_SCAN)// && (alertsflag != 0))
			{
			followtooclose + = 1;	
			}
		wait(-1);	
		}
		
	}

		
		/////////////////////////////////////////////
		///	Lesson 2: Following - Move ford pickup so driver can follow
		/////////////////////////////////////////////

		action moveFord() 
		{	
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(followingL2_wav,100,0);
			} 
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson2_txt.VISIBLE = ON;
			wait(-23);
			lesson2_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
		
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			//
			//
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		
			wait(-2);
			
			while(my.y < -8000) //
			{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 400) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 400) && (my.y - player.y < 800) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 800) && (alertsflag == 0)) {keeppace_txt.VISIBLE = ON;}
				wait(1);  //backoff_txt.VISIBLE = OFF; backoff_txt.VISIBLE = OFF; backoff_txt.VISIBLE = ON; 
			}
			
			
			while(my.y < 2000)    //after 1250 but before 2000, slow down
			{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE + ACTIVATE_TRIGGER); // move ahead until end
				if ((my.y - player.y < 475) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 475) && (my.y - player.y < 875) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 975) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);
			}//backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF; 
			//lesson2a_txt.VISIBLE = ON; //show intersection instruct text on Player car
			
			while(my.y < 2650) //was 2650, turn brake lights on and decelerate
			{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 700) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 700) && (my.y - player.y < 1500) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1650) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF;
			}
			
			//lesson2a_txt.VISIBLE = OFF;
			
			//wait(-4); // Ford wait at intersection of Pinetree and Ranchhouse Rd.
				while(my.y < 3300) //was 2650, turn brake lights on and decelerate
			{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 840) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 840) && (my.y - player.y < 1980) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1980) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF;
			}
				while(my.y < 4000) //was 2650, turn brake lights on and decelerate
			{
				c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 890) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 890) && (my.y - player.y < 2030) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 2030) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF;
			}
		
			while(my.y < 15000) //accelerate and move
			{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 820) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 820) && (my.y - player.y < 1800) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1800) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON;backoff_txt.VISIBLE = OFF; backoff_txt.VISIBLE = OFF;
			}
			while(my.y < 19000) //was 2650, 
			{
				c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				if ((my.y - player.y < 840) && (alertsflag == 0)){keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 840) && (my.y - player.y < 1980) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1980) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF;
			}
			// after left turn, continue on to Old Bridge road intersection
			while(my.y < 22000)// slow and show brakes between -10200 and -10419
			{
				c_move(my,vector(20*time_step,0,0),nullvector,GLIDE); // slow speed and brake until end
				if ((my.y - player.y < 550) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 550) && (my.y - player.y < 1500) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1500) && (alertsflag == 0)){keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = ON; backoff_txt.VISIBLE = OFF;
			}
			while(my.y < 38300)// slow and show brakes between -10200 and -10419
			{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE); // slow speed and brake until end
				if ((my.y - player.y < 375) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 375) && (my.y - player.y < 875) && (alertsflag == 0)){ keeppace_txt.VISIBLE = OFF;}
				if ((my.y - player.y > 1200) && (alertsflag == 0)){ keeppace_txt.VISIBLE = ON;}
				wait(1);//backoff_txt.VISIBLE = ON;backoff_txt.VISIBLE = OFF;backoff_txt.VISIBLE = OFF;
			}
			backoff_txt.VISIBLE = OFF; 
			keeppace_txt.VISIBLE = OFF;
			collision_txt.VISIBLE = OFF;
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON;
			ent_remove(me);

		}
	
	action writeL2vars()
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			meanlatdevL29 = 0;
			rmse = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L2Follow");
						str_cat(dummyname_str,"L2Follow");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
							file_str_write(filehandle,",");
						file_str_write(filehandle,"L2 Follow ");
							file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
							file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdevL29);
							file_str_write(filehandle,",");
						file_str_write(filehandle," RMSE LatDev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,rmse);
							file_str_write(filehandle,",");
							
						}
				wait(-.1);
				}//end loop
		}//end action
	

		
	action countcollisionevent() //asigned to oldhealthpotio_2153 or bwk2 or bhouse2,4
	{
		while(1)
		{
		if(collision_txt.VISIBLE != OFF)
			{
			numcollisions + = 1;	
			}
		wait(-3);	
		}
		
	}
	
		///
		///The following actions are for Lesson 3 - Passing No Opposing Traffic
		// 

		action moveWithDriverL3() //move cars in Driver lane along RanchHouse Rd.
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			//my.FAT = ON; 
			//my.NARROW = ON;
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			c_setminmax(me);
			c_setminmax(player);
			
			disable_z_glide = 1;
		//	Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
		if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingL3_wav,75,0);//was 100
			} 
		
		if(instructionsflag == 0)
			{
			lesson3_txt.visible = ON;
			wait(-18);
			lesson3_txt.visible = OFF;
			}
			
		if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			//
			//
			while (my.x < -5320)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
					
				}
				wait(1);
			}
			while (my.x < 16500)//was 18500
			{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				
				wait(1);
			}
			ent_remove(me);
			collision_txt.VISIBLE = OFF;
			if(verbalflag == 0)
					{
							snd_stop = navigation_handle;
							navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
				endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
		}	

	action writeL3vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L3PassNoOpp");
						str_cat(dummyname_str,"L3PassNoOpp");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L3PassNoOpp ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_str_write(filehandle,",");
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
	
		
		///
		///The following actions are for Lesson 4 - Passing WITH OPPosing Traffic
		//

action   moveWithDriverL4() //move cars in Driver lane along RanchHouse Rd.
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			//my.FAT = ON; 
			//my.NARROW = ON;
			c_setminmax(me);
			c_setminmax(player);
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingoncomL4_wav,100,0);
			} 
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson4_txt.VISIBLE = ON;
			wait(-23);
			lesson4_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
		
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		//	my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
		
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 550
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			//
			//
			while(my.x < -5320)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 138000)
			{
				c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			ent_remove(me);
			//endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		}
action scenariotimeL4//placed in bhouse2
{
	if((verbalflag == 0) || (instructionsflag == 0))
		{
		wait(-16);
		}
	scenariotime = 0;
	while(1)//5 min duration
		{
		if(scenariotime < 300)
			{
			scenariotime += 1;
			}
		wait(-1);
		else
			{break;}
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
		endscenariopressESC_txt.VISIBLE = ON;
	
}

action moveOncomingL4()  //move oncoming cars along RanchHouse Rd.
		{
			//my.FAT = ON; 
			//my.NARROW = ON;
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			c_setminmax(me);
			
			disable_z_glide = 1;
			while(my.x > -10400)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(20*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		}
action writeL4vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			speedtooslow = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			meanlatdev = 0;
			rmse = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L4PassOpp");
						str_cat(dummyname_str,"L4PassOpp");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L4PassOpp ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						//file_str_write(filehandle," Mean Lat Dev(ft.): ");
						//file_str_write(filehandle,",");
						//file_var_write(filehandle,meanlatdev);
						//file_str_write(filehandle,",");
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
	action writeL460()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L4PassOpp");
						str_cat(dummyname_str,"L4PassOpp");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L4PassOpp ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdev);
						file_str_write(filehandle,",");
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
	action speedlimit40warn()//sp 40 sign
	{
		///if((verbalflag == 0) || (instructionsflag == 0))
		//{
		wait(-6);
	//	}
		
		while(1)
			{
				if(car_velocity > 74) //exceeds 45 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;
				}
				wait(1);
			}			
		}	
	}
	action speedlimit40()//sp 40 sign in L440
	{
		//if((verbalflag == 0) || (instructionsflag == 0))
		//{
		wait(-6);
		//}
		
		while(1)
			{
				if(car_velocity > 74)
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
	}
action speedlimit60warn()//sp 60 sign
	{
	//	if((verbalflag == 0) || (instructionsflag == 0))
	//	{
		wait(-6);
	//	}
			while(1)
			{
				if(car_velocity > 107) //exceeds 60 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-3);
					speedlimit_txt.VISIBLE = OFF;
				}
				wait(1);
			}			
		}	
	}
action speedlimit60()//sp 60 sign in L440
	{
		
		wait(-6);
		
		
		while(1)
			{
				if(car_velocity > 107)
				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
	}
	action endplayermoveL460() //place in b_house1
		{
		
			while(1)
			{
				if (player.x > 20000)
				{
					//endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
				}
				wait(1);
			}
		}
		
action latdevL4()  //placed in ranchouserd sign
{
	//	if((verbalflag == 0) || (instructionsflag == 0))
	//	{
		wait(-5);
	//	}
		
		n4 = 0;
		latdev = 0;
		sumlatdev = 0;
		meanlatdev = 0;
		latdevsq4 = 0;
		rmse = 0;
		
		while(1)//road edge is y 2701
			{
				if((player.y > 2672) && (player.y < 2857) && (player.x > -9183) && (player.x < 147200))
				{
				
					n4 += 1;//increment sample size
					latdev = (player.y - 28) - 2701;//correct for width of car from eyepoint
					sumlatdev += abs((player.y - 28) - 2701);
					meanlatdev = (sumlatdev/n4)/7;
					latdevsq4 += latdev4 * latdev4;
					ms  = latdevsq4/n4;
					rmse = (sqrt(ms))/7;//no negative numbers
				}	
			wait(-.1);
			}
		
}//end of action
		/////////
		///////// Lesson 5 Large SemiTruck Passing 40 MPH 5 MIN TIMED  
		/////////
		action endplayermoveL5()  //place in b_house1
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			while(1)
			{
				if (player.x > 138000)
				{
					//endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					break; 
				}
				wait(1);
			}
		}
		action moveOncomingL5()  //move oncoming cars along RanchHouse Rd.
		{
		//	my.FAT = ON; 
		//	my.NARROW = ON;
		//	vec_set(my.min_x,vector(-15,-15,-15));
		//	vec_set(my.max_x,vector(15,15,15));
			c_setminmax(me);
			
			disable_z_glide = 1;
		
			
			while(my.x > -11200)
			{
				if(player.x > -9500)
				{
					c_move(my,vector(22*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		}
		
	action movesemiTruckL5()  //for lesson 5 truck to-be-passed, moves along ranch house drive
		{
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			c_setminmax(me);
			c_setminmax(player); 
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingtrucksL5_wav,100,0);
			} 
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson5_txt.VISIBLE = ON;
			wait(-23);
			lesson5_txt.VISIBLE = OFF;
			}	
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			while(my.x < 6500)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(-12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 138000)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(-18*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			
			collision_txt.VISIBLE = OFF;
			
		}
	action scenariotimeL5//placed in bhouse2
{
	if((verbalflag == 0) || (instructionsflag == 0))
		{
		wait(-16);
		}
	scenariotime = 0;
	while(1)//5 min duration
		{
		if(scenariotime < 300)
			{
			scenariotime += 1;
			}
		wait(-1);
		else
			{break;}
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
	endscenariopressESC_txt.VISIBLE = ON;
	ent_remove(me);
	
}
	
	action writeL5vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L5PassTruck");
						str_cat(dummyname_str,"L5PassTruck");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
							file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
							file_str_write(filehandle,",");
						file_str_write(filehandle,"L5PassTruck ");
							file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
							file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
							
						file_str_write(filehandle," Follow Too Close(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}

		////
		////
		////Actions for Lesson 6 - Left Turn Light Traffic RURAL
		////
		////
		
	action moveOncomingL6()
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//Throttle_Toggle = 0;
			
			//my.FAT = ON; 
			//my.NARROW = ON;
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			c_setminmax(me);
			c_setminmax(player);
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingtrucksL5_wav,100,0);
			} 
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(turnleftL6_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson6_txt.visible = ON;  //display instructions for lesson 6
			wait(-20);
			lesson6_txt.visible = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			
			//
			//
			//	
			wait(1);	// wait 1 frame after creation
	
			while(my.x < 16000)//was 6500
			{
				if(player.x < 1400)
				{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				
				if(player.y < 500)
				{
					noturnsignal_txt.VISIBLE=OFF;	
					if(verbalflag == 0)
						{
						snd_stop = navigation_handle;
						navigation_handle = snd_play(EndofscenariopressESCkey_wav,50,0);
						}
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					break;
				}
				wait(1);
			}
		//	ent_remove(me);
			noturnsignal_txt.VISIBLE=OFF;	
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,50,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
	
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
		
		}
			
			
action progressinstructL6() //asign to pinetreedsign.mdl or ranchhouse L19
		{
		
			wait(-6);
			
			while(1)
			{
				if((player.x > 2000) && (player.x < 2400))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
					turnleftPineTree_txt.VISIBLE=ON;
					wait(-4);
					turnleftPineTree_txt.VISIBLE=OFF;	
				}
				wait(1);
			}
		}
		
	action turnsignalcheckL6() //check for left turn asign to pinetreedsign.mdl
		{
		
			wait(-6);
			
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
			
				}
				
				if((player.x < 500) && (player.x > -228) && ((joy_6 == 0) || (joy_1 == 0)) && (snd_playing(signal_handle) ==0) && (leftturnsignal == 0))	
				{
				noturnsignalcount += 1;	
				}
				wait(-1);
			}
		}
		
	action   turnsignalcount() //assign to stopsign.mdl or signal
	{
		wait(-6);
		while(1)
			{
			if(noturnsignal_txt.VISIBLE != OFF)
				{
				noturnsignalcount += 1;	
				}
			wait(-1);	
			}
	}
	
	action endscenarioL6 //in stop sign
	{
		wait(-6);//DO NOT REMOVE
		
		while(1)
		{	
			if(player.y < 500)// when play.y less than 500
			{			
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
		
			collision_txt.VISIBLE = OFF;
			break;
			}
		wait(1);
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
	}
	action writeL6vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L6LftTrnLt");
						str_cat(dummyname_str,"L6LftTrnLt");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L6LftTrnLt ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}

		////////
		////////Lesson 7 Left Turn Heavy Traffic RURAL see L19 with fog
		////////
		action moveBMWwDRL7()//car behind driver
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			c_setminmax(me);;
			
			while(player.y > 2770)
			{
				my.x = (player.x + 500);
				wait(1);
			}
			ent_remove(me);
		}
		
		action moveOncomingL7()//move oncoming traffic
		{
			fog_color = 0;
			
			c_setminmax(me);
			c_setminmax(player);
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
				if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(turnleftL7_wav,100,0);
					}
			
			if(instructionsflag == 0)
			{
			lesson7_txt.visible = ON;  //display instructions for lesson 7
			wait(-22);
			lesson7_txt.visible = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON; //label for count
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
			while(my.x < 24000)//was 23000 was 6500 was 30, oncoming exceeds 24000 x then stop
			{
				if(player.x < 1400)//start when player nears turn
				{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				if(player.y < 500)
				{
					noturnsignal_txt.VISIBLE=OFF;	
					if(verbalflag == 0)
						{
						snd_stop = navigation_handle;
						navigation_handle = snd_play(EndofscenariopressESCkey_wav,50,0);
						}
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					break;
				}
				wait(1);
			}
			noturnsignal_txt.VISIBLE=OFF;	
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
		
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			ent_remove(me);
			collision_txt.VISIBLE = OFF;
		}//end action oncomingL7
		
action endscenarioL7 //in street name Ranchouse Rd sign OUT
	{
		wait(-6);
		
		while(1)
		{	
			if(player.y < 500)// when play.y less than 500
			{			
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			break;
			}
		wait(1);
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
	}		

action progressinstructL7() //check for left turn assign to stop sign 2176
		{
			
			//if((verbalflag == 0) || (instructionsflag == 0))
			//{
			wait(-6);
			//}
			
			while(1)
			{
				if((player.x > 2000) && (player.x < 2400))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
					turnleftPineTree_txt.VISIBLE=ON;
					wait(-4);
					turnleftPineTree_txt.VISIBLE=OFF;
				}
				
				wait(-1);
			}
		}	
	action turnsignalcheckL7() //check for left turn asign to village rd sign
		{
			
			wait(-6);//do not remove
			
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
				}
				if((alertsflag == 0) && (player.x < 500) && (player.x > -228) && (joy_6 == 0) && (snd_playing(signal_handle) == 0) && (leftturnsignal == 0))	
				{
				noturnsignalcount += 1;	
				}
				wait(-1);
			}
		}
	action writeL7vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
		while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L7LftTrnHvy");
						str_cat(dummyname_str,"L7LftTrnHvy");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L7LftTrnHvy ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						}
				if(endscenario_txt.VISIBLE == ON)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L7LftTrnHvy");
						str_cat(dummyname_str,"L7LftTrnHvy");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L7LftTrnHvy ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
		////////
		//////// Lesson 8  Diagonal Parking RURAL
		////////
		action moveWithDriverL8() //move cars passed parked Driver
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			wait(1);	// wait 1 frame after creation
			
			c_setminmax(me);
			c_setminmax(player);
			
		//	Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
				if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(diagonalparkL8_wav,50,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson8_txt.VISIBLE = ON;
			wait(-20);
			lesson8_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
			while (my.y > -11600)
			{
				if(player.x < 4580 || my.y < -8400)
				{
					c_move(my,vector(5*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);	
			}
			
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
				
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
		}
		action writeL8vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L8DiagPark");
						str_cat(dummyname_str,"L8DiagPark");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L8DiagPark ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
		////////
		//////// Lesson 9  Parallel Parking RURAL
		////////
		//////// 
		action textlesson9() //in general store 
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//my.FAT = ON; 
			//my.NARROW = ON;
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			//clearInstructText();
			//Throttle_Toggle = 0;
			
			//
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
				if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(parallelparkurbanL9_wav,100,0);
					}
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson9_txt.VISIBLE = ON;
			wait(-31);
			lesson9_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}

			if(displaydistractflag == 0)//show display distract if flag is 0
				{
				 distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			c_setminmax(player);
		}
	action writeL9vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L9ParaPark");
						str_cat(dummyname_str,"L9ParaPark");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L9ParaPark ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}

		////////
		//////// Lesson 10 Construction Hazard URBAN  
		////////

		action moveTolandL10() //Lesson 10 move Toyota Landrover into 4 lane roadway
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			c_setminmax(my);
			//c_setminmax(player);
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(constrhazardL10_wav,100,0);
					}
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson10_txt.VISIBLE = ON;
			wait(-20);
			lesson10_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
		
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while (my.y > -20900)
			{
				if(player.y < -17800)
				{
					c_move(my,vector(7*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
				if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		} 
		action writeL10vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(fullscreen == 1)//FULL SCREEN
					{
					followtooclose_txt.pos_x = 650;//label horiz
					followtooclose_txt.pos_y = 570;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 570;
					}
					if(fullscreen == 0)//WINDOWED
					{
					followtooclose_txt.pos_x = 630;//label horiz
					followtooclose_txt.pos_y = 610;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 610;
					}
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L10ConstrHzrd");
						str_cat(dummyname_str,"L10ConstrHzrd");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L10ConstrHzrd ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
		action endplayermoveL10()
		{
			fog_color = 0;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(1)
			{
				if (player.y > -20700)
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					break; 
				}
				wait(1);
			}
			if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}	
			
		}  	
		action animateManL10()
		{
			c_setminmax(my);
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -370) //move man until end
			{
				if (player.y < -17350) //trigger walk man from roadside
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 3 * time_step; // 2 = walk animation speed
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(.9*time,0,0),nullvector,IGNORE_YOU|GLIDE);
				}
				wait(1);
			}
		}
		action moveAppCarsL10 //assign to all oncoming traffic
		{
		///	my.FAT = ON; 
		///	my.NARROW = ON;
			c_setminmax(my);
			//c_setminmax(player);
			while(my.y < -11000)
			{
				if (player.y < -13600)
				{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action moveMerzvan()
		{
			//c_setminmax(me);
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			vec_set(my.min_x,vector(-19,-19,-15));
			vec_set(my.max_x,vector(19,19,15));
			
			while(my.y > -24500)
			{
				if (player.y < -18140) //was -18176
				{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
		}
			
		////
		///
		///Actions for LESSON 11  Slow VAN Stalled Traffic Urban
		///
		///
		action moveMercedesVanL11() //move Van slowly away from driver
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
				if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(vanaheadL11_wav,100,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson11_txt.VISIBLE = ON;
			wait(-23);
			lesson11_txt.VISIBLE = OFF;
			}
			//
			//data display
			//
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y > -17000)
			{
				if (player.y < -12600)
				{
					c_move(my,vector(5*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);	
			}
		//	ent_remove(me);
		}


		action moveaudittAppCarsL11() //move audi towards driver
		{
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-15));
			vec_set(my.max_x,vector(20,20,15));
			
			while(my.y < -11000)
			{
				if (player.y < -12600)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action moveAppCarsL10L11() //assign to all apposing traffic
		{
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y < -11000)
			{
				if (player.y < -12600)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action moveWithDriverL11() //assign to all traffic flowing With Driver in passing lane
		{
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-15));
			vec_set(my.max_x,vector(20,20,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		
			disable_z_glide = 1;
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -12600)
				{
					c_move(my,vector(14*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action writeL11vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(fullscreen == 1)//FULL SCREEN
					{
					followtooclose_txt.pos_x = 650;//label horiz
					followtooclose_txt.pos_y = 570;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 570;
					}
					if(fullscreen == 0)//WINDOWED
					{
					followtooclose_txt.pos_x = 630;//label horiz
					followtooclose_txt.pos_y = 610;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 610;
					}
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L11SlowVeh");
						str_cat(dummyname_str,"L11SlowVeh");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L11SlowVeh ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL11End() //assign to White Citreon with Driver traffic
		{
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y > -10000) //while position is greater than -16800, continue moving
			{
				if (player.y < -15600)
				{
					c_move(my,vector(14*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
		//	ent_remove(me);
			if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		}

		//////
		////// LESSON 12 ROAD HAZARD URBAN
		//////
		
		action moveAppCarsL12() //assign to all oncoming traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
		if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(hazardsL12_wav,100,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson12_txt.VISIBLE = ON;
			wait(-22);
			lesson12_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			brakeRT_txt.VISIBLE = ON;
			brakeRTdisp.VISIBLE = ON;
			}
			
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y < -11000)
			{
				if (player.y < -12600)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
			
		}
	action resetperformdataL12()
		{
			while(1)
			{
				if(fullscreen == 1)//Full SCREEN
				{
				brakeRT_txt.pos_x = 650; //was 570
				brakeRT_txt.pos_y = 580;//was 560
				brakeRTdisp.pos_x = 806;     // Position the  display was 165
				brakeRTdisp.pos_y = 580;   // Use 4 and 600 for 1024
				}
				if(fullscreen == 0)//Windowed
				{
				brakeRT_txt.pos_x = 630; //was 570
				brakeRT_txt.pos_y = 620;//was 560
				brakeRTdisp.pos_x = 806;     // Position the  display was 165
				brakeRTdisp.pos_y = 620;   // Use 4 and 600 for 1024
				}
			wait(1);	
			}
			
		}//end action
		
	action animateRedFemaleL12()
		{
			hasbraked = 0;
			BrakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			while(my.y > -19600)
			{
				if (player.y < -17968) //trigger walk female
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					//ent_animate(my, "stand", 0, 0);
					c_move (me,nullvector,vector(0,-6*time,0),IGNORE_YOU|GLIDE); //x10
					}
				wait(-.1);            
			}
			ent_remove(me);
		}	
		action animateManL12()
		{
			hasbraked = 0;
			BrakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			while(my.x < -70)
			{
				if (player.y < -19050) //trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					//ent_animate(my, "stand", 0, 0);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x10
					}
				if((my.x > -144)&&(brakepedal >= 0)&&(hasbraked == 0)) //man moves out and no braking indicated
					{
					BrakeRT +=.1;
					}
				if((my.x > -144)&&(brakepedal < 0)) //braking
					{
					hasbraked += 1; //set to has braked
					}
				
				wait(-.1);            
			}
			ent_remove(me);
		}	
		
		action moveWithDriverL12() //assign to all traffic flowing With Driver in passing lane
		{
			//c_setminmax(my);
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			disable_z_glide = 1;
			
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -12600)
				{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		
	
	action greenbmw()
	{
		while(my.y > -30000)//move N on Broadway when lateral ends
		{
			if ((player.y < -20800)	 && (player.x < 265) && (my.x < -112))
			{
				c_move (me,vector(0,9*time,0),nullvector,IGNORE_YOU|GLIDE); //move merz van
				
			}	
			if((player.y < -21371)	&& (player.x < 265) )
			{
				c_move (me,vector(5*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
			}	
		 wait(1);  
	 	}  	
		ent_remove(me);
	}
		action  writeL12vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L12RdHzrd");
						str_cat(dummyname_str,"L12RdHzrd");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L12RdHzrd ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action XTrcRtoL() //assign to audi100ye
		{

			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			while(my.x < -170) //while position is greater than -16800, continue moving
			{
				if (player.y < -20944)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				}
				wait(1);
			}
		}
		action moveWDrivL12End() //assign to toland_gr_g_3081
		{

			//c_setminmax(my);
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			disable_z_glide = 1;
			while(my.y > -22000) //while position is greater than -16800, continue moving
			{
				if (player.y < -12600)
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
		
		}
		action endplayermoveL12()  //place in bwk2
		{
			collision_txt.VISIBLE = OFF;
			while(1)
			{
				if (player.y < -23000)
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
				
					break; 
				}
			wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			ent_remove(me);
		}
		//////
		//////
		////// LESSON 13 LEFT TURN MIDBLOCK URBAN
		//////
		//////
		
		action moveAppCarsL13() //assign to all apposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
		//	clearInstructText();
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(parkingtwolaneL13_wav,100,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson13_txt.VISIBLE = ON;
			wait(-23);	
			lesson13_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			}
		
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			
			while(my.y < -11000)
			{
				if (player.y < -12800)
				{
					c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			
		}
		action moveWithDriverL13() //assign to all traffic flowing With Driver in passing lane
		{
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y > -30000) //while position is greater than -30000, continue moving
			{
				if (player.y < -12800)
				{
					c_move(my,vector(18*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action turnsignalcheckL13() //check for left turn assign to bkw4.mdl
		{
		
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 580;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 580;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 620;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 620;
				}

				if((player.y < -16126) && (player.y > -16854) && (joy_6== 0) && (snd_playing(signal_handle) ==0) && (leftturnsignal==0))	
				{
					noturnsignalcount += 1;	
					
				}
				
				wait(-1);
			}
		}
	action  writeL13vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L13LeftTrnMid");
						str_cat(dummyname_str,"L13LeftTrnMid");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L13LeftTrnMid ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL13End() //assigned toland_gr
		{
			
			//c_setminmax(my);
			 	wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			while(my.y > -14500) //while position is less than -17500, continue moving then END
			{
				if (player.y < -12800)
				{
					c_move(my,vector(13*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to use main menu
			collision_txt.VISIBLE = OFF;
			
		}
		//////
		//////
		////// LESSON 14 Left Intersection Turn URBAN PEDS
		//////
		//////
		
		action moveAppCarsL14() //assign to all apposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			
				wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(pedsxwalkL14_wav,100,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson14_txt.VISIBLE = ON;
			wait(-19);
			lesson14_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //panel num of speedexceed
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
			while(my.y < -11000)
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		action moveWithDriverL14() //assign to all traffic flowing With Driver in passing lane
		{
			fog_color = 0;
			//clearInstructText();
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			wait(-1);
			
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(13*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			
			ent_remove(me);
		}

		action animateManL14()
		{
			var anim_speed = 0;
			my.frame = 1;
			//c_setminmax(my);
			
		//	while(my.y < -11000)
			//{
				//if (player.y < -20100)//start move
				//{
					//my.frame = 0;
					//my.frame += time_step / 16;
					//anim_speed += 1.3 * time_step; // 2 = walk animation speed
					//ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					//ent_animate(my, "stand", 0, 0);
					//c_move (me,vector(.6*time,0,0),nullvector,IGNORE_YOU|GLIDE);
				//}
				//wait(1); 	
			}//
			
		}
		action animateFem2L14()
		{
			var anim_speed = 0;
			my.frame = 1;
			//c_setminmax(my);
			
			while(my.y < -11000)
			{
				if (player.y < -20500)//start move
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 1.3 * time_step; // 2 = walk animation speed
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					//ent_animate(my, "stand", 0, 0);
					c_move (me,vector(.6*time,0,0),nullvector,IGNORE_YOU|GLIDE);
				}
				wait(1); 	
			}
			
		}
		action animateRedFemL14()
		{
			var anim_speed = 0;
			my.frame = 1;
			//c_setminmax(my);
			
			while(my.y < -11000)
			{
				if (player.y < -21000)//start move
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 1.3 * time_step; // 2 = walk animation speed
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					//ent_animate(my, "stand", 0, 0);
					c_move (me,vector(.6*time,0,0),nullvector,IGNORE_YOU|GLIDE);
				}
				wait(1); 	
			}
			
		}
		
		action moveXTrafficL14() //move cross traffic at intersection
		{
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.x < 10000)//while position is less than 10000, continue moving
			{
				if (player.y < -20000)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				
				wait(1);
			}
		}
		action turnsignalcheckL14() //check for left turn assign to bkw1.mdl
		{
		//	if((verbalflag == 0) || (instructionsflag == 0))
		//	{
		//	wait(-16);
		//	}
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 580;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 580;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 620;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 620;
				}
				
				if((player.y < -20370) && (player.y > -21212) && (joy_6== 0) && (snd_playing(signal_handle) ==0) && (leftturnsignal==0))	
				{
					noturnsignalcount += 1;	
				}
				
				wait(-1);
			}
		}
	action  writeL14vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L14LftTrnInter");
						str_cat(dummyname_str,"L14LftTrnInter");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L14LftTrnInter ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL14End() //assign to last moving vehicle to end scenario
		{
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			while(my.y < -22000) //while position is greater than -10000, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(9*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}	
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
		
		} 
		

		//////
		////// LESSON 15 TRAFFIC JAM URBAN
		//////
		
		action moveWithDriverL15() //assign to all traffic flowing With Driver in passing lane
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			//c_setminmax(my);
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
				wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);	
			}
			ent_remove(me);
		}
		action moveAppCarsL15() //assign to all apposing traffic
		{
			//clearInstructText();
			
			wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));

			while(my.y < -11000)
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		action moveWithDrivSlowL15() //assign to all traffic flowing With Driver in passing lane
		{
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.y > -35600) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(5*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
		}
		action moveR2DrivSlowL15() //assign to all traffic flowing With Driver in passing lane
		{
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y > -22800) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
		}
		action moveR1DrivSlowL15() //assign to all traffic flowing With Driver in passing lane
		{
			//clearInstructText();
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y > -22200) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
		}

		action moveL2WDrivSlowL15() //assign to all traffic flowing With Driver in passing lane
		{
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
				my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y > -21600) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			wait(-10);
			while(my.y > -22500) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			
		}
		action moveL1WDrivSlowL15() //assign to all traffic flowing With Driver in passing lane
		{
			fog_color = 0;
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(trafficjamL15_wav,50,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson15_txt.VISIBLE = ON;
			wait(-23);	
			lesson15_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
	
			//noturnsignalcount_txt.VISIBLE = ON;
			//noturnsignalcountdisp.VISIBLE = ON;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y > -21300) //while position is greater than -16800, continue moving
			{
				if (player.y < -19680)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			wait(-10);
			while(my.y > -22000) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			
		}
	action  writeL15vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(fullscreen == 1)//FULL SCREEN
					{
					followtooclose_txt.pos_x = 650;//label horiz
					followtooclose_txt.pos_y = 570;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 570;
					}
					if(fullscreen == 0)//WINDOWED
					{
					followtooclose_txt.pos_x = 630;//label horiz
					followtooclose_txt.pos_y = 610;
					followtooclosedisp.pos_x = 806;//number horiz
					followtooclosedisp.pos_y = 610;
					}
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L15TrafficJam");
						str_cat(dummyname_str,"L15TrafficJam");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L15TrafficJam ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL15End() //assign to toland_gr_g
		{
			fog_color = 0;
			//clearInstructText();
			wait(-15);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			while(my.y < -23000) //while position is greater than -16800, continue moving
			{
				if (player.y < -20200)//start move
				{
					c_move(my,vector(3*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}	
			
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
				
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
		
		}
		
		//////
		////// LESSON 16 RIGHT INTERSECTION TURN URBAN  //OUT
		//////
		
		
		action moveAppCarsL16() //assign to all apposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			//c_setminmax(my);
			
			while(my.y < -11000)
			{
				if (player.y < -17400)  //start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		
		action moveWithDriverL16() //assign to all traffic flowing With Driver in passing lane
		{
			
			fog_color = 0;
			//clearInstructText();
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);	
					instruction_handle = snd_play(rightturnurbanL16_wav,100,0);
					}
					
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson16_txt.VISIBLE = ON;
			wait(-23);
			lesson16_txt.VISIBLE = OFF;
			}
			
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			brakeRT_txt.VISIBLE = ON;
			brakeRTdisp.VISIBLE = ON;
			
			followtooclose_txt.pos_x = 650; //was 570
			followtooclose_txt.pos_y = 570;//was 560
			followtooclosedisp.pos_x = 806;     // Position the  display was 165
			followtooclosedisp.pos_y = 570;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17400)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}	
			ent_remove(me);
		}
		
		action endplayerL16()  //assign to johndeere
		{
			while(1)
			{
				if((player.x < -6560) && (player.y < -21126.000))
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
				
					wait(-.3);
					menu01_show_main();
					var	cur_item;
					cur_item = 1;
					menu01_highlight(cur_item);
					break; 
				}
				wait(1);
			}
				if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
			fog_color = 0;
			ent_remove(me);
		}
		
	action movevan()
	{
		wait(1);	// wait 1 frame after creation
		
		my.FAT = ON; 
		my.NARROW = ON;
		vec_set(my.min_x,vector(-15,-15,-15));
		vec_set(my.max_x,vector(15,15,15));
		hasbraked = 0;
		brakeRT = 0;
		while(my.x > -1800)
			{
				if ((player.y < -21247) && (player.x < -615 ))		//trigger move
					{
					c_move (me,vector(35*time,0,0),nullvector,GLIDE + USE_AABB); //move merz van
					}
				if((my.y < -21255)&&(brakepedal >= 0)&&(hasbraked == 0)) //man moves out and no braking indicated
					{
					brakeRT +=.1;
					}
				if((my.y < -21255)&&(brakepedal < 0)) //braking
					{
					hasbraked += 1; //set to has braked
					}
				if(my.x > -1600 && my.y < -22000)
					{
					c_rotate (me, vector(35,0,0), GLIDE + USE_AABB);
					}
				wait(-.1);            
			}
			
	}
	
	action turnsignalcheckL16() //check for rt turn assign to bkw3.mdl
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(15);
			}
			
			while(1)
			{
				if((player.y < -20370) && (player.y > -21212) && (joy_5== 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
				noturnsignalcount += 1;	
				}
				
				wait(-1);
			}
		}
	action  writeL16vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"RtTrnInter");
						str_cat(dummyname_str,"RtTrnInter");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"RtTrnInter ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL16End() //assign to smart/mdl
		{
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17400)//start move
				{
					c_move(my,vector(5*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		}
		
		//////
		////// LESSON 17 QUICK Parking in Traffic, URBAN
		//////
		
		
		action moveAppCarsL17() //assign to all apposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y < -11000)
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		action moveWithDriverL17() //assign to all traffic flowing With Driver in passing lane
		{
			fog_color = 0;
		//	clearInstructText();
			wait(-1);
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop = instruction_handle;
					instruction_handle = snd_play(quickparkurbanL17_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson17_txt.VISIBLE = ON;
			wait(-33);
			lesson17_txt.VISIBLE = OFF;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
		action  writeL17vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L17QuickPark");
						str_cat(dummyname_str,"L17QuickPark");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L17QuickPark ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL17End() //assign to Tolandgr is in opp trfc
		{

			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			while(my.y < -16000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		} 
		action endplayermoveL17()  //place in bwk1
		{
			while(1)
			{
				if (player.y < -22000)
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
				
					break; 
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			ent_remove(me);
		}

		//////
		////// LESSON 18 Parking in Traffic, Parallel URBAN
		//////
		action moveAppCarsL18() //assign to all apposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y < -11000)
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		action moveWithDriverL18() //assign to all traffic flowing With Driver in passing lane
		{
			fog_color = 0;
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//c_setminmax(my);
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(parallelparkurbanL18_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson18_txt.VISIBLE = ON;
			wait(-22);
			lesson18_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}
	action  writeL18vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L18ParkTrfcPara");
						str_cat(dummyname_str,"L18ParkTrfcPara");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L18ParkTrfcPara ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWDrivL18End() //assign to all traffic flowing With Driver in passing lane
		{
			fog_color = 0;
			//clearInstructText();
			disable_z_glide = 1;
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y < -13000) //while position is greater than -16800, continue moving
			{
				if (player.y < -17900)//start move
				{
					c_move(my,vector(7*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			
		}
		
		action endplayermoveL18()  //place in bwk1
		{
			while(1)
			{
				if (player.y < -22000)
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					
					break; 
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			ent_remove(me);
		}
		//////
		//////
		////// LESSON 19 LEFT TURN RURAL FOG (L7 with FOG)
		//////
		//////
		action moveOncomingL19()
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			
			wait(1);	// wait 1 frame after creation
			
			c_setminmax(player);
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
			fog_color = 4;
			highbeams.VISIBLE = OFF;
			//camera.fog = 100;    //shadows do not appear foggy
			sun_angle.tilt = 90;
			camera.fog_start = 1500;//0.1 * camera.clip_far; //1200; //was 1550		// // fog starts at 80% of clip range
			camera.fog_end = 4500;//was 4500 .90 * camera.clip_far;  //3855;	//was 6855	// // total foggy at 90% of clip range
			camera2_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera2_view.fog_end = 1000;
			camera3_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera3_view.fog_end = 1000;
			camera4_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera4_view.fog_end = 1000;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(leftturnfogL19_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson19_txt.visible = ON;  //display instructions for lesson 6
			wait(-22);
			lesson19_txt.visible = OFF;
			}
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.x < 10200)
			{
				if(player.x < 300)
				{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // was 22 move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
			fog_color = 0;
		}
		
		action turnsignalcheckL19() //check for left turn assign to pine tree sign
		{
		
			wait(-6);
			
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
				}
				if((player.x < 1000) && (player.x > -218) && (joy_6 == 0) && (snd_playing(signal_handle) ==0) && (leftturnsignal == 0))		
				{
					noturnsignalcount += 1;	
				}	
				wait(-1);
			}
		}
		action  writeL19vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L19LftTrnFog");
						str_cat(dummyname_str,"L19LftTrnFog");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L19 Left Turn Fog ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}

		//////
		////// LESSON 20 PASSING TRAFFIC RURAL FOG (L4 with FOG)
		//////
		action   moveWithDriverL20() //move cars in Driver lane along RanchHouse Rd.
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			//my.FAT = ON; 
			//my.NARROW = ON;
			c_setminmax(me);
			c_setminmax(player);
			//vec_set(my.min_x,vector(-15,-15,-15));
			//vec_set(my.max_x,vector(15,15,15));
			
			//disable_z_glide = 1;
			fog_color = 4;
			//camera.fog = 100;    //shadows appear foggy
			sun_angle.tilt = 90;
			camera.fog_start = 0;//2000;// fog starts at 80% of clip range0.10 * camera.clip_far;
			camera.fog_end = 5000;//3000; // total foggy at 90% of clip range 0.30 * camera.clip_far;
			camera2_view.fog_start = 0; //0.10 * camera.clip_far; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera2_view.fog_end = 1000; //0.30 * camera.clip_far;
			camera3_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera3_view.fog_end = 1000;
			camera4_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera4_view.fog_end = 1000;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(passingfogL20_wav,100,0);
					}
			
			if(instructionsflag == 0)
			{
			lesson20_txt.visible = ON;
			wait(-20);
			lesson20_txt.visible = OFF;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			my.ENABLE_SCAN = ON; //allows player to scan this object
			//my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			while(my.x < -5320)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(9*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 19000)
			{
				c_move(my,vector(13*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				wait(1);
			}
			
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
			fog_color = 0;
		}

		action moveOncomingL20()  //move oncoming cars along RanchHouse Rd.
		{
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.x > -11000)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(28*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		}
		action  writeL20vars()  //assign to first ave sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L20PassFog");
						str_cat(dummyname_str,"L20PassFog");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L20PassFog ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
			action endplayermoveL20()  //place in b_house1
		{
			fog_color = 0;
			while(1)
			{
				if (player.x > 17000)
				{
					 //request user to press ESC key
					collision_txt.VISIBLE = OFF;
				
					endscenariopressESC_txt.VISIBLE = ON;
					
					break; 
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			ent_remove(me);
		}
		//////
		//////
		////// LESSON 21 ENTER FRWY
		//////
		//////

		action moveWithDriverL21() //With Driver in both lanes freeway 65 mph LIMIT
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
		
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(freewayentranceL21_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson21_txt.VISIBLE = ON;  //freeway entrance
			wait(-28);
			lesson21_txt.VISIBLE = OFF;
			}
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			//my.event = bounce_event;
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y > -40000) //while position is greater than -30000, continue moving
			{
				if(player.y < 1900)
				{
					c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);	
		}
		action  writeL21vars()  //assign to spruce
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L21EnterFrwy");
						str_cat(dummyname_str,"L21EnterFrwy");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L21EnterFrwy ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWithDrivL21End() //ends scenario, assign to last vehicle
		{
			disable_z_glide = 1;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y > -22000) //while position is greater than -5000, continue moving
			{
				if(player.y < 1900)
				{
					c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);	
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		}
		
		//////
		////// LESSON 22 ENTER FRWY HEAVY TRAFFIC
		//////
	
		action moveWithDrivL22() 
		
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(freewayentryheavyL22_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson22_txt.VISIBLE = ON;  //freeway entrance
			wait(-18);
			lesson22_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 550;//was 540
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y > -40000) //while position is greater than -40000, continue moving
			{
				if(player.y < 1900)
				{
					c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
			
		//	if(verbalflag == 0)
		//		{
		//		snd_stop = navigation_handle;
		//		navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
		//		}
		//	endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
		}
		
		action  writeL22vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L22EnterFrwyHvy");
						str_cat(dummyname_str,"L22EnterFrwyHvy");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L22EnterFrwyHvy ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						}
				if(endscenario_txt.VISIBLE == ON)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L22EnterFrwyHvy");
						str_cat(dummyname_str,"L22EnterFrwyHvy");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L22EnterFrwyHvy ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}

		action moveWithDrivL22End() //ends scenario, assign to last vehicle
		{
			disable_z_glide = 1;
			//c_setminmax(my);
			while(my.y > -22000) //while position is greater than -5000, continue moving
			{
				if(player.y < 1900)
				{
					c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		}
		//Lesson 23 in Directory is Now Night Rural 
		//////
		////// LESSON 23 EXIT FRWY FROM RIGHT LANE//No Longer Used!!!
		//////
		action movewithDrivL23()     //frwy exit from right lane
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(instructionsflag == 0)
			{
			lesson23_txt.VISIBLE = ON;  //freeway entrance
			wait(-15);
			lesson23_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 560;//was 550
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 560;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			my.ENABLE_SCAN = ON; //allow detection by scan
			//my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while (my.y < 5000) 
			{
				c_move(my,vector(60*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);

		}
		action oncomingtrafficL23() //Oncoming in both lanes freeway
		{
			while(my.y > -30000) //while position is greater than -30000, continue moving
			{
				c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				wait(1);
			}
			ent_remove(me);
		}
		
		action movewithDrivL23End()   //frwy exit from right end scenario last vehicle
		{
			disable_z_glide = 1;
			fog_color = 0;
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-16);
			}
		   
		   while (my.y < 3000)  //was -25000
			{
				c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
				
			endscenariopressESC_txt.VISIBLE = ON; //request user to use main menu
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		}
	action turnsignalcheckL23() //check for right turn signal at frwy entry and exit
		{
			wait(-5);
			while(1)
			{
				if((player.y > -7954) && (player.y < -4830) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
				noturnsignalcount += 1;	
				}	
				wait(1);
			}
		}
		
		action movebehndDrivL23()     //auditt set to move with and behind driver
		{
			my.x = player.x;
			my.pan = player.pan;
		}
		action oncomingtrafficL23() //With Driver in both lanes freeway
		{
			wait(-1);
			
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
	
			while(my.y > -30000) //while position is greater than -30000, continue moving
			{
				c_move(my,vector(33*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}	
			ent_remove(me);
		}
		action  writeL23vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"ExitFrwyRt");
						str_cat(dummyname_str,"ExitFrwyRt");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"ExitFrwyRt ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}

		action endplayermoveL23()  //place in bhouse3
		{
			while(1)
			{
				if (player.y > 5000)
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					break;
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			ent_remove(me);
		}
		//////
		////// LESSON 24 EXIT FRWY FROM LEFT or Fast LANE xing to Far Right LAne
		//////
		
		action movewithDrivL24()     //frwy exit from left lane
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			sun_light = 0; 
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
		
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(freewayexitleftlaneL24_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson24_txt.VISIBLE = ON;  //freeway entrance
			wait(-31);
			lesson24_txt.VISIBLE = OFF;
			}
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			
		//	followtooclose_txt.pos_x = 650; //was 570
		//	followtooclose_txt.pos_y = 560;//was 550
		//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
		//	followtooclosedisp.pos_y = 560;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
		
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while (my.y < 10000)//move cars until this is false
			{
				if(player.y > -37755)
				{
				c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);	
			}
			ent_remove(me);
	
		}
		
	action movewithDrivL24End()   //frwy exit end scenario last vehicle
		{
			fog_color = 0;
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			while (my.y < 5000)
			{
				if(player.y > -37755)//move when player moves
					{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE); // move ahead until end
					}
				wait(1);
			}
			
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
				
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		}
	
		action movebehndDrivL24()     //auditt set to move with and behind driver
		{
			my.x = player.x;
		}
			
		action oncomingtrafficL24() //Oncoming in both lanes freeway
		{
			while(my.y < -30000) //while position is greater than -30000, continue moving
				{
					if(player.y > -37755)//move when player moves
					{
					c_move(my,vector(20*time_step,0,0),nullvector,GLIDE); // move ahead until end
					}
					wait(1);
				}
			ent_remove(me);
		}
		action  writeL24vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L24ExitFrwyLft");
						str_cat(dummyname_str,"L24ExitFrwyLft");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L24ExitFrwyLft ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
action turnsignalcheckL24() //check for right turn signal at frwy entry and exit
		{
		
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 580;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 580;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 620;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 620;
				}
				if((player.y > -7954) && (player.y < -4830) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
					noturnsignalcount += 1;	
				}	
				wait(-1);
			}
		}

		//////
		//////
		////// LESSON 25 ENTER FRWY HEAVY TRAFFIC - FOG
		//////
		//////

		action moveWithDriverL25() //With Driver in both lanes freeway
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			highbeams.VISIBLE = OFF;
			//clearInstructText();
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
	
			fog_color = 4; //200,200,200
			///camera.fog = 100;    //shadows appear foggy
			//sun_angle.tilt = 90;
			camera.fog_start = 100; //0		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera.fog_end = 	1200;		//1155 * camera.clip_far; // total foggy at 90% of clip range
			camera2_view.fog_start = 0; 	//was 550	//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera2_view.fog_end = 1200; //was 9855
			camera3_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera3_view.fog_end = 1200;
			camera4_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera4_view.fog_end = 1200;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(freewayentryfogL25_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson25_txt.VISIBLE = ON;  //freeway entrance
			wait(-15);
			lesson25_txt.VISIBLE = OFF;
			}
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			followtooclose_txt.pos_x = 650; //was 570
			followtooclose_txt.pos_y = 550;//was 540
			followtooclosedisp.pos_x = 806;     // Position the  display was 165
			followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.y > -42000) //while position is greater than -30000, continue moving
			{
				c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			
		}
		action  writeL25vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"EnterFrwyFog");
						str_cat(dummyname_str,"EnterFrwyFog");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"EnterFrwyFog ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		action moveWithDrivL25End() //ends scenario, assign to last vehicle
		{
			//wait(-20);
			disable_z_glide = 1;
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			
			while(my.y > -22000) //while position is greater than -5000, continue moving
			{
				c_move(my,vector(34*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
			fog_color = 0;
		}


		
		//////
		////// LESSON 26 FREEWAY EXIT - FOG  (L24 with FOG)
		//////
		
		
		action movewithDrivL26()     //frwy exit from left lane
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 4; //200,200,200
			highbeams.VISIBLE = OFF;
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			//camera.fog = 100;    //shadows appear foggy
			//sun_angle.tilt = 90;

			camera.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera.fog_end = 	1000; // total foggy at 90% of clip range
			camera2_view.fog_start = 0; 	//was 550	//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera2_view.fog_end =1000; //was 1155
			camera3_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera3_view.fog_end = 1000;
			camera4_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera4_view.fog_end = 1000;
			
			disable_z_glide = 1;
		
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(freewayexitleftfogL26_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson26_txt.VISIBLE = ON;  //freeway entrance
			wait(-18);
			lesson26_txt.VISIBLE = OFF;
			}
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			followtooclose_txt.pos_x = 650; //was 570
			followtooclose_txt.pos_y = 560;//was 550
			followtooclosedisp.pos_x = 806;     // Position the  display was 165
			followtooclosedisp.pos_y = 560;   // Use 4 and 600 for 1024
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			//
			//
			while (my.y < 5000) 
			{
				c_move(my,vector(23*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);	
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			ent_remove(me);
		}
		action  writeL26vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"FrwyExitFog");
						str_cat(dummyname_str,"FrwyExitFog");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"FrwyExitFog ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		
		
		action movewithDrivL26End()   //frwy exit from right end scenario last vehicle
		{
			disable_z_glide = 1;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while (my.y < 5200) //was 5200
			{
				c_move(my,vector(20*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			collision_txt.VISIBLE = OFF;
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			ent_remove(me);
			fog_color = 0;
			highbeams.VISIBLE = OFF;
		}
		action endplayermoveL26()  //place in bhouse3
		{
			while(1)
			{
				if (player.y > 5000)
				{
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					
					fog_color = 0; 
					break;
				}
				wait(1);
			}
		}
			//////
		////// LESSON 23 NIGHT DRIVING - RURAL
		//////
		action  writeL27vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L23NightRural");
						str_cat(dummyname_str,"L23NightRural");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L23NightRural ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		
		action setlightingL27()  //assign to Smart car in driveway of bhouse1nt
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			highbeam = 0;//set low beams
			
			fog_color = 5;//night
		
			camera.fog_start = 300; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera.fog_end = 	1555;	//was 1555	//0.9 * camera.clip_far; // total foggy at 90% of clip range
			camera2_view.fog_start = 0; 	//was 550	//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera2_view.fog_end = 255; //was 6855
			camera3_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera3_view.fog_end = 255;
			camera4_view.fog_start = 0; 		//0.05 * camera.clip_far; // fog starts at 80% of clip range
			camera4_view.fog_end = 255;
			//player.spotlight = ON;
			player.lightrange = 1000;
			vec_set(d3d_spotlightcone,vector(30,1,0));
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
		
		
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				//displaydistractmsg();
				}
			if(verbalflag == 0)
				{
				snd_stop(instruction_handle);
				instruction_handle = snd_play(nightdrivingruralL27_wav,100,0);
				}
			if(instructionsflag == 0)
			{
			lesson27_txt.VISIBLE = ON;  //night rural
			wait(-60);
			lesson27_txt.VISIBLE = OFF;
			}
						
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON;
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			
			while(1)
				{
					if (highbeam == 0)   //highbeam off
						{
						camera.fog_start = 300;
						camera.fog_end =  1555; //was 1555
						player.spotlight = ON;
						player.lightrange = 1000;
						}
					if (highbeam == 1) //highbeam on
						{
						camera.fog_start = 2000;
						camera.fog_end = 4555;
						player.spotlight = ON;
						player.lightrange = 3000;//was 2000
						} 	
					wait(5);
				}
		

		}//end of action
		
		action moveOncomingL27()  //move oncoming cars along RanchHouse Rd. assigned to toland, etc
		{
			c_setminmax(my);
			my.spotlight = ON;
			my.lightrange = 1000;
			
			while(my.x > -11000)
			{
				if(player.x > -11000)
				{
					c_move(my,vector(40*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		} 
		action turnsignalcheckL27 //check for right turn signal assign pinetree rd sign
		{
			ent_preload(me);  //preload bhouse3
			wait(-5);
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN add to others
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
				}
				if((alertsflag == 0) && (player.x > -1016) && (player.x < -470) && (player.y < 2768) && (player.y > 2698 )  && (player.y < 2784 )&& (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
					noturnsignal_txt.VISIBLE=ON;
					wait(-3);
					noturnsignal_txt.VISIBLE=OFF;
				}
				if((alertsflag == 0) && (player.x > -416) && (player.x < -304) && (player.y > -1088) && (player.y < -336) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
					noturnsignal_txt.VISIBLE=ON;
					wait(-3);
					noturnsignal_txt.VISIBLE=OFF;
				}
				
				wait(1);
			}
		}
		action turnlighton()
		{
			my.light = On;
			my.lightrange = 500;
		}
		action headlighton()
		{
			my.spotlight = ON;
			my.lightrange = 1000;
			vec_set(d3d_spotlightcone,vector(30,1,0));
		}
		MATERIAL  mat_shaded
		{
			ambient_blue = 20;
			ambient_green = 20;
			ambient_red = 20;	
			diffuse_blue = 170;
			diffuse_green = 170;
			diffuse_red = 200;//200
			specular_blue = 255;
			specular_green = 255;
			specular_red = 255;
			power = 10;
		}
		action showdataL27() //assign bhouse10
		{
			wait(-5);
			while(1)
			{
				if((player.x < -1470) && (player.y < -1230))
					{
					lesson27_txt.VISIBLE = OFF;
					if(performflag == 0)
						{
						numcollisions_txt.VISIBLE = ON; // label for collisions
						numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
						speedexceed_txt.VISIBLE = ON; //label for speed exceed
						speedexceeddisp.VISIBLE = ON; //num of speedexceed
						noturnsignalcount_txt.VISIBLE = ON;
						noturnsignalcountdisp.VISIBLE = ON;
						}
					}
				wait(1);
			}
		}
		action HighLowBeamsL27  //assigned to house3nt
		{
			while(1)
			{
			if (key_h)
				{
				if(highbeam == 0)	
					{
					highbeam = 1;//put highbeams on
					camera.fog_start = 2000;//was 2000 		//
					camera.fog_end = 	3555;//was 4555		//
					player.lightrange = 3000;
					highbeams.VISIBLE = ON;//turn instrument icon on
					}  
				else
					{
					highbeam = 0;//put lowbeams on
					camera.fog_start = 300;//was 1500 		//
					camera.fog_end = 	1555;//was 1555		//
					player.lightrange = 1000;
					highbeams.VISIBLE = OFF;//turn icon off
					}
				}
			if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
			if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
				
			wait(1);
			}//end loop
			//
			//
		}	
		
		action endplayerL27()  //assign to johndeere
		{
		
			
			while(1)
			{
				if((player.x > 16000) || (player.y < -10200))
				{
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					numcollisions_txt.VISIBLE = ON; // label for collisions
					numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
					speedexceed_txt.VISIBLE = ON; //label for speed exceed
					speedexceeddisp.VISIBLE = ON; //num of speedexceed
					wait(-.5);
					menu01_show_main();
					var	cur_item;
					cur_item = 1;
					menu01_highlight(cur_item);
					break; 
				}
				wait(1);
			}
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			fog_color = 0;
		}
		//////
		////// LESSON 28 CURVES and STRAIGHTS is 16 in scenario directory
		//////
		
		action scenarioL28()  //set car road resistance in bhouse1
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(curvesandstraightsL28_wav,100,0);
					}
			
			if(instructionsflag == 0)
				{
				lesson28_txt.visible = ON;
				wait(-15);
				lesson28_txt.visible = OFF;
				}
				
			if(performflag == 0)
				{
				numcollisions_txt.VISIBLE = ON; // label for collisions
				numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
				speedexceed_txt.VISIBLE = ON; //label for speed exceed
				speedexceeddisp.VISIBLE = ON; //num of speedexceed
				speedslow_txt.VISIBLE = ON; //label for speed exceed
				speedslowdisp.VISIBLE = ON; //num of speedexceed
				overroadedge_txt.VISIBLE = ON;
				overroadedgedisp.VISIBLE = ON;
				overmediandisp.VISIBLE = ON;
				overmedian_txt.VISIBLE = ON;
				overmediandisp.VISIBLE = ON;
				}
				
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
		}//end action
		
	action returnandendL28//assigned to hill mdl
		{
		//	if((verbalflag == 0) || (instructionsflag == 0))
		//	{
			wait(-5);
		//	}
			
			endonceL28 = 0;
			while(1)
			{
			
				if((endonceL28 == 0) && (player.x < -10160) && (player.y < -9100) && (player.y > -9500))
				{
					endonceL28 = 1;//show only once
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(turnaroundinlotreturnstartpos_wav,100,0);
					}
					//endonceL28 = 1;//show only once
					returntostart_txt.VISIBLE = ON;
					wait(-3);
					returntostart_txt.VISIBLE = OFF;
				}
				wait(1);
			}
		}
action endofscenarioL28()//in 45 mph
	{
	//	wait(-5);
		while(1)
			{	
				if(fullscreen == 1)//FULL SCREEN add to others
				{
					
				overroadedge_txt.pos_x = 650;
				overroadedge_txt.pos_y = 570;
				overroadedgedisp.pos_x = 806;
				overroadedgedisp.pos_y = 570;
				
				overmedian_txt.pos_x = 650;
				overmedian_txt.pos_y = 580;
				overmediandisp.pos_x = 806;
				overmediandisp.pos_y = 580;
				
				speedslow_txt.pos_x = 650;
				speedslow_txt.pos_y = 590;
				speedslowdisp.pos_x = 806;
				speedslowdisp.pos_y = 590;
				
				}
				if(fullscreen == 0)//Windowed
				{
				overroadedge_txt.pos_x = 630;
				overroadedge_txt.pos_y = 610;
				overroadedgedisp.pos_x = 806;
				overroadedgedisp.pos_y = 610;
				
				overmedian_txt.pos_x = 630;
				overmedian_txt.pos_y = 620;
				overmediandisp.pos_x = 806;
				overmediandisp.pos_y = 620;
				
				speedslow_txt.pos_x = 630;
				speedslow_txt.pos_y = 630;
				speedslowdisp.pos_x = 806;
				speedslowdisp.pos_y = 630;
				}
				
			if ((endonceL28 == 1) && (player.x < -8000) && (player.y < 3000) && (player.y > 2592))	//player returns to start
				{
					endscenariopressESC_txt.VISIBLE = ON;
					break;
				}
				wait(1);
			}
				
		if(verbalflag == 0)
			{
			snd_stop = navigation_handle;
			navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
			}
	}
	action lanepositionL28()//in 2lanestrgray model
		{
			//if((verbalflag == 0) || (instructionsflag == 0))
				//{
		wait(-5);
				//}
			
			while(1)
			{
				//first level and hill long straights outbound
				if ((endonceL28 == 0) && (player.x > -10144) && (player.x < 25550) && (player.y < 2800) && (player.y > 2706))//roadsection1
				{
					if(player.y < 2736)//passed road edge 28 correction for player.y < 2708
					{
					overroadedge += 1;//increment by one
					}
					if(player.y > 2784)//passed median -14 correction, median y 2798
					{
					overmedian += 1;
					}
				}
			
				//short straight east end OUTBOUND
				if((endonceL28 == 0) && (player.x > 26805) && (player.x < 26880) && (player.y < 1584) && (player.y > 384))
			
				{
					overmedian += 1;
				}
					 
				//short straight East end OUTBOUND
				if((endonceL28 == 0) && (player.x > 26746) && (player.x < 26640) && (player.y < 1584) && (player.y > 384))
				
				{
					overroadedge += 1;
				}
				
				//short straight Southeast end OUTBOUND
				if((endonceL28 == 0) && (player.x > 25056) && (player.x < 25566) && (player.y < -784) && (player.y > -862))
				
				{
					overmedian += 1;
				}	 
				
				//short straight SWest OUTBOUND 
				if((endonceL28 == 0) && (player.x > 24961) && (player.x < 25664) && (player.y < -840) && (player.y > -912))
				
				{
					overmedian += 1;
				}
		
				//see curves for three straight segments  SW
				
				//short straight south OUTBOUND just before second hill
				if((endonceL28 == 0) && (player.x > 19696) && (player.x < 21792) && (player.y < -4864) && (player.y > -4992))
				{
					if(player.y > -4900)
					{
						overroadedge += 1;//increment by one
					}
					
					if(player.y < -4950)
					{
						overmedian += 1;
					}
					 
				}
				//straight just before parking lot OUTBOUND
				if((endonceL28 == 0) && (player.x > -11456) && (player.x < -8806) && (player.y < -9280) && (player.y > -9360))
				
					{
						overmedian += 1;
					}
				if((endonceL28 == 0) && (player.x > -11456) && (player.x < -8806) && (player.y > -9212) && (player.y < -9040))
					{
						overroadedge += 1;//increment by one
					}
					//
					//second hill long straight OUTBOUND
					//
				if ((endonceL28 == 0) && (player.x > 1900) && (player.x < 18600) && (player.y < -4800) && (player.y > -4992))//roadsection1
				{
					if(player.y > -4897)//passed road edge 28 correction for player.y < -4967
					{
					overroadedge += 1;//increment by one
					}
					if(player.y < -4953)//passed median 14 correction, median y 2796
					{
					overmedian += 1;
					}
				}
					//
					//straight just before parking lot RETURN
					//
				if((endonceL28 == 1) && (player.x > -11488) && (player.x < -9200) && (player.y < -9232) && (player.y > -9296))
				
					{
						overmedian += 1;
					}
				if((endonceL28 == 1) && (player.x > -11488) && (player.x < -9200) && (player.y > -9360) && (player.y < -9320))
					{
						overroadedge += 1;//increment by one
					}
				
					
				//first level and hill long straight RETURN
				if ((endonceL28 == 1) && (player.x > -10144) && (player.x < 24000) && (player.y < 2887) && (player.y > 2797))//roadsection1
				{
					if(player.y > 2860)//passed road edge 28 correction 
					{
					overroadedge += 1;//increment by one
					}
					if(player.y < 2814)//passed median 14 correction, median y 2796
					{
					overmedian += 1;
					}
				}
			
				//second hill long straight RETURN
				if ((endonceL28 == 1) && (player.x > 1900) && (player.x < 18600) && (player.y > -5120) && (player.y < -4928))//roadsection1
				{
					if(player.y < -5022)//passed road edge 28 correction 
					{
					overroadedge += 1;//increment by one
					}
					if(player.y > -4974)//passed median 14 correction, median y 2796
					{
					overmedian += 1;
					}
				}
				//first curve past second hill RETURN
				if ((endonceL28 == 1) && (player.x > 80) && (player.x < 368) && (player.y > -5376) && (player.y < -4992))//roadsection1
				{
					if(player.y > -5004)//passed road edge 28 correction for player.y < 2709
					{
					overroadedge += 1;//increment by one
					}
					if(player.y > -5104)//passed median -14 correction, median y 2796
					{
					overmedian += 1;
					}
				}
				wait(-1);//wait 1 sec
			}
		}	
	action laneposcurvesL28//in hill mdl lane curves and angled straights
	{
			//check to see if on road
		//	if((verbalflag == 0) || (instructionsflag == 0))
		//	{
			wait(-5);
		//	}
			
			while(1)
			{
				//outbound leg
				if((endonceL28 == 0) && (player.y > 2801) && (player.y < 2864) && (player.x < 25714)  && (player.x > 25693))
		 		{
					overmedian += 1;
				}	
				if((endonceL28 == 0) && (player.y > 2744) && (player.y < 2811) && (player.x < 25985)  && (player.x > 25964))
		 		{
					overmedian += 1;
				}		
				if((endonceL28 == 0) && (player.y < 2688) && (player.y > 2611) && (player.x > 26225)  && (player.x < 26249))
		 		{
					overmedian += 1;
				}	
				if((endonceL28 == 0) && (player.y < 2499) && (player.y > 2397) && (player.x > 26499)  && (player.x < 26523))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < 2136) && (player.y > 2106) && (player.x > 26694)  && (player.x < 26763))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < 50) && (player.y > 74) && (player.x > 26764)  && (player.x < 26848))
		 		{
					overmedian += 1;
				}	
				if((endonceL28 == 0) && (player.y < -112) && (player.y > -138) && (player.x > 26703)  && (player.x < 26784))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -304) && (player.y > -332) && (player.x > 26592)  && (player.x < 26689))
		 		{
					overmedian += 1;
				}	
				if((endonceL28 == 0) && (player.y < -568) && (player.y > -693) && (player.x > 26336)  && (player.x < 26464))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -792) && (player.y > -817) && (player.x > 25920)  && (player.x < 25965))
		 		{
					overmedian += 1;
				}	
				if((endonceL28 == 0) && (player.y < -672) && (player.y > -700) && (player.x > 25968)  && (player.x < 26079))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -907) && (player.y > -932) && (player.x > 24567)  && (player.x < 24579))
		 		{
					overmedian += 1;
				}
				//three short straight SouthWest outbound	 
				//
				if((endonceL28 == 0) && (player.y < -2610) && (player.y > -2634) && (player.x > 23600)  && (player.x < 23680))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -2860) && (player.y > -2884) && (player.x > 23498)  && (player.x < 23556))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3110) && (player.y > -3134) && (player.x > 23393)  && (player.x < 23473))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3360) && (player.y > -3384) && (player.x > 23293)  && (player.x < 23360))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3610) && (player.y > -3635) && (player.x > 23193)  && (player.x < 23268))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3860) && (player.y > -3885) && (player.x > 23092)  && (player.x < 23172))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -2967) && (player.y > -2992) && (player.x > 23456)  && (player.x < 23543))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3237) && (player.y > -3261) && (player.x > 23354)  && (player.x < 23434))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3408) && (player.y > -3433) && (player.x > 23277)  && (player.x < 23344))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3680) && (player.y > -3705) && (player.x > 23168)  && (player.x < 23233))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -3964) && (player.y > -3989) && (player.x > 23050)  && (player.x < 23130))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -4247) && (player.y > -4277) && (player.x > 22946)  && (player.x < 23026))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -4504) && (player.y > -4529) && (player.x > 22784)  && (player.x < 22853))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -4769) && (player.y > -4794) && (player.x > 22598)  && (player.x < 22496))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -4937) && (player.y > -4962) && (player.x > 22048)  && (player.x < 22080))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -7743) && (player.y > -7768) && (player.x > -2624)  && (player.x < -2588))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -7824) && (player.y > -7849) && (player.x > -2832)  && (player.x < -2946))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -7836) && (player.y > -7900) && (player.x > -3208)  && (player.x < -3183))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -7883) && (player.y > -7970) && (player.x > -3465)  && (player.x < -3440))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -8000) && (player.y > -8074) && (player.x > -3725)  && (player.x < -3700))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -8184) && (player.y > -8273) && (player.x > -3953)  && (player.x < -3928))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -8400) && (player.y > -8495) && (player.x > -4133)  && (player.x < -4108))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -8753) && (player.y > -8842) && (player.x > -4325)  && (player.x < -4300))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9024) && (player.y > -9103) && (player.x > -4557)  && (player.x < -4532))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9184) && (player.y > -9249) && (player.x > -4779)  && (player.x < -4754))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9271) && (player.y > -9346) && (player.x > -5020)  && (player.x < -4996))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9318) && (player.y > -9384) && (player.x > -5274)  && (player.x < -5249))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9334) && (player.y > -9408) && (player.x > -5534)  && (player.x < -5510))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9397) && (player.y > -9478) && (player.x > -5799)  && (player.x < -5774))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9542) && (player.y > -9607) && (player.x > -6042)  && (player.x < -6017))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9833) && (player.y > -9748) && (player.x > -6300)  && (player.x < -6286))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9910) && (player.y > -9985) && (player.x > -6548)  && (player.x < -6523))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9910) && (player.y > -9985) && (player.x > -6548)  && (player.x < -6523))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9991) && (player.y > -10063) && (player.x > -6798)  && (player.x < -6773))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -10091) && (player.y > -10094) && (player.x > -7065)  && (player.x < -7040))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -10074) && (player.y > -9999) && (player.x > -7325)  && (player.x < -7300))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9936) && (player.y > -10016) && (player.x > -7536)  && (player.x < -7504))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9808) && (player.y > -9888) && (player.x > -7776)  && (player.x < -7751))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 0) && (player.y < -9584) && (player.y > -9678) && (player.x > -8031)  && (player.x < -8006))
		 		{
					overmedian += 1;
				}
				//
				//angle straight
				//
				if((endonceL28 == 0) && (player.y < -7908) && (player.y > -7991) && (player.x > -3150)  && (player.x < -3125))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y < -7890) && (player.y > -7968) && (player.x > -2875)  && (player.x < -2850))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y < -7820) && (player.y > -7898) && (player.x > -2600)  && (player.x < -2575))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y < -7680) && (player.y > -7768) && (player.x > -2325)  && (player.x < -2300))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y < -7433) && (player.y > -7492) && (player.x > -2058)  && (player.x < -2030))
		 		{
					overroadedge += 1;
				}
				///CURVES
				///
				if((endonceL28 == 0) && (player.y < -7408) && (player.y > -7472) && (player.x > -2292)  && (player.x < -2188))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y > -7804) && (player.y < -7724) && (player.x > -3136)  && (player.x < -3121))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y > -7804) && (player.y < -7724) && (player.x > -3269)  && (player.x < -3241))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 0) && (player.y > -7828) && (player.y > -7760) && (player.x < -3374)  && (player.x > -3402))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -7838) && (player.y > -7905) && (player.x < -3612)  && (player.x > -3640))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -7905) && (player.y > -7970) && (player.x > -3717)  && (player.x < -3745))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -7887) && (player.y > -7976) && (player.x > -3759)  && (player.x < -3731))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -7979) && (player.y > -8090) && (player.x > -3914)  && (player.x < -3836))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -7979) && (player.y > -8133) && (player.x > -3969)  && (player.x < -3941))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -8206) && (player.y > -8339) && (player.x > -4156)  && (player.x < -4128))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -8368) && (player.y > -8521) && (player.x > -4268)  && (player.x < -4240))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -8586) && (player.y > -8712) && (player.x > -4368)  && (player.x < -4340))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -8756) && (player.y > -8861) && (player.x > -4452)  && (player.x < -4365))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -8976) && (player.y > -9072) && (player.x > -4684)  && (player.x < -4656))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -9218) && (player.y > -9288) && (player.x > -5328)  && (player.x < -5300))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -9344) && (player.y > -9408) && (player.x > -5900)  && (player.x < -872))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -9584) && (player.y > -9680) && (player.x > -6400)  && (player.x < -6272))
		 		{
					overroadedge += 1;
				}
				
				if((endonceL28 == 0) && (player.y < -9888) && (player.y > -9968) && (player.x > -6970)  && (player.x < -6842))
		 		{
					overroadedge += 1;
				}
				
					if((endonceL28 == 0) && (player.y < -9888) && (player.y > -9962) && (player.x > -7440)  && (player.x < -7312))
		 		{
					overroadedge += 1;
				}
				
					if((endonceL28 == 0) && (player.y < -9456) && (player.y > -9552) && (player.x > -8128)  && (player.x < -8000))
		 		{
					overroadedge += 1;
				}
				
				//Last straight segment outbound
				//
				if((endonceL28 == 0) && (player.y < -9168) && (player.y > -9248) && (player.x > -1120)  && (player.x < -8976))
		 		{
					overroadedge += 1;
				}
				////
				////OVERMEDIAN RETURN
				///
				if((endonceL28 == 1) && (player.y < -9253) && (player.y > -9334) && (player.x > -8569)  && (player.x < -8544))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9375) && (player.y > -9424) && (player.x > -8628)  && (player.x < -8603))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9486) && (player.y > -9513) && (player.x > -8294)  && (player.x < -8269))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9367) && (player.y > -9421) && (player.x > -8294)  && (player.x < -8269))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9529) && (player.y > -9596) && (player.x > -8098)  && (player.x < -8018))
		 		{
					overmedian += 1;
				}
				
				if((endonceL28 == 1) && (player.y < -9677) && (player.y > -9762) && (player.x > -7847)  && (player.x < -7822))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9856) && (player.y > -9921) && (player.x > -7600)  && (player.x < -7575))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9857) && (player.y > -9937) && (player.x > -7572)  && (player.x < -7547))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9961) && (player.y > -10035) && (player.x > -7200)  && (player.x < -7175))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9937) && (player.y > -10018) && (player.x > -6825)  && (player.x < -6800))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9851) && (player.y > -9930) && (player.x > -6550)  && (player.x < -6525))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9664) && (player.y > -9756) && (player.x > -6275)  && (player.x < -6250))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9439) && (player.y > -9532) && (player.x > -6275)  && (player.x < -6250))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9439) && (player.y > -9532) && (player.x > -6025)  && (player.x < -6000))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9412) && (player.y > -9326) && (player.x > -6025)  && (player.x < -6000))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9412) && (player.y > -9326) && (player.x > -5775)  && (player.x < -5750))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9280) && (player.y > -9354) && (player.x > -5500)  && (player.x < -5475))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9264) && (player.y > -9337) && (player.x > -5225)  && (player.x < -5200))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9203) && (player.y > -9277) && (player.x > -4950)  && (player.x < -4975))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -9041) && (player.y > -9136) && (player.x > -4664)  && (player.x < -4689))
		 		{
					overmedian += 1;
				}
				if((endonceL28 == 1) && (player.y < -8742) && (player.y > -8884) && (player.x > -4414)  && (player.x < -4389))
		 		{
					overmedian += 1;
				}
				//Over road edge RETURN
				//
				if((endonceL28 == 1) && (player.y < -9611) && (player.y > -9680) && (player.x > -8125)  && (player.x < -8100))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9400) && (player.y > -9447) && (player.x > -8496)  && (player.x < -8471))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9535) && (player.y > -9601) && (player.x > -8200)  && (player.x < -8175))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9779) && (player.y > -9834) && (player.x > -7922)  && (player.x < -7897))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9927) && (player.y > -9987) && (player.x > -7700)  && (player.x < -7675))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -10044) && (player.y > -10112) && (player.x > -7425)  && (player.x < -7400))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -10090) && (player.y > -10160) && (player.x > -7150)  && (player.x < -7125))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -10084) && (player.y > -10154) && (player.x > -6900)  && (player.x < -6875))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -10021) && (player.y > -10081) && (player.x > -6625)  && (player.x < -6597))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9885) && (player.y > -9952) && (player.x > -6350)  && (player.x < -6325))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9660) && (player.y > -9765) && (player.x > -6050)  && (player.x < -6075))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9414) && (player.y > -9499) && (player.x > -5550)  && (player.x < -5525))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9461) && (player.y > -9394) && (player.x > -5275)  && (player.x < -5250))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9351) && (player.y > -9425) && (player.x > -5000)  && (player.x < -4975))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9239) && (player.y > -9347) && (player.x > -4725)  && (player.x < -4700))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -9037) && (player.y > -9140) && (player.x > -4450)  && (player.x < -4425))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -8728) && (player.y > -8866) && (player.x > -4200)  && (player.x < -4175))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -8303) && (player.y > -8446) && (player.x > -3950)  && (player.x < -3925))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -8169) && (player.y > -8083) && (player.x > -3700)  && (player.x < -3675))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7958) && (player.y > -8051) && (player.x > -3425)  && (player.x < -3400))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7906) && (player.y > -7961) && (player.x > -3088)  && (player.x < -3063))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7883) && (player.y > -7954) && (player.x > -2838)  && (player.x < -2813))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7814) && (player.y > -7872) && (player.x > -2588)  && (player.x < -2563))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7678) && (player.y > -7778) && (player.x > -2338)  && (player.x < -2313))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7513) && (player.y > -7594) && (player.x > -2126)  && (player.x < -2101))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -7182) && (player.y > -7286) && (player.x > -1800)  && (player.x < -1500))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -6881) && (player.y > -6971) && (player.x > -1500)  && (player.x < -1470))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -6550) && (player.y > -6649) && (player.x > -1170)  && (player.x < -1140))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -6220) && (player.y > -6320) && (player.x > -840)  && (player.x < -810))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -5890) && (player.y > -5990) && (player.x > -510)  && (player.x < -480))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -5657) && (player.y > -5567) && (player.x > -180)  && (player.x < -150))
		 		{
					overroadedge += 1;
				}
				if((endonceL28 == 1) && (player.y < -5230) && (player.y > -5320) && (player.x > 150)  && (player.x < 170))
		 		{
					overroadedge += 1;
				}
			wait(-.1);
			}			
	}
action changedragL28//action DELETED place in sp45 sign near house
	{
		while(1)
			{
				//hill #1
				//outbound leg
				if((endonceL28 == 0)&&(player.x > 10700) && (player.x < 14800) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .52;//uphill; was .33 reset in clearinstruct
				}
				//return leg
				if((endonceL28 == 1)&&(player.x > 10700) && (player.x < 14800) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .10;//downhill; was .33 reset in clearinstruct
				}
				//either outbound or return
				if( (player.x >= 14800) && (player.x < 19200) &&(player.y < 3080) && (player.y > 2510))
				{
					Drag = .33;//level; was .33 reset in clearinstruct
				}
				//outbound leg
				if((endonceL28 == 0) && (player.x >= 19200) && (player.x < 24700) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .10;//downhill; was .33 reset in clearinstruct
				}
				//return leg
				if((endonceL28 == 1) && (player.x >= 19200) && (player.x < 24700) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .52;//uphill; was .33 reset in clearinstruct
				}
				//either outbound or return
				if((player.x >= 24700) && (player.y > 3080) && (player.y < 2510))
				{
					Drag = .33 ;//level; was .33 reset in clearinstruct
				}
				
			//hill #2
			
			//outbound leg
				if((endonceL28 == 0) && (player.x < 19200) && (player.x >= 14400) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .52;//uphill; was .35 reset in clearinstruct
				}
				//return leg
				if((endonceL28 == 1) && (player.x < 19200) && (player.x >= 14400) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .10;//downhill; was .35 reset in clearinstruct
				}
				//either outbound or return
				if((player.x >= 14800) && (player.x < 9600) &&(player.y < 3080) && (player.y > 2510))
				{
					Drag = .33;//level; was .31 reset in clearinstruct
				}
				//outbound leg
				if((endonceL28 == 0) && (player.x >= 9600) && (player.x < 5500) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .10;//downhill; was .31 reset in clearinstruct
				}
				//return leg
				if((endonceL28 == 1) &&(player.x >= 9600) && (player.x < 5500) && (player.y < 3080) && (player.y > 2510))
				{
					Drag = .52;//uphill; was .31 reset in clearinstruct
				}
				//either outbound or return
				if((player.x >= 5500) && (player.y > 3080) && (player.y < 2510))
				{
					Drag = .33 ;//level; was .31 reset in clearinstruct
				}
				
				wait(1);
			}
		
	}
	action  writeL28vars()  //assign to 45mph sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L16Curves");
						str_cat(dummyname_str,"L16Curves");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L16Curves ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Speed too Slow(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedtooslow);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Road Edge(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,overroadedge);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Median(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,overmedian);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}//end action

		//////
		////// LESSON 29 DRIVING TEST - RURAL v 3 - Lesson 25 in Directory
		//////
				
	action moveWithDriverL29()
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			highbeams.VISIBLE = OFF;
			
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
		
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(drivetestruralL29_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson29_txt.visible = ON;
			wait(-21);
			lesson29_txt.visible = OFF;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(my.x < -5320)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(20*time_step,0,0),nullvector,GLIDE+USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 16672)
			{
				c_move(my,vector(22*time_step,0,0),nullvector,GLIDE+USE_AABB); // move ahead until end
				wait(1);
			}
			ent_remove(me);
		
		}

		
	action moveOncomingL29()  //move oncoming cars along RanchHouse Rd.
		{
			fog_color = 0;
		
			disable_z_glide = 1;
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			//lesson29_txt.visible = ON;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.x > -8560)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(33*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		}

	action backupBMWL29()   //backup into roadway start x=2768,y=42808
		{
			hasbraked = 0;
			brakeRT = 0;
			while (my.y > -42048)  //max backup point and set to move with trigger when player in pos
			{
				if ((player.x < 4168) && (player.y < -41952)  && (player.y > -42128))  //player pos triggers move of van
				{
				c_move(my,vector(-20*time_step,0,0),nullvector,GLIDE); // move back until end	
				}		
				if((my.y < -41872) && (hasbraked == 0) && (brakepedal >= 0))  //car moves back, no braking indicated
				{
				brakeRT +=.1; //start adding to brake rt
				}
				if((my.y <  -41872)  && (brakepedal < 0)) //player braking while bmw moving backward
				{
				hasbraked += 1; //set to has braked, end brake rt increase
				}
			wait(-.1);
			}
			
			wait(-4);
			
			while(my.y < -38839)
			{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				wait(1);
			}
			
		}
	action backupCITL29v3()   //backup into roadway start at y=4880
		{
			wait(-5);
			hasbraked = 0;
			brakeRT = 0;
			while (my.y < -4720)  //max backup point and set to move with trigger when player in pos
			{
				if ((player.x > -7564) && (player.x < -4700) && (player.y > -4832)  && (player.y < -4720))  //player pos triggers move
				{
				c_move(my,vector(-20*time_step,0,0),nullvector,GLIDE); // move back until end	
				}		
				if((my.y > -4848) && (hasbraked == 0) && (brakepedal >= 0))  //car moves back, no braking indicated
				{
				brakeRT +=.1; //start adding to brake rt
				}
				if((my.y >  -4848)  && (brakepedal < 0)) //player braking while bmw moving backward
				{
				hasbraked += 1; //set to has braked, end brake rt increase
				}
			wait(-.1);
			}
			
			wait(-4);
			
			while(my.y > -4896)
			{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				wait(1);
			}
			
		}
	action moveTOLPineL29()//move citroen N on Pine Tree
		{
			
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.y < -4864)
			{
				if((player.x > -4000) && (player.y > -4816) && (player.y < -4720))
				{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); 
					
				}
			wait(1);
			}
			wait(-2);//stop at stop sign for 2 sec then pull out into rd
			
			while(my.y < -4800)
			{
				if((player.x > -900) && (player.y > -4816) && (player.y < -4720))
				{	
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); 
					
				}
			wait(1);
			}
		}
	action bkupwVANL29v2()   //backup into roadway x=-2160,y=-41872
		{
			
			hasbraked = 0;
			brakeRT = 0;
			while (my.y > -42048)  //max backup point and set to move with trigger when player in pos
			{
				if ((player.x < -1110) && (player.y < -41952)  && (player.y > -42128))  //player pos triggers move of van
				{
				c_move(my,vector(-20*time_step,0,0),nullvector,GLIDE); // move back until end	
				}		
				if((my.y < -41892) && (hasbraked == 0) && (brakepedal >= 0))  //car moves back, no braking indicated
				{
				brakeRT +=.1; //start adding to brake rt
				}
				if((my.y <  -41892)  && (brakepedal < 0)) //player braking while bmw moving backward
				{
				hasbraked += 1; //set to has braked, end brake rt increase
				}
			wait(-.1);
			}
			
			wait(-4);
			
			while(my.y < -38839)
			{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				wait(1);
			}
			
		}
	action animmanWestL29v3() //move across West Rd
		{
			wait(-5);
			var anim_speed = 0;
			my.frame = 1;
			while(my.x > -12560) //move man until past road
			{
				if ((player.x > -12560) && (player.x < -12384) && (player.y > -35902) && (player.y < -4560))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(4*time_step,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				wait(1);
			}
			ent_remove(me);
		}

	action bkupvTOLL29v2()   //backup into roadway
		{
		//	hasbraked = 0;
			//brakeRT = 0;
			while (my.y < -4784)  //max backup point and set to move with trigger when player in pos
			{
				if ((player.x > -7100) && (player.y < -4720)  && (player.y > -4816))  //player pos triggers move of van
				{
				c_move(my,vector(-30*time_step,0,0),nullvector,GLIDE); // move back until end	
				}		
			//	if((my.y < -41892) && (hasbraked == 0) && (brakepedal >= 0))  //car moves back, no braking indicated
			//	{
			//	brakeRT +=.1; //start adding to brake rt
			//	}
			//	if((my.y <  -41892)  && (brakepedal < 0)) //player braking while bmw moving backward
			//	{
			//	hasbraked += 1; //set to has braked, end brake rt increase
			//	}
			wait(-.1);
			}
			
			wait(-4);
			
			while(my.y > -4880)
			{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				wait(1);
			}
			
		}
	action TOLWestRdL29v2()//pull out WEST RD
	{
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.y < -22800)//
			{
				if ((my.x > -12448) && (player.y > -31299) && (player.y < -4560) && (player.x < -12384) && (player.x > -12560))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y > -31299) && (player.y < -4560) && (player.x < -12384) && (player.x > -12560)) //&& (my.x == -12064))
					{
					c_move (me,vector(25*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
		 		wait(1);  
	 		} 	
	 		while(my.x < -12384)
	 		{
	 			if ((player.y > -31536) && (player.x < -12384) && (player.x > -12560))	//trigger move
					{
					c_move (me,vector(0,-4*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}
				wait(1);
		//ent_remove(me);
			}
	}
	action movewestrdL29()
		{
		//disable_z_glide = 1;
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			ent_preload(me);  //preload all vehicles
			
			while(my.y > -31100)
			{
				if((player.y > -22100) && (player.x < -12384) && (player.x > -12512))
				{
					c_move(my,vector(53*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);	
		}
		
	action movefwycarsL29()
		{
			disable_z_glide = 1;
			wait(1);	// wait 1 frame after creation
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			ent_preload(me);  //preload all vehicles
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y > -40770)
			{
				if((player.x > 12900) && (player.y < -320))
				{
					c_move(my,vector(53*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		} 
	action proginstructL29()//in bhouse2
		{
			wait(-3);
			while(1)
			{
				//end scenario
				if((player.x < 5260) && (player.x > 5120) && (player.y > -7700) && (player.y < -7100))		
				{
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
					endscenariopressESC_txt.VISIBLE=ON;

					break;
				}
					//Right turn GlenWOOD RD
				if((player.x < 4888) && (player.x > 4388) && (player.y > -4832) && (player.y < -4640))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightglenwood_txt.VISIBLE=ON;
					wait(-4);
					turnrightglenwood_txt.VISIBLE=OFF;
				}
				//Right turn on Park Place
				if((player.x > -12480) && (player.x < -12368) && (player.y > -5900) && (player.y < -5300))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightparkplace_txt.VISIBLE=ON;
					wait(-4);
					turnrightparkplace_txt.VISIBLE=OFF;
				
				}
				//Right turn on West Rd
				if((player.x < -11236) && (player.x > -12120) && (player.y < -41920) && (player.y > -42112))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightwestrd_txt.VISIBLE=ON;
					wait(-4);
					turnrightwestrd_txt.VISIBLE=OFF;
			
				}
					//Right turn on South Rd
				if((player.x < 12976) && (player.x > 12752) && (player.y < -40304) && (player.y > -41304))		
				{	
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightsouthrd_txt.VISIBLE=ON;
					wait(-4);
					turnrightsouthrd_txt.VISIBLE=OFF;
				
				}
						//Right turn ENTER frwy
				if((player.x < 12500) && (player.x > 10900) && (player.y > 2688) && (player.y < 2864))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(enterfrwyontherightahead_wav,100,0);
					}
					enterfrwyonright_txt.VISIBLE = ON;
					wait(-4);
					enterfrwyonright_txt.VISIBLE = OFF;
				}
				//Move to Center Lane
				//
				if((player.x < 13736) && (player.x > 13504) && (player.y < -4992) && (player.y > -5692))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(movetothecenterlane _wav,100,0);
					}
					movetocenterlane_txt.VISIBLE=ON;
					wait(-4);
					movetocenterlane_txt.VISIBLE=OFF;
				}
				//Move to Right Lane
				//
				if((player.x < 13776) && (player.x > 13536) && (player.y < -24176) && (player.y > -24976))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(movetotherightlane _wav,100,0);
					}
					movetorightlane_txt.VISIBLE=ON;
					wait(-4);
					movetorightlane_txt.VISIBLE=OFF;
				}
				//EXIT Freeway to Right
				//
				if((player.x < 13776) && (player.x > 13536) && (player.y < -31136) && (player.y > -31836))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(exitfrwyrightahead _wav,100,0);
					}
					
					exitfrwyright_txt.VISIBLE=ON;
					wait(-4);
					exitfrwyright_txt.VISIBLE=OFF;
				}
				wait(1);
			}
		}	
	action missedturn()
		{
			while(1)
			{
				if(player.x > 10500 || (player.y < -18900) && (player.x > 10100)
				|| (player.y < -2118) && (player.x < -8000))
				{
					missedturn_txt.VISIBLE = ON;
				endscenariopressESC_txt.VISIBLE = ON; //request user to use main menu
					collision_txt.VISIBLE = OFF;
			
					break; 
				}
				
				wait(1);	
			} 
		}

	action speedlimit50()
		{
			wait(-5);
			while(1)
			{
				if(car_velocity > 64) && (alertsflag == 0) //exceeds 45 mph
				{
					speedlimit_txt.VISIBLE = ON;
					wait(-5);
					speedlimit_txt.VISIBLE = OFF;
				}
				wait(1);
			}			
		}
		
	action turnsignalcheckL29() //check for right turn signal at frwy entry and exit
		{
			//ent_preload(me);  //preload bhouse3
			while(1)
			{
				if(fullscreen == 1)//Full SCREEN
				{
				followtooclose_txt.pos_x = 650; //was 570
				followtooclose_txt.pos_y = 570;//was 550
				followtooclosedisp.pos_x = 806;     // Position the  display was 165
				followtooclosedisp.pos_y = 570;   // Use 4 and 600 for 1024
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 580;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 580;
				brakeRT_txt.pos_x = 650; //was 570
				brakeRT_txt.pos_y = 590;//was 560
				brakeRTdisp.pos_x = 806;     // Position the  display was 165
				brakeRTdisp.pos_y = 590;   // Use 4 and 600 for 1024
				}
				if(fullscreen == 0)//Windowed
				{
				followtooclose_txt.pos_x = 630; //was 570
				followtooclose_txt.pos_y = 610;//was 550
				followtooclosedisp.pos_x = 806;     // Position the  display was 165
				followtooclosedisp.pos_y = 610;   // Use 4 and 600 for 1024
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 620;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 620;
				brakeRT_txt.pos_x = 630; //was 570
				brakeRT_txt.pos_y = 630;//was 560
				brakeRTdisp.pos_x = 806;     // Position the  display was 165
				brakeRTdisp.pos_y = 630;   // Use 4 and 600 for 1024
				}
			
				//enter frwy rt turn
				if((player.x < 12736) && (player.x > 12036) && (player.y > 2704) && (player.y < 2864) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
					noturnsignalcount +=1;
				
				}
				//exit frwy
				if((player.x > 13536) && (player.x < 13808) && (player.y < -36400) && (player.y > - 37100) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{
					
					noturnsignalcount +=1;
					
				}
				//glenwood rt turn new
				if((player.x < 4888) && (player.x > 4388) && (player.y > -4832) && (player.y < -4640))		
				{
					
					noturnsignalcount +=1;
					
				}
				//parkplace rt turn new
			if((player.x < -12560) && (player.x > -12368) && (player.y > -5548) && (player.y < -4848))		
					{
					
					noturnsignalcount +=1;
					
				}
					//west rd rt turn
			if((player.x < -11236) && (player.x > -12120) && (player.y < -41920) && (player.y > -42112))		
					{	
					noturnsignalcount +=1;	
				}
						//south rd rt turn
				if((player.x > 12784) && (player.x < 12912) && (player.y > -41904) && (player.y < - 41204) && (joy_5 == 0) && (snd_playing(signal_handle) ==0) && (rturnsignal == 0))	
				{	
					noturnsignalcount +=1;	
				}
				wait(-1);
			}
		}
	
	action latdevL29()  //bhouse1  LATERAL DEVIATIONS RMSe
	{
	
		wait(-5);
		
		
		n1 = 0;
		latdev1 = 0;
		sumlatdev1 = 0;
		meanlatdevL29 = 0;
		latdevsq1 = 0;
		rmse = 0;
		
		while(1)
			{
				//
				if((player.y < -15120) && (player.y > -38336) && (player.x < -230) && (player.x  > -320))
				{
					n1 += 1;//increment sample size
					latdev1 = (player.x + 28) + 235;//correct for width of car from eyepoint
					sumlatdev1 += abs((player.x + 28) + 235);
					meanlatdevL29 = (sumlatdev1/n1)/7;
					latdevsq1 += latdev1 * latdev1;
					ms  = latdevsq1/n1;
					rmse = (sqrt(ms))/7;//no negative numbers
					
				}	
				wait(-.1);
			}
	}	
	
	action showdataL29() //assign bhouse9
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-23);
			}
			
			if(performflag == 0)//show if flag = 0
			{
						numcollisions_txt.VISIBLE = ON; // label for collisions
						numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
						speedexceed_txt.VISIBLE = ON; //label for speed exceed
						speedexceeddisp.VISIBLE = ON; //num of speedexceed
						noturnsignalcount_txt.VISIBLE = ON;
						noturnsignalcountdisp.VISIBLE = ON;
					
						followtooclose_txt.VISIBLE = ON;
						followtooclosedisp.VISIBLE = ON;
					
						brakeRT_txt.VISIBLE = ON;
						brakeRTdisp.VISIBLE = ON;
			}
			
		}//END OF ACTION
		
	action  writeL29vars()  //assign to bhouse2
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
				if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L29DriveTestRuralv1");
						str_cat(dummyname_str,"L29DriveTestRuralv1");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L29DriveTestRuralv1 ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
	action  writeL29v2vars()  //assign to bhouse9
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
				if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L27DriveTestRuralv2");
						str_cat(dummyname_str,"L27DriveTestRuralv2");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L27DriveTestRuralv2 ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}	
action  writeL29v3vars()  //assign to bhouse2
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			while(1)
				{
				if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L29DriveTestRuralv3");
						str_cat(dummyname_str,"L29DriveTestRuralv3");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L29DriveTestRuralv3 ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
	
			/////
		///// LESSON 30 DRIVING TEST - URBAN v.3
		/////
		
action latdevL30()  //bwk3 LATERAL DEVIATIONS RMSe
	{
		msL30 = 0;
		rmseL30 = 0;
		squaresL30 = 0;
		
		wait(-5);
			
		while(1)
			{
				//N Bound Brdwy (edge is -142)
				if((player.y > -21088) && (player.y < -18400) && (player.x < -16) && (player.x  > -176))
				{
					n1 += 1;//increment sample size
					latdev1 = abs((player.x - 28) + 142);//correct for width of car from eyepoint
					sumlatdev1 += abs((player.x - 28) + 142);//abs value of score
					//calculate average of scores
					meanlatdev1 = (sumlatdev1/n1)/7;//divide by sample, convert to feet
					//square the scores
					latdevsq1 += (latdev1/7) * (latdev1/7);//square of the scores
					
				}
			
		//E Bound 1st ave from BRDWY; player.x start/stop edge is -21213
			
				if((player.x < -1036) && (player.x > -6780) && (player.y > -21368) && (player.y < -21184))
			{
				n2 += 1;
				latdev2 = abs((player.y + 28) + 21213);
				sumlatdev2 += abs((player.y + 28) + 21213);//correct for map neg
				meanlatdev2 = (sumlatdev2/n2)/7;
				latdevsq2 += (latdev2/7) * (latdev2/7);//sum of squares
	
			}
			
			
				//N Bound Main; player.y start/stop road edge is -7902
			if((player.x > -7984) && (player.x < -7728) && (player.y < -22348) && (player.y > -29252))
				{
					n3 += 1;
					latdev3 = abs((player.x - 28) + 7902);
					sumlatdev3 += abs((player.x - 28) + 7902);
					meanlatdev3 = (sumlatdev3/n3)/7;
					latdevsq3 += (latdev3/7) * (latdev3/7);
		
				}
			
				//E Bound Market; player.x start/stop road edge is -30086
			if((player.y < -30048) && (player.y > -30240) && (player.x < -8706) && (player.x > -11156))
				{
					n4 += 1;
					latdev4 =  abs((player.y + 28) + 30086);
					sumlatdev4 += abs((player.y + 28) + 30086);
					meanlatdev4 = (sumlatdev4/n4)/7;
					latdevsq4 += (latdev4/7) * (latdev4/7);
		
				}
			
				//S Bound Center start/stop is player.y; road edge is -12030
			if((player.y > -29332) && (player.y < -22380)  && (player.x < -11968) && (player.x > -12176))
				{
					n5 += 1;
					latdev5 = abs((player.x + 28) + 12030);
					sumlatdev5 += abs((player.x + 28) + 12030);
					meanlatdev5 = (sumlatdev5/n5)/7;
					latdevsq5 += (latdev5/7) * (latdev5/7);
			
				}
			
			//W Bound on FIRST from CENTER; start/stop is player.x; road edge is -21520
			if((player.x > -10765) && (player.x < -8748) && (player.y > -21552) && (player.y < -21364))
				{
					n6 += 1;
					latdev6 = abs((player.y - 28) + 21520);
					sumlatdev6 += abs((player.y - 28) + 21520);
					meanlatdev6 = (sumlatdev6/n6)/7;
					latdevsq6 += (latdev6/7) * (latdev6/7);
			
				}
			
				//S Bound MAIN (First to Yellow); start/stop is player.y; road edge is -7594
			if((player.x < -7552) && (player.x > -7744) && (player.y > -20404) && (player.y < -15148))
				{
					n7 += 1;
					latdev7 = abs((player.x + 28) + 7573);
					sumlatdev7 += abs((player.x + 28) + 7573);
					meanlatdev7 = (sumlatdev7/n7)/7;
					latdevsq7 += (latdev7/7) * (latdev7/7);
				//	ms = latdevsq7/n7;
				//	rmseL30 += (sqrt(ms))/7;
				}
			
				//S Bound MAIN (second yellow to 4th); start/stop is player.y; road edge is -7594
			if((player.x < -7552) && (player.x > -7744) && (player.y > -11204) && (player.y < -3132))
				{
					n8 += 1;
					latdev8 = abs((player.x + 28) + 7594);
					sumlatdev8 += abs((player.x + 28) + 7573);
					meanlatdev8 = (sumlatdev8/n8)/7;
					latdevsq8 += (latdev8/7) * (latdev8/7);
				//	ms = latdevsq8/n8;
				//	rmseL30 += (sqrt(ms))/7;
				}
				
				//W Bound 4th Ave start/stop is player.x; road edge is -2433
			if((player.x > -6804) && (player.x < 7124) && (player.y > -2448) && (player.y < -2288))
				{
					n9 += 1;
					latdev9 = abs((player.y - 28) + 2433);
					sumlatdev9 += abs((player.y - 28) + 2433);
					meanlatdev9 = (sumlatdev9/n9)/7;
					latdevsq9 += (latdev9/7) * (latdev9/7);
				//	ms = latdevsq9/n9;
				//	rmseL30 += (sqrt(ms))/7;
				}
			
				//N Bound COMMERCE to FIRST; start/stop is player.y; road edge is 7926
			if((player.x > 7912) && (player.x < 8080) && (player.y < -3212) && (player.y > -20400)) //29284
				{
					n10 += 1;
					latdev10 = abs((player.x - 28) - 7926);
					sumlatdev10 += abs((player.x - 28) - 7926);
					meanlatdev10 = (sumlatdev10/n10)/7;
					latdevsq10 += (latdev10/7) * (latdev10/7);
				//	ms = latdevsq10/n10;
				//	rmseL30 += (sqrt(ms))/7;
				}	
			
					//N Bound COMMERCE to MARKET; start/stop is player.y; road edge is 7915
			if((player.x > 7912) && (player.x < 8080) && (player.y < -22332) && (player.y > -29284)) //
				{
					n11 += 1;
					latdev11 = abs((player.x - 28) - 7915);
					sumlatdev11 += abs((player.x - 28) -7915);
					meanlatdev11 = (sumlatdev11/n11)/7;
					latdevsq11 += (latdev11/7) * (latdev11/7);
				//	ms = latdevsq11/n11;
				//	rmseL30 += (sqrt(ms))/7;
				}	
				
				//E Bound MARKET to Brdwy; start/stop is player.x; road edge is player.y is -30084
			if((player.x < 7204) && (player.x > 940) && (player.y < -30071) && (player.y > -30246))
				{
					n12 += 1;
					latdev12 = abs((player.y + 28) + 30084);//sometimes neg,tool artifact
					sumlatdev12 += abs((player.y + 28) + 30084);
					meanlatdev12 = (sumlatdev12/n12)/7;
					latdevsq12 += (latdev12/7) * (latdev12/7);
				//	ms = latdevsq12/n12;
				//	rmseL30 += (sqrt(ms))/7;
				}	
			
			//S Bound BROADWAY (market to First) ; start/stop is player.y; road edge is 164
			if((player.x < 208) && (player.x > 11) && (player.y > -29332) && (player.y < -22704))
				{
					n13 += 1;
					latdev13 = abs((player.x + 28) - 164);
					sumlatdev13 += abs((player.x + 28) - 164);
					meanlatdev13 = (sumlatdev13/n13)/7;
					latdevsq13 += (latdev13/7) * (latdev13/7);//square the deviations
				//	ms = latdevsq13/n13;
				//	rmseL30 += (sqrt(ms))/7;
				}
			
				//S Bound BROADWAY (First to Prking); start/stop is player.y; edge is 164; END of SCENARIO
			if((player.x < 208) && (player.x > 11) && (player.y > -20338) && (player.y < -18352))
				{
					n14 += 1;
					latdev14 = abs((player.x + 28) - 164);
					sumlatdev14 += abs((player.x + 28) - 164);
					meanlatdev14 = (sumlatdev14/n14)/7;//ave lat dev and convert to feet
					latdevsq14 += (latdev14/7) * (latdev14/7);
				//	ms = latdevsq14/n14;
				//	rmseL30 += (sqrt(ms))/7;
				}
		
			//rmseL30 = rmseL30/2;
			wait(-.1);
			}//end of loop
		
	}	//end of latdevL30 action
		
action scenariotimeL30//placed in bwk5
{
	if((verbalflag == 0) || (instructionsflag == 0))
		{
		wait(-16);
		}
	scenariotime = 0;
	while(1)//5 min duration
		{
		if(scenariotime < 300)
			{
			scenariotime += 1;
			}
		wait(-1);
		else
			{break;}
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
	endscenariopressESC_txt.VISIBLE = ON;
}
	action latdevL30v2()  //bwk3 LATERAL DEVIATIONS RMSe
	{
		msL30 = 0;
		rmseL30 = 0;
		squaresL30 = 0;
		
		if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-11);
			}
			
		while(1)
			{
				//N Bound Brdwy to Market (edge is -142)
				if((player.y > -29252) && (player.y < -18400) && (player.x < -16) && (player.x  > -176))
				{
					n1 += 1;//increment sample size
					latdev1 = abs((player.x - 28) + 142);//correct for width of car from eyepoint
					sumlatdev1 += abs((player.x - 28) + 142);//abs value of score
					//calculate average of scores
					meanlatdev1 = (sumlatdev1/n1)/7;//divide by sample, convert to feet
					//square the scores
					latdevsq1 += (latdev1/7) * (latdev1/7);//square of the scores
					
				}
				//N Bound Main; player.y start/stop road edge is -7902
			if((player.x > -7984) && (player.x < -7728) && (player.y < -22348) && (player.y > -29252))
				{
					n3 += 1;
					latdev3 = abs((player.x - 28) + 7902);
					sumlatdev3 += abs((player.x - 28) + 7902);
					meanlatdev3 = (sumlatdev3/n3)/7;
					latdevsq3 += (latdev3/7) * (latdev3/7);
		
				}
			
				//E Bound Market; player.x start/stop road edge is -30086
			if((player.y < -30048) && (player.y > -30240) && (player.x < -900) && (player.x > -11156))
				{
					n4 += 1;
					latdev4 =  abs((player.y + 28) + 30086);
					sumlatdev4 += abs((player.y + 28) + 30086);
					meanlatdev4 = (sumlatdev4/n4)/7;
					latdevsq4 += (latdev4/7) * (latdev4/7);
		
				}
			
				//S Bound Center start/stop is player.y; road edge is -12030
			if((player.y > -29332) && (player.y < -9000)  && (player.x < -11968) && (player.x > -12176))
				{
					n5 += 1;
					latdev5 = abs((player.x + 28) + 12030);
					sumlatdev5 += abs((player.x + 28) + 12030);
					meanlatdev5 = (sumlatdev5/n5)/7;
					latdevsq5 += (latdev5/7) * (latdev5/7);
			
				}
			
			//W Bound on 3rd ave; road edge is -8406
			if((player.x > -11500) && (player.x < -8500) && (player.y < -8256) && (player.y > -8448))
				{
					n5a += 1;
					latdev5a = abs((player.x + 28) + 8406);
					sumlatdev5a += abs((player.x + 28) + 8406);
					meanlatdev5a = (sumlatdev5a/n5a)/7;
					latdevsq5a += (latdev5a/7) * (latdev5a/7);
			
				}
			
			
				//S Bound MAIN from 3rd to 4th; start/stop is player.y; road edge is -7594
			if((player.x < -7552) && (player.x > -7744) && (player.y > -7600) && (player.y < -3132))
				{
					n8 += 1;
					latdev8 = abs((player.x + 28) + 7594);
					sumlatdev8 += abs((player.x + 28) + 7573);
					meanlatdev8 = (sumlatdev8/n8)/7;
					latdevsq8 += (latdev8/7) * (latdev8/7);
				//	ms = latdevsq8/n8;
				//	rmseL30 += (sqrt(ms))/7;
				}
				
				//W Bound 4th Ave start/stop is player.x; road edge is -2433
			if((player.x > -6804) && (player.x < 7124) && (player.y > -2448) && (player.y < -2288))
				{
					n9 += 1;
					latdev9 = abs((player.y - 28) + 2433);
					sumlatdev9 += abs((player.y - 28) + 2433);
					meanlatdev9 = (sumlatdev9/n9)/7;
					latdevsq9 += (latdev9/7) * (latdev9/7);
				//	ms = latdevsq9/n9;
				//	rmseL30 += (sqrt(ms))/7;
				}
			
				//N Bound COMMERCE to FIRST; start/stop is player.y; road edge is 7926
			if((player.x > 7912) && (player.x < 8080) && (player.y < -3212) && (player.y > -20400)) //29284
				{
					n10 += 1;
					latdev10 = abs((player.x - 28) - 7926);
					sumlatdev10 += abs((player.x - 28) - 7926);
					meanlatdev10 = (sumlatdev10/n10)/7;
					latdevsq10 += (latdev10/7) * (latdev10/7);
				//	ms = latdevsq10/n10;
				//	rmseL30 += (sqrt(ms))/7;
				}	
			
					//N Bound COMMERCE to MARKET; start/stop is player.y; road edge is 7915
			if((player.x > 7912) && (player.x < 8080) && (player.y < -22332) && (player.y > -29284)) //
				{
					n11 += 1;
					latdev11 = abs((player.x - 28) - 7915);
					sumlatdev11 += abs((player.x - 28) -7915);
					meanlatdev11 = (sumlatdev11/n11)/7;
					latdevsq11 += (latdev11/7) * (latdev11/7);
				//	ms = latdevsq11/n11;
				//	rmseL30 += (sqrt(ms))/7;
				}	
				
				//E Bound MARKET to Brdwy; start/stop is player.x; road edge is player.y is -30084
			if((player.x < 7204) && (player.x > 940) && (player.y < -30071) && (player.y > -30246))
				{
					n12 += 1;
					latdev12 = abs((player.y + 28) + 30084);//sometimes neg,tool artifact
					sumlatdev12 += abs((player.y + 28) + 30084);
					meanlatdev12 = (sumlatdev12/n12)/7;
					latdevsq12 += (latdev12/7) * (latdev12/7);
				//	ms = latdevsq12/n12;
				//	rmseL30 += (sqrt(ms))/7;
				}	
			
			//S Bound BROADWAY (market to First) ; start/stop is player.y; road edge is 164
			if((player.x < 208) && (player.x > 11) && (player.y > -29332) && (player.y < -22704))
				{
					n13 += 1;
					latdev13 = abs((player.x + 28) - 164);
					sumlatdev13 += abs((player.x + 28) - 164);
					meanlatdev13 = (sumlatdev13/n13)/7;
					latdevsq13 += (latdev13/7) * (latdev13/7);//square the deviations
				//	ms = latdevsq13/n13;
				//	rmseL30 += (sqrt(ms))/7;
				}
			
				//S Bound BROADWAY (First to Prking); start/stop is player.y; edge is 164; END of SCENARIO
			if((player.x < 208) && (player.x > 11) && (player.y > -20338) && (player.y < -18352))
				{
					n14 += 1;
					latdev14 = abs((player.x + 28) - 164);
					sumlatdev14 += abs((player.x + 28) - 164);
					meanlatdev14 = (sumlatdev14/n14)/7;//ave lat dev and convert to feet
					latdevsq14 += (latdev14/7) * (latdev14/7);
				//	ms = latdevsq14/n14;
				//	rmseL30 += (sqrt(ms))/7;
				}
		
			//rmseL30 = rmseL30/2;
			wait(-.1);
			}//end of loop
		
	}	//end of latdevL30v2 action			
	action movebluVanSbrdwyL30()// move blu van S on brdwy
		 {
		 	while(my.y < -14624)
			{
				if((player.x < 640) && (player.x > -224) && (player.y < -21616))
				{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // was AABB move ahead until en		
				}
				wait(1);
			}	
			ent_remove(me);
		}
	action moveS2brdwyL30() //use to kill performance display
	{
	
		//	wait(-11);
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			highbeams.VISIBLE = OFF;
			
		/*	my.FAT = ON; 
		//	my.NARROW = ON;
		//	vec_set(my.min_x,vector(-15,-15,-15));
		//	vec_set(my.max_x,vector(15,15,15));
		//	wait(1);	// wait 1 frame after creation
		
			disable_z_glide = 1;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.ENABLE_IMPACT = ON;
			my.ENABLE_ENTITY = ON;
			my.event = bounce_event;
			while(my.y < -16000)
			{
				if((player.x < 160) && (player.x > -1029) && (player.y < -17000) && (player.y > -21700))
				{
				c_move(my,vector(20*time_step,0,0),nullvector,GLIDE); // was AABB move ahead until en		
				}
				wait(1);
			}	
			ent_remove(me);
		*/	
	}  //end action
	
	action startL30//place in bwk3 
		{
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(drivetesturbanL30_wav,100,0);
					}
					
			if(instructionsflag == 0)
			{
			lesson30_txt.VISIBLE = ON;
			wait(-21);
			lesson30_txt.VISIBLE = OFF;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			while(1)
			{
		
				if(performflag == 0)//show if flag = 0
				{
				
						numcollisions_txt.VISIBLE = ON; // label for collisions
						numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
						speedexceed_txt.VISIBLE = ON; //label for speed exceed
						speedexceeddisp.VISIBLE = ON; //num of speedexceed
						noturnsignalcount_txt.VISIBLE = ON;
						noturnsignalcountdisp.VISIBLE = ON;
						followtooclose_txt.VISIBLE = ON;
						followtooclosedisp.VISIBLE = ON;
						brakeRT_txt.VISIBLE = ON;
						brakeRTdisp.VISIBLE = ON;
						
						if(full screen == 1)//FULL SCREEN
						{
					
						followtooclose_txt.pos_x = 650; //was 570
						followtooclose_txt.pos_y = 570;//was 550
						followtooclosedisp.pos_x = 806;     // Position the  display was 165
						followtooclosedisp.pos_y = 570;   // Use 4 and 600 for 1024
						
						noturnsignalcount_txt.pos_x = 650;
						noturnsignalcount_txt.pos_y = 580;
						noturnsignalcountdisp.pos_x = 806;
						noturnsignalcountdisp.pos_y = 580;
						
						brakeRT_txt.pos_x = 650; //was 570
						brakeRT_txt.pos_y = 590;//was 560
						brakeRTdisp.pos_x = 806;     // Position the  display was 165
						brakeRTdisp.pos_y = 590;   // Use 4 and 600 for 1024
						}
						if(full screen == 0)//WINDOWED
						{
					
						followtooclose_txt.pos_x = 630; //was 570
						followtooclose_txt.pos_y = 610;//was 550
						followtooclosedisp.pos_x = 806;     // Position the  display was 165
						followtooclosedisp.pos_y = 610;   // Use 4 and 600 for 1024
						
						noturnsignalcount_txt.pos_x = 630;
						noturnsignalcount_txt.pos_y = 620;
						noturnsignalcountdisp.pos_x = 806;
						noturnsignalcountdisp.pos_y = 620;
						
						brakeRT_txt.pos_x = 630; //was 570
						brakeRT_txt.pos_y = 630;//was 560
						brakeRTdisp.pos_x = 806;     // Position the  display was 165
						brakeRTdisp.pos_y = 630;   // Use 4 and 600 for 1024
						}
						
				}	
				wait(1);
			}//end loop	
		}
	action showdataL30() //assign bhouse9
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-21);
			}
			
			if(performflag == 0)//show if flag = 0
			{
						numcollisions_txt.VISIBLE = ON; // label for collisions
						numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
						speedexceed_txt.VISIBLE = ON; //label for speed exceed
						speedexceeddisp.VISIBLE = ON; //num of speedexceed
						noturnsignalcount_txt.VISIBLE = ON;
						noturnsignalcountdisp.VISIBLE = ON;
					//	followtooclose_txt.pos_x = 650; //was 570
						followtooclose_txt.pos_y = 560;//was 550
					//	followtooclosedisp.pos_x = 806;     // Position the  display was 165
						followtooclosedisp.pos_y = 560;   // Use 4 and 600 for 1024
						followtooclose_txt.VISIBLE = ON;
						followtooclosedisp.VISIBLE = ON;
					//	brakeRT_txt.pos_x = 650; //was 570
						brakeRT_txt.pos_y = 570;//was 560
					//	brakeRTdisp.pos_x = 806;     // Position the  display was 165
						brakeRTdisp.pos_y = 570;   // Use 4 and 600 for 1024
						brakeRT_txt.VISIBLE = ON;
						brakeRTdisp.VISIBLE = ON;
			}
			
		}//END OF ACTION	
		
	action moveN1brdwyL30() //assign to all traffic flowing With Driver in passing lane
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			my.ENABLE_SCAN = ON; 
			//my.ENABLE_DETECT = ON; 
			my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
			my.event = bounce_event;//removes me if I hit player
			
			my.ENABLE_TRIGGER = ON; // Ability to trigger events
			my.trigger_range = 13; //was 52
			my.PASSABLE = OFF;
		
		if(proginstL30 == 0)//execute if v.1 of L30
		{
			while(my.y > -29942.0) //while position is greater than x, continue moving
			{
				if(player.x < 864)
				{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE); // wa AABBmove ahead until end
				}
				wait(1);	
			}
			ent_remove(me);
		}
	}   //end of action

	action moveN1brdwyL30v2() //REMOVED assign to all traffic flowing With Driver in passing lane
	{
			
			wait(-15);//WAIT FOR Trafc lt
		
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			my.ENABLE_SCAN = ON; 
			//my.ENABLE_DETECT = ON; 
			my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
			my.event = bounce_event;//removes me if I hit player
			
			my.ENABLE_TRIGGER = ON; // Ability to trigger events
			my.trigger_range = 13; //was 52
			my.PASSABLE = OFF;
		
		//if(proginstL30 == 0)//execute if v.1 of L30
		//{
			//while(my.y > -29942.0) //while position is greater than x, continue moving
			//{
			//	if(player.x < 864)
			//	{
			//	c_move(my,vector(15*time_step,0,0),nullvector,GLIDE); // wa AABBmove ahead until end
			//	}
			//	wait(1);	
		//	}
		//	ent_remove(me);
		}
	}   //end of action

	action moveoncom2ndstL30()
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			while(my.x > -11000)
			{
				if (player.y > -2496 && player.x > -6800)	
				{
					c_move(my,vector(15*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				}
				wait(1);	
			}
			ent_remove(me);
		}
	action moveEonFirstL30()   //move on First street
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			fog_color = 0;
			//clearInstructText();
			//wait(-13); //wait for light to turn green
			my.ENABLE_SCAN = ON; 
			//my.ENABLE_DETECT = ON; 
			my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
			my.event = bounce_event;
			my.event = scan_event;
			wait(1);	// wait 1 frame after creation
				my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.x > -7430)	
				{
				c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
				}
			
			ent_remove(me);
			//
			/*wait(-7);//wait at light on First and Main
			
			while(my.x > -7528) //move into intersection
				{
				c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end	
				wait(1);
				}
				
				//c_rotate(me, vector(-15,0,0), IGNORE_YOU+GLIDE); //turn right
			while(my.x > -11700)	
				{
				c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + IGNORE_PASSABLE); // move ahead until end
				wait(1);
				}
				
			*/	
		}
	action moveWDrFirstL30tol()   //move on with driver on First street
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15); //wait for light to turn green
			}
			
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.x > -7200)
			{
			c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
			wait(1);		
			}
			
			while(my.x > -11888)
			{
			c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
			wait(1);	
			}
			
			ent_remove(me);
		}
		
	action moveWithDrivMainL30()    //move with Driver on Main Street
		{
			if((verbalflag == 0) || (instructionsflag == 0))
				{
				wait(-24);
				}
				
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y < -8500 ) //was 25500
			{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			ent_remove(me);
		}
	
	action moveFem2brdwyL30
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			var anim_speed = 0;
			my.frame = 1;
			while(my.x > -150)//player.y triggers
			{
				if(player.y > -22552) && (player.y < -21826) && (player.x < 192) && (player.x > 16)
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 12 * time_step; // was 22 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(4*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
				}
				wait(1);
			}
			ent_remove(me);
		}
	action Fem2brdwyL30v3//fem at y=-23904
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			var anim_speed = 0;
			my.frame = 1;
			while(my.x > -150)//player.y triggers
			{
				if(player.y > -24324) && (player.y < -21826) && (player.x < 192) && (player.x > 16)
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 12 * time_step; // was 22 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(4*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
				}
				wait(1);
			}
			ent_remove(me);
		}
	action Fem5MainL30v3 //move red female W across Main
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
		
			var anim_speed = 0;
			my.frame = 1;
			while(my.x < -7568)//player.y triggers
			{
				if((player.y > -25000) && (player.y < -23000) && (player.x < -7720) && (player.x > -7920))
				{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 12 * time_step; // was 22 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(4*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
				}
				wait(1);
			}
			ent_remove(me);
		}
	action hullparkedcar()
		{
			wait(1);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,0));//car length; x rear
			vec_set(my.max_x,vector(15,15,0));
			vec_set(my.min_y,vector(-15,-15,0));//car width, neg is right side
			vec_set(my.max_y,vector(15,15,0));
			
		//	c_setminmax(me);
		}
	action moveNonMAINL30
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my > -18900)
			{
				if((player.x > -7744) && (player.x < -7568) && (player.y > -20720))
				{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //move sideways to road
				}
				wait(1);
			}
			ent_remove(me);
		}
	action animateManL30() //on FOURTH ave brakeRT
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
		
			hasbraked = 0;
			brakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y < -2300) //move man until past road
			{
				if ((player.y > -2480) && (player.x > -2380) && (player.x < -2000) && (player.y < -2350))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				if((my.y > -2464) && (brakepedal >= 0) && (hasbraked == 0)) //man moves out, no braking indicated
					{
					brakeRT +=.1; //start adding to brake rt
					}
				if((brakepedal < 0) && (my.y > -2464))//braking
					{
					hasbraked += 1; //set to has braked, end brake rt increase
					}
				wait(-.1);
			}
			ent_remove(me);
		}
		action animateManL30v2() //on FOURTH ave brakeRT
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
		
			hasbraked = 0;
			brakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y < -2300) //move man until past road
			{
				if ((player.y > -2480) && (player.x > -2112) && (player.x < -1500) && (player.y < -2350))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				if((my.y > -2464) && (brakepedal >= 0) && (hasbraked == 0)) //man moves out, no braking indicated
					{
					brakeRT +=.1; //start adding to brake rt
					}
				if((brakepedal < 0) && (my.y > -2464))//braking
					{
					hasbraked += 1; //set to has braked, end brake rt increase
					}
				wait(-.1);
			}
			ent_remove(me);
		}
		
		action animateManL30v3() //on FOURTH ave brakeRT
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			hasbraked = 0;
			brakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y < -2300) //man is at x= 1168 move man until past road
			{
				if ((player.y > -2480) && (player.x > 722) && (player.x < 1680) && (player.y < -2304))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				if((my.y > -2464) && (brakepedal >= 0) && (hasbraked == 0)) //man moves out, no braking indicated
					{
					brakeRT +=.1; //start adding to brake rt
					}
				if((brakepedal < 0) && (my.y > -2464))//braking
					{
					hasbraked += 1; //set to has braked, end brake rt increase
					}
				wait(-.1);
			}
			ent_remove(me);
		}
		action moveRedFem3rdL30v2() //on FOURTH ave brakeRT
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			hasbraked = 0;
			brakeRT = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y < -8016) //move man until past road
			{
				if ((player.y > -8432) && (player.x > -1028)  && (player.y < -8256))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.y > -2464) && (brakepedal >= 0) && (hasbraked == 0)) //man moves out, no braking indicated
				//	{
				//	brakeRT +=.1; //start adding to brake rt
				//	}
				//if((brakepedal < 0) && (my.y > -2464))//braking
				//	{
				//	hasbraked += 1; //set to has braked, end brake rt increase
				//	}
				wait(-.1);
			}
			ent_remove(me);
		}
	action movegrBMW1stL30v2()//car is at y=-21411
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.x < 7824)
			{
				if((player.x > 7904) && (player.x < 8080) && (player.y < -18000))
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); 
					
				}
			wait(1);
			}
			wait(-2);//stop at stop sign for 2 sec then pull out into rd
			
			while(my.x < 7952)
			{
				if((player.x > 7904) && (player.x < 8080) && (player.y < -20991))	
				{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); 
					
				}
			wait(1);
			}
			wait(-4);
			
			while(my.x > 7808)
			{
				if((player.x > 7904) && (player.x < 8080) && (player.y < -20991))	
				{
					c_move(my,vector(-10*time_step,0,0),nullvector,GLIDE + USE_AABB); 
					
				}
			wait(1);
			}
		}
	action movecitroon4thL30()//citro wh g move on to 4th ave near constr hzrd
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.x < 6900)
			{
				if((player.y > -2480) && (player.y < -2350) && (player.x > -2100) && (player.x < -2000) )
				{
					while(my.x < -1800 ) //was 25500	
					{
					c_move(my,vector(6*time_step,0,0),nullvector,GLIDE + USE_AABB);	
					wait(1);
					}
					c_rotate(me, vector(15,0,0), IGNORE_YOU);
					
					while(my.x < -1600 ) //was 25500	
					{
					c_move(my,vector(6*time_step,0,0),nullvector,GLIDE + USE_AABB);	
					wait(1);
					}
					c_rotate(me, vector(-15,0,0), IGNORE_YOU);
					
					while(my.x < 2800 ) //was 25500	
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB);	
					wait(1);
					}
					ent_remove(me);
				}
			wait(1);
			}	
		}
		
	action moveViolSCommL30()    //move Blue Car to Commerce intersection
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			wait(1);	// wait 1 frame after creation

			while(my.y < -5950) //was 25500
				{
				if((player.y < -5920) && (player.y > -29008) && (player.x > 7936) && (player.x < 8080))
					{
					c_move(my,vector(20*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					
					}
					wait(1);
				}
			ent_remove(me);
		}
	action moveBluBMWCommL30()    //move Blue Car to across Commerce intersection
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);//wait 
			}
			
			while(my.x < 10650) //was 25500
				{
				if((player.y < -6320) && (player.x > 7936) && (player.x < 8064))
					{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move ahead until
					}
				wait(1);	
				}
			ent_remove(me);
		}
action moveWhVanSonMainL30()    //move White Van on Main Street
		{
			fog_color = 0;
			
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);//wait 
			}
			
			wait(-56);//13 til first green,then 23 til green again
			wait(1);	// wait 1 frame after creation
		
			while(my.y < -8500) //was 25500
			{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move ahead until end
				wait(1);
			}
			ent_remove(me);
		}	
 action moveSilvSCommL30()    //move Blue Car to Commerce intersection
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			//wait(-37);//13 til first green,then 23 til green again
			wait(1);	// wait 1 frame after creation
			while(my.y < -9000) //was 25500
				{
				if((player.y < -5920) && (player.y > -29008) && (player.x > 7936) && (player.x < 8080))
					{
					c_move(my,vector(20*time_step,0,0),nullvector,GLIDE); // move ahead until
					}
				wait(1);	
				}
			ent_remove(me);
		}
action moveTolEmrktL30() // move toland E on Market past brdwy
			{
				if((verbalflag == 0) || (instructionsflag == 0))
				{
				wait(-15);
				}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
				while(my.x > 272)//move to brdwy
				{
				if((my.y > -30128) && (player.x < 2096) && (player.x > -288) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(0,10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				if((player.x < 2096) && (player.x > -288) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				wait(-2);//stop at stops sign brdwy and market intersect
				
				while(my.x > -6800)
				{
					if((player.x < 2096) && (player.x > -288) && (player.y > -30224) && (player.y < -27920))
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				ent_remove(me);
			}
			
action moveVanW4thL30v3() // move white van
			{
			if((verbalflag == 0) || (instructionsflag == 0))
			{	
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
				while(my.x < 3950)//move to brdwy
				{
				if((my.y < -2400) && (player.x > -1360) && (player.y < -2300) && (player.y > -2464))
					{
						c_move(my,vector(0,10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				if((player.x < 2096) && (player.x > -1360) && (player.y < -2300) && (player.y > -2464))
					{
						c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
				if((my.x < 3800) && (player.x < 2096) && (player.x > -1360) && (player.y < -2300) && (player.y > -2464))
					{
						c_move(my,vector(0,-6*time_step,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
				wait(1);
				}
				ent_remove(me);
		}	
		
action movewVanW1stL30v3() // move toland E on Market past brdwy
			{
				if((verbalflag == 0) || (instructionsflag == 0))
				{
				wait(-15);
				}
				
				my.FAT = ON; 
				my.NARROW = ON;
				vec_set(my.min_x,vector(-15,-15,-15));
				vec_set(my.max_x,vector(15,15,15));
				while(my.x > 272)//move to brdwy
				{
				if((my.y > -30128) && (player.x < 2096) && (player.x > -288) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(0,10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				if((player.x < 2096) && (player.x > -288) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				wait(-2);//stop at stops sign brdwy and market intersect
				
				while(my.x > -6800)
				{
					if((player.x < 2096) && (player.x > -288) && (player.y > -30224) && (player.y < -27920))
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				ent_remove(me);
			}			
action bluVanEmrktL30v2() // move blu Van E on Market past brdwy
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);//car at x=3680
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.x > 272)//move to brdwy
				{
				if((my.y > -30128) && (player.x < 4100) && (player.y < -30064) && (player.y > -30240))
					{
					c_move(my,vector(0,10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				if((player.x < 4100) && (player.y < -30064) && (player.y > -30240))
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				
				wait(-2);//stop at stops sign brdwy and market intersect
				
			while(my.x > -6800)
				{
					if((player.x < 4084) && (player.y > -30240) && (player.y < -30064))
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				ent_remove(me);
		}
			
action movegrBMWEonMrktL30()//pull out travel strt then park
			{
				if((verbalflag == 0) || (instructionsflag == 0))
				{
				wait(-15);
				}
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
				while(my.x > -7360)//move to main
				{
				if((my.y > -30128) && (player.x < -4144) && (player.x > -30240) && (player.y > -30240) && (player.y < -30064))
					{
						c_move(my,vector(0,10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				if((player.x < -4144) && (player.x > -30240) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				if(my.x > -7152)// && (player.x < -4144) && (player.x > -30240) && (player.y > -30064) && (player.y < -30240 ))
					{
						c_move(my,vector(0,-10*time_step,0),nullvector,GLIDE + USE_AABB); 
					}
				break;
				}
			}
action movetolWonFirstL30()
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-33);//time to trafc lt turns green
			}
			
			wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.x < -624) //was -624	
			{
			c_move(my,vector(12*time_step,0,0),nullvector,GLIDE);	
			wait(1);
			}
			
			ent_remove(me);
			
		}
	
action movetwoWonFirstL30()
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
		while (my.x < -8098 )//was 25500	
			{
			c_move(my,vector(5*time_step,0,0),nullvector,GLIDE);	
			wait(1);
			}
	
		}
action movetwo2WonFirstL30()
		{
			fog_color = 0;
			//clearInstructText();
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-27);
			}
			wait(1);	// wait 1 frame after creation
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.x < -8198) //was 25500	
			{
			c_move(my,vector(5*time_step,0,0),nullvector,GLIDE);	
			wait(1);
			}
			wait(-11);
			while(my.x < -304 )
			{
			c_move(my,vector(10*time_step,0,0),nullvector,GLIDE);	
			wait(1);
			}
			ent_remove(me);
		}
action moveWonMarktL30()
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.x < -6000) //was 25500	
			{
				if((player.y < -27400) && (player.x < -7700) && (player.x > -10000))
				{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			ent_remove(me);
		}
action moveWMktSbrdL30()//move W on Market So of Brdwy
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.x < 7200) //was 25500	
			{
				if((player.y < -30000) && (player.y > -30400) && (player.x < 3728) && (player.x > -270))
				{
				c_move(my,vector(15*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			ent_remove(me);
			
		}
action	bluefemwalkL30() //on center st. brakeRT5
	
	{		
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			hasbraked5 = 0;
			brakeRT5 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x < -12030) //move until mid road
			{
				if ((player.y > -11690) && (player.y < -11400)&& (player.x < -12032) && (player.x > -12160)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				if((my.x < -12036) && (brakepedal >= 0) && (hasbraked5 == 0)) //man moves out, no braking indicated
					{
					brakeRT5 +=.1; //start adding to brake rt
					}
				if((brakepedal < 0)&&(my.x < -12036))//braking
					{
					hasbraked5 += 1; //set to has braked, end brake rt increase
					}
				wait(-.1);
			}
			ent_remove(me);
		}
		
action manwalkfirstL30()  //brakeRT3 first ave.
		
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			hasbraked3 = 0;
			brakeRT3 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y < -21376) //move man until past road
			{
				if ((player.y > -21536) && (player.y < -21392) && (player.x > -9990) && (player.x < -9536)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				if((my.y >-21531) && (brakepedal >= 0) && (hasbraked3 == 0)) //man moves out, no braking indicated
					{
					brakeRT3 +=.1; //start adding to brake rt
					}
				if((brakepedal < 0) && (my.y > -21531))//braking
					{
					hasbraked3 += 1; //set to has braked, end brake rt increase
					}
				wait(-.1);
			}
			ent_remove(me);
		}
action frau1marketL30()  //move across market
		
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			hasbraked3 = 0;
			brakeRT3 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y > -30400) //move man until past road
			{
				if ((player.y > -30240) && (player.y < -30096) &&  (player.x < -9280)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6 *time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.y >-21531) && (brakepedal >= 0) && (hasbraked3 == 0)) //man moves out, no braking indicated
					{
					//brakeRT3 +=.1; //start adding to brake rt
					//}
				//if((brakepedal < 0) && (my.y > -21531))//braking
					{
					//hasbraked3 += 1; //set to has braked, end brake rt increase
					//}
				wait(-.1);
			}
			ent_remove(me);
		}
	action frau1mrktL30v2()  //move across market
		
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			hasbraked3 = 0;
			brakeRT3 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y > -30400) //move man until past road
			{
				if ((player.y > -30240) && (player.y < -30096) &&  (player.x < -3600)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6 *time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.y >-21531) && (brakepedal >= 0) && (hasbraked3 == 0)) //man moves out, no braking indicated
					{
					//brakeRT3 +=.1; //start adding to brake rt
					//}
				//if((brakepedal < 0) && (my.y > -21531))//braking
					{
					//hasbraked3 += 1; //set to has braked, end brake rt increase
					//}
				wait(-.1);
			}
			ent_remove(me);
		}
	action frau1FirstL30v2()  //
		
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
		//	hasbraked3 = 0;
		//	brakeRT3 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y > -21200) //
			{
				if ((player.y > -21552) && (player.y < -21360) &&  (player.x > -10000) &&  (player.x < -9200)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(-6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.y >-21531) && (brakepedal >= 0) && (hasbraked3 == 0)) //man moves out, no braking indicated
				//	{
					//brakeRT3 +=.1; //start adding to brake rt
					//}
				//if((brakepedal < 0) && (my.y > -21531))//braking
				//	{
					//hasbraked3 += 1; //set to has braked, end brake rt increase
					//}
				wait(-.1);
			}
			ent_remove(me);
		}	
action fem5walkmainL30()  //red female on MAIN/SECOND intersection
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			hasbraked2 = 0;
			brakeRT2 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -8600) //move fem until past road
			{
				if ((player.x > -7712) && (player.x < -7600) && (player.y > -14868))//trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.x > -167.0) && (brakepedal >= 0) && (hasbraked2 == 0)) //man moves out, no braking indicated
					//{
					//brakeRT2 +=.1; //start adding to brake rt
					//}
				//if((brakepedal < 0)&&(my.x > -167.0))//braking
					//{
					//hasbraked2 += 1; //set to has braked, end brake rt increase
					//}
				wait(-.1);
			}
			ent_remove(me);
			
		}
action fem5walkmainL30v2()  //red female on MAIN/SECOND intersection
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			hasbraked2 = 0;
			brakeRT2 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -7952) //move fem 
			{
				if ((player.x > -7712) && (player.x < -7600) && (player.y > -15500))//trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				//if((my.x > -167.0) && (brakepedal >= 0) && (hasbraked2 == 0)) //man moves out, no braking indicated
					//{
					//brakeRT2 +=.1; //start adding to brake rt
					//}
				//if((brakepedal < 0)&&(my.x > -167.0))//braking
					//{
					//hasbraked2 += 1; //set to has braked, end brake rt increase
					//}
				wait(-.1);
			}
			ent_remove(me);
			
		}
action femRed3rdL30v2() //fem at x=-10000
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			while(my.y < -8000) //move man until past road
			{
				if ((player.x > -10420) && (player.y > -8432) && (player.y < -8256))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				wait(1);
			}
			ent_remove(me);
		}
action Frau1FirstL30v3() //
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			while(my.y < -21200) //move man until past road
			{
				if ((player.x > -10100) && (player.x < -9200) && (player.y > -21536) && (player.y < -21400))//trigger walk man from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				wait(1);
			}
			ent_remove(me);
		}

	action fem5ctrL30v2() //fem at y=-9216
		{
			//wait(-15);
			hasbraked4 = 0;
			brakeRT4 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -12304) //move fem until past road
			{
				if ((player.y > -9636) && (player.y < -8593) && (player.x < -11984) && (player.x > -12160))//trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(8*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
			//	if((my.y < -14000) && (brakepedal >= 0) && (hasbraked4 == 0)) //man moves out, no braking indicated
			//		{
			//		brakeRT4 +=.1; //start adding to brake rt
			//		}
			//	if((brakepedal < 0)&&(my.y < -14000))//braking
			//		{
			//		hasbraked4 += 1; //set to has braked, end brake rt increase
			//		}
			wait(-.1);
			}
			ent_remove(me);
		}	
action moveEon4thL30
		{
			//wait(-15);//wait 
			while(my.x > -6500)
			{
				if((player.x > -6500) && (player.y > -2480) && (player.y < -2288))
				{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}	
	
action moveEonMrktL30//move platoon E on Mrkt across brdwy
		{
			//wait(-15);//wait 
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
				while(my.x > 272)//move to brdwy
				{
				if((my.y < -28000) && (player.x < 8192) && (player.x > -288) && (player.y < -30064) && (player.y > -30240))
					{
						c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				wait(-2);//stop at stops sign brdwy and market intersect
				
				while(my.x > -6800)
				{
					if((player.x < 2096) && (player.x > -288) && (player.y > -30224) && (player.y < -27920))
					{
					c_move(my,vector(10*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until
					}
					wait(1);
				}
				ent_remove(me);
		}	
action moveEonMrktEMainL30()
		{
			wait(-5);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.x > -11800)
			{
			if((player.y < -27400) && (player.x < -7700) && (player.x > -11800))
				{
				c_move(my,vector(5*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			ent_remove(me);
		}	
action turnsignalcheckL30() //check for right turn signal bhouse11_mdl 3441
		{
			 
			wait(-5);
		
			while(1)
			{
			
			
				//check RIGHT turn signal intersection 1 Is this Brdwy and First
				if((alertsflag == 0) && (player.x > -192) && (player.x < 16) && (player.y < -20400) && (player.y > -21000) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
				noturnsignalcount +=1;
				}
						
				//check LEFT turn on MAIN from FIRST going N on FIRST
				if((player.x > -7336) && (player.x < -6750) && (player.y < -21232) && (player.y > -21344) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))		
				{
				noturnsignalcount +=1;
				}
		
			
				//check RIGHT turn on MARKET from MAIN (used L30v2)
				if((player.x > -7968) && (player.x < -7744) && (player.y > -29500) && (player.y < -28880) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
					//check RIGHT turn on MARKET from BROADWAY
				if((player.x > -176) && (player.x < 16) && (player.y > -29500) && (player.y < -28976) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
				//check RIGHT turn on to Center from MARKET
				if((player.y < -30064) && (player.y > -30224) && (player.x > -11888) && (player.x < -11188)  && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
				//check RIGHT turn on THIRD from CENTER used for v2
				
				if((player.x < -11968) && (player.x > -12176 ) && (player.y < -9200) && (player.y > -9500) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				//check LEFT turn on MAIN from THIRD used for v2
				
				if((player.x < -9000 ) && (player.x > -10000 ) && (player.y < -8256) && (player.y > -8448) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				//check RIGHT turn on FIRST from CENTER
			
				if((player.x < -11984) && (player.x > -12192) && (player.y < -21712) && (player.y > -22352) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
			
				//check LEFT turn on to MAIN from FIRST 
				
				if((player.x < -8096) && (player.x > -8624) && (player.y < -21376) && (player.y > -21568) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))		
				{
				noturnsignalcount +=1;
				}
		
				//check LEFT turn signal intersection flash Yellow	into parking lot
				//if((player.x < -7552 && player.x > -7728) && (player.y > -12692 && player.y < -12420) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))	
				//{
				//noturnsignalcount +=1;
				//}
				
				//check RIGHT turn signal intersection Main and 4th	
				if((player.x < -7540) && (player.y > -3264) && (player.y < -2600) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))	
				{
				noturnsignalcount +=1;
				}
				
				//check RIGHT turn signal intersection 4th and COMMERCE
				if((player.x < 7792) && (player.x > 7092) && (player.y > -2464) && (player.y < -2304) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))	
				{
				noturnsignalcount +=1;
				}
				
				//check RIGHT turn signal intersection COMMERCE and MARKET
				if((player.x > 7888) && (player.x < 8064) && (player.y < -29284) && (player.y > -29984) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))	
				{
				noturnsignalcount +=1;
				}
				
				//check RIGHT turn signal intersection MARKET and BROADWAY
				if((player.x > 240) && (player.x < 840) && (player.y > -30224) && (player.y < -30048) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))	
				{
				noturnsignalcount +=1;
				}
			wait(-1);
			}
		}	
	
action progressinstructL30() //check for right turn signal bwk4
		{
			wait(-3);
			
			while(1)
			{	
				//LEFT turn on BROADWAY from start PARKING LOT (START POSTION OF L30
				//
				if((startonce == 0) && (player.x < 864) && (player.x > 224) && (player.y < -17100) && (player.y > -17344))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
					turnleftprkingtobrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnleftprkingtobrdwy_txt.VISIBLE=OFF;
					startonce = 1;
				}
			
				//RIGHT turn on First from BROADWAY
				if((player.x > -210) && (player.x < -16) && (player.y < -19100) && (player.y > -20000))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightattrafficltahead_wav,100,0);
					}
					turnrtbrdwytofirst_txt.VISIBLE=ON;
					wait(-4);
					turnrtbrdwytofirst_txt.VISIBLE=OFF;
				}
				
				//LEFT turn on MAIN from FIRST going N on Market was -7336
				if((player.x > -6336) && (player.x < -5000) && (player.y < -21232) && (player.y > -21344))		
				{
				if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftattrafficltahead_wav,100,0);
					}
					turnleftfirsttomain_txt.VISIBLE=ON;
					wait(-4);
					turnleftfirsttomain_txt.VISIBLE=OFF;
				}
				
				
				//RIGHT turn on MARKET from MAIN was -29920
				if((player.x > -7968) && (player.x < -7744) && (player.y > -28920) && (player.y < -27600))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightmaintomrkt_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintomrkt_txt.VISIBLE=OFF;
				}
				
				//RIGHT Turn on to CENTER from MARKET was -11800
				if((player.x > -10800) && (player.x < -10300) && (player.y < -30064) && (player.y > -30240))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmrkttocenter_txt.VISIBLE = ON;
					wait(-4);
					turnrightmrkttocenter_txt.VISIBLE = OFF;
				}
				
				// RIGHT turn on FIRST from CENTER was -23700
				
				if((player.x < -11984) && (player.x > -12192) && (player.y > -23400) && (player.y < -22700))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightattrafficltahead_wav,100,0);
					}
					turnrtctrtofirst_txt.VISIBLE=ON;
					wait(-4);
					turnrtctrtofirst_txt.VISIBLE=OFF;
				}
				
				//LEFT turn on MAIN from FIRST going S was -8096
				
				if((player.x < -9008) && (player.x > -10224) && (player.y < -21376) && (player.y > -21552))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftattrafficltahead_wav,100,0);
					}
					turnleftfirsttomain_txt.VISIBLE=ON;
					wait(-4);
					turnleftfirsttomain_txt.VISIBLE=OFF;
				}
				
				//PROCEED thru SECOND was -14600
				if((player.x > -7744) && (player.x < -7552) && (player.y > -17648) && (player.y < -16800))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					
					proceedthrusecondave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrusecondave_txt.VISIBLE = OFF;
				}
				
					//PROCEED thru THIRD //was -8544
				if((player.x > -7744) && (player.x < -7552) && (player.y > -10000) && (player.y < -9200))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthruthirdave_txt.VISIBLE = ON;
					wait(-4);
					proceedthruthirdave_txt.VISIBLE = OFF;
				}
				//RIGHT turn intersection MAIN and 4th	
				if((player.x > -7744) && (player.x < -7552) && (player.y > -3900) && (player.y < -3000))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmaintofourth_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintofourth_txt.VISIBLE=OFF;
				}
				
				//PROCEED thru Intersection ahead BROADWAY was -400
				if((player.x < -1400) && (player.x > -1872) && (player.y > -2512) && (player.y < -2288))
					{
						if(verbalflag == 0)
						{
						snd_stop(navigation_handle);
						navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
						}	
					proceedthrubrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrubrdwy_txt.VISIBLE=OFF;
				}
				
				//RIGHT fourth on to COMMERCE /was 7700
				
				if((player.x < 7500) && (player.x > 7172) && (player.y > -2432) && (player.y < -2288))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightfourthtocommerce_txt.VISIBLE=ON;
					wait(-4);
					turnrightfourthtocommerce_txt.VISIBLE=OFF;
				}
				
				//PROCEED thru FIRST AVE on COMMERCE N Bound was -21040
				if((player.x > 7904) && (player.x < 8702) && (player.y < -18624) && (player.y > -20040))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				
				//turn RIGHT from COMMERCE on to MARKET was 7904
				
				if((player.x > 7904) && (player.x < 8064) && (player.y < -28500) && (player.y > -29300))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightcommercetomrkt_txt.VISIBLE=ON;
					wait(-4);
					turnrightcommercetomrkt_txt.VISIBLE=OFF;
				}
					//turn RIGHT from MARKET on to BROADWAY was 450
				
				if((player.x < 1800) && (player.x > 1450) && (player.y < -30032) && (player.y > -30240))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightmrkttobrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnrightmrkttobrdwy_txt.VISIBLE=OFF;
				}
				
				//S BOUND BROADWAY PROCEED THRU FIRST AVE
				
				if((player.x < 192) && (player.x > 12) && (player.y < -22500) && (player.y > -23000))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					
					proceedthrufirstbrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrufirstbrdwy_txt.VISIBLE=OFF;
				}
				
				//S BOUND BROADWAY TURN RT into PARKING END SCENARIO was -17760
				
				if((player.x < 192) && (player.x > 12) && (player.y < -18760) && (player.y > -20000))	
				{
					endonceL30 = 1;
					
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrtintoparklotahead_wav,100,0);
					}
					turnrightprkingbrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnrightprkingbrdwy_txt.VISIBLE=OFF;
				}
					//END SCENARIO was -17760
				
				if((endonceL30 == 1) && (player.x < 400) && (player.x > 288) && (player.y > -17536) && (player.y < -17024))	
				{
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
					endscenariopressESC_txt.VISIBLE=ON;
					
					break;
				}
			wait(-.1);
			}
		}
action proginstL30v2() // bwk5_mdl on brdwy
		{
			proginstL30 = 2;//set flag for v.2 of L30
			
			wait(-3);
			while(1)
			{	
				//LEFT turn on BROADWAY from start PARKING LOT
				if((startonce == 0) && (player.x < 864) && (player.x > 224) && (player.y < -17100) && (player.y > -17344))		
				{
					if(verbalflag == 0)
					{
						snd_stop(navigation_handle);
						navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
				
					turnleftprkingtobrdwy_txt.VISIBLE=ON;//turn left on to Broadway
					wait(-4);
					turnleftprkingtobrdwy_txt.VISIBLE=OFF;
					startonce = 1;
				}
			
				//PROCEED thru First on BROADWAY
				if((player.x > -192) && (player.x < -16) && (player.y < -19100) && (player.y > -20000))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstbrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrufirstbrdwy_txt.VISIBLE=OFF;
				}
		
				//RIGHT turn on MARKET from BRDWY
				if((player.x > -192) && (player.x < 16) && (player.y > -29300) && (player.y < -29100))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmaintomrkt_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintomrkt_txt.VISIBLE=OFF;
				}
				//LEFT turn on MAIN from FIRST going N on Market was -7336
				//if((player.x > -6336) && (player.x < -5000) && (player.y < -21232) && (player.y > -21344))		
				//{
				//	turnleftfirsttomain_txt.VISIBLE=ON;
				//	wait(-4);
				//	turnleftfirsttomain_txt.VISIBLE=OFF;
				//}
				
				//PROCEED thru Intersection of MARKET and FIRST was -11800
				if((player.x < -6600) && (player.x > -7312) && (player.y < -30064) && (player.y > -30240))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				//RIGHT Turn on to CENTER from MARKET was -11800
				if((player.x > -10800) && (player.x < -10300) && (player.y < -30064) && (player.y > -30240))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmrkttocenter_txt.VISIBLE = ON;
					wait(-4);
					turnrightmrkttocenter_txt.VISIBLE = OFF;
				}
				
				//PROCEED thru FIRST on CENTER
				if((player.x < -11984) && (player.x > -12192) && (player.y > -23400) && (player.y < -22700))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				//RIGHT turn onto 3rd from CENTER
				
				if((player.x > -12176) && (player.x < -12000) && (player.y > -11000) && (player.y < -10400))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightctrto3rd_txt.VISIBLE = ON;
					wait(-4);
					turnrightctrto3rd_txt.VISIBLE = OFF;
				}
				
				//LEFT turn onto MAIN from THIRD going S
				
				if((player.x > -9680) && (player.x < -9264) && (player.y > -8448) && (player.y < -8272))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftattrafficltahead_wav,100,0);
					}
					
					turnleftfirsttomain_txt.VISIBLE=ON;
					wait(-4);
					turnleftfirsttomain_txt.VISIBLE=OFF;
				}
				
	
				//RIGHT turn intersection MAIN and 4th	
				if((player.x > -7744) && (player.x < -7552) && (player.y > -3900) && (player.y < -3000))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmaintofourth_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintofourth_txt.VISIBLE=OFF;
				}
				
				//PROCEED thru Intersection ahead BROADWAY was -400
				if((player.x < -1400) && (player.x > -1872) && (player.y > -2512) && (player.y < -2288))
					
					{
						if(verbalflag == 0)
						{
						snd_stop(navigation_handle);
						navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
						}
					proceedthrubrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrubrdwy_txt.VISIBLE=OFF;
					}
				
				//RIGHT fourth on to COMMERCE /was 7700
				
				if((player.x < 7500) && (player.x > 7172) && (player.y > -2432) && (player.y < -2288))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightfourthtocommerce_txt.VISIBLE=ON;
					wait(-4);
					turnrightfourthtocommerce_txt.VISIBLE=OFF;
				}
				
				//PROCEED thru FIRST AVE on COMMERCE N Bound was -21040
				if((player.x > 7904) && (player.x < 8702) && (player.y < -18624) && (player.y > -20040))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				
				//turn RIGHT from COMMERCE on to MARKET was 7904
				
				if((player.x > 7904) && (player.x < 8064) && (player.y < -28500) && (player.y > -29300))	
				{	
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					
					turnrightcommercetomrkt_txt.VISIBLE=ON;
					wait(-4);
					turnrightcommercetomrkt_txt.VISIBLE=OFF;
				}
					//turn RIGHT from MARKET on to BROADWAY was 450
				
				if((player.x < 1800) && (player.x > 1450) && (player.y < -30032) && (player.y > -30240))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmrkttobrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnrightmrkttobrdwy_txt.VISIBLE=OFF;
				}
				
				//S BOUND BROADWAY PROCEED THRU FIRST AVE
				
				if((player.x < 192) && (player.x > 12) && (player.y < -22500) && (player.y > -23000))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstbrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrufirstbrdwy_txt.VISIBLE=OFF;
				}
				
				//S BOUND BROADWAY TURN RT into PARKING END SCENARIO was -17760
				
				if((player.x < 192) && (player.x > 12) && (player.y < -18760) && (player.y > -20000))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrtintoparklotahead_wav,100,0);
					}
					
					endonceL30 = 1;
					turnrightprkingbrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnrightprkingbrdwy_txt.VISIBLE=OFF;
				}
					//END SCENARIO was -17760
				
				if((endonceL30 == 1) && (player.x < 400) && (player.x > 288) && (player.y > -17536) && (player.y < -17024))	
				{
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
					endscenariopressESC_txt.VISIBLE=ON;
					wait(-4);
					endscenariopressESC_txt.VISIBLE=OFF;
					break;
				}
			wait(-.1);
			}
		}			
action speedlimit10market() //assign to 10mph sign
	{
		
		while(1)
			{
				if((car_velocity > 20) && (car_velocity < 42) && (player.y > -30576) && (player.y <-30016 ) && (player.x > -15024) && (player.x < 4704))

				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
	}
action speedlimit10comm() //assigned to 10mph sign on commerce
	{
			wait(-5);
			while(1)
			{
				if((car_velocity > 20) && (car_velocity < 42) && (player.y > -4448) && (player.y <-28528 ) && (player.x < 8272) && (player.x > 7888))

				{
					speedexceed += 1;		
				}
				wait(-1);
			}			
	}
	
action bluebmw()
	{
		if(proginstL30 == 0)
		{
			wait(-11);
			//my.FAT = ON; 
			//my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y < -18500)//move S on Broadway when lateral ends
			{
				if ((player.y > -23800) && (player.x > -12144) && (player.x < -12006) && (my.x > -12064))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move left
					}	
				if((player.y > -23800)	&& (player.x < -12006))
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}
				if ((my.y > -19500) && (my.x < -12000))	//trigger move
					{
					c_move (me,vector(0,-6*time,0),nullvector,IGNORE_YOU|GLIDE); //move right
					}
					
		 		wait(1);  
	 		}	
		}
		ENT_REMOVE(me);
	}
	
action whVANCommL30v3()//pull out Commerce
	{
			//wait(-15);
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.y > -27872)//move N on Broadway when lateral ends
			{
				if ((my.x < 7952) && (player.y < -22800) && (player.x < 8080) && (player.x > 7904))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y < -22880) && (player.x < 8080) && (player.x > 7904)) //&& (my.x == -12064))
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
		 		wait(1);  
	 		} 	
	 		while(1)
	 		{
	 			if ((my.x > 7904) && (player.y < -22800) && (player.x < 8080) && (player.x > 7904))	//trigger move
					{
					c_move (me,vector(0,-6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}
				wait(1);
		//ent_remove(me);
			}
	}


action BMWCtrL30v3()//pullout on Center
	{
			//wait(-15);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			
			while(my.y < -8500)//move N on Broadway when lateral ends
			{
				if ((my.x > -12064) && (player.y > -28640) && (player.x < -12006) && (player.x > -12192))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y > -28640)	&& (player.x < -12006)) //&& (my.x == -12064))
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
		 		wait(1);  
	 		}  
	 		
		ent_remove(me);
	}
	
action grnTOLL30v3()//pullout on Broadway
	{
			//wait(-15);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y < -14100)//move N on Broadway when lateral ends && (player.y < -19000)
			{
				if ((my.x > 128) && (startonce == 1) && (player.y > -20500) && (player.y < -17700)&& (player.x > 16) && (player.x < 880))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y > -20500) && (player.y < -17700) && (player.x > 16) && (player.x < 192)) //&& (my.x == -12064))
					{
					c_move (me,vector(14*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
		 		wait(1);  
	 		} 
	 		/*
	 		while((my.x < 192) && (player.y > -20500) && (player.y < -18000) && (player.x > 16) && (player.x < 192))
	 				{
					c_move (me,vector(0,-6*time,0),nullvector,IGNORE_YOU|GLIDE); //
					}
	 			wait(1);
	 		*/	
		//ent_remove(me);
	}
action grnBMWctrL30v2()
	{
			//wait(-15);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y < -8500)//move N on Broadway when lateral ends
			{
				if ((my.x > -12064) && (player.y > -28752) && (player.x < -12000) && (my.x > -12176))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y > -28752)	&& (player.x < -12006)) //&& (my.x == -12064))
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
				//if((my.y > -23160) && (my.x < -12000))
					//{
					//c_move (me,vector(0,-6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					//}	
					//break;
		 		wait(1);  
	 		}  
	 		
		ent_remove(me);
	}	
action bluVanBrdwySL30v2()
	{
			//wait(-15);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
			while(my.y < -8500)//move N on Broadway when lateral ends
			{
				if ((my.x > -12064) && (player.y > -28752) && (player.x < -12000) && (my.x > -12176))	//trigger move
					{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					}	
				if((player.y > -28752)	&& (player.x < -12006)) //&& (my.x == -12064))
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
				//if((my.y > -23160) && (my.x < -12000))
					//{
					//c_move (me,vector(0,-6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
					//}	
					//break;
		 		wait(1);  
	 		}  
	 		
		ent_remove(me);
	}
action bluebmwSonCenter()
	{
		//wait(-15);
		my.FAT = ON; 
		my.NARROW = ON;
		vec_set(my.min_x,vector(-15,-15,-15));
		vec_set(my.max_x,vector(15,15,15));
		
		while(my.y < -8500)//move S on Center when lateral ends
		{
			if ((player.y > -23500) && (player.x < -12006) && (my.x > -12064))	//trigger move
				{
					c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //move 
				}	
			if((player.y > -23500)	&& (player.x < -12006)) //&& (my.x == -12064))
			{
				c_move (me,vector(12*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
			}	
			if((player.y > -23500)	&& (player.x < -12006) && (my.x == -12148))
			{
				c_move (me,vector(0,6*time,0),nullvector,IGNORE_YOU|GLIDE); //
			}	
		 wait(1);  
	 	}  	
		ent_remove(me);
	}
action moveonCenternorth() //assign to white van
	{
		wait(-15);
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
		
		while(my.y > -29000) //to end to Center st 17500
			{
				if ((player.y > -28800)	&& (player.x < -12000) && (player.x > -12176))	//trigger move
				{
					c_move (me,vector(15*time,0,0),nullvector,IGNORE_YOU|GLIDE); //move sideways to road
				}

				wait(1);            
			}
			ent_remove(me);	
	}
	
 action  writeL30vars()  //assign to first ave sign
		{	//clear all variables when action loaded
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			msL30 = 1;
			rmseL30 = 1;
			stdL30a = 1;
			stdL30b = 1;
			stdL30 = 1;
			n1to14 = 1;//avoid operation with 0 
			n1 = 1; n2 =1;n3=1;n4=1;n5=1;n6=1;n7=1;n8=1;n9=1;
			latdevsq1 = 1;
			squaresL30 = 1;
			nsquaresL30 = 1;
			meanlatdev1 = 1;
			meanlatdevL30 = 1;
			sumoflatdev  = 1;
			wait(-11);
			//write vars when ESC pressed
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L30DriveTestUrbanv1");
						str_cat(dummyname_str,"L30DriveTestUrbanv1");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						
						file_str_write(filehandle,"L30DriveTestUrbanv2: ");
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						//calculate std dev using raw score method
						//n1to14 = n1 + n2 + n3 + n4 + n5;// + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//calculate sum of scores converted to feet
						//sumoflatdev = sumlatdev1/7 + sumlatdev2/7 + sumlatdev3/7 + sumlatdev4/7 + sumlatdev5/7;// + sumlatdev6/7 + sumlatdev7 + sumlatdev8/7 + sumlatdev9/7 + sumlatdev10/7 + sumlatdev11/7 + sumlatdev12/7 + sumlatdev13/7 + sumlatdev14/7;
						//sum of squared scores
						var stda = 0;
						var stdb = 0;
						var stdc = 0;
						//
						// calculate std for each segment
						//
						stda = (n1*latdevsq1)-(sumlatdev1/7 * sumlatdev1/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std1 = stdb/n1;
						}
						
						stda = (n2*latdevsq2)-(sumlatdev2/7 * sumlatdev2/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std2 = stdb/n2;
						}
						
						stda = (n3*latdevsq3)-(sumlatdev3/7 * sumlatdev3/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std3 = stdb/n3;
						}
						
						stda = (n4*latdevsq4)-(sumlatdev4/7 * sumlatdev4/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std4 = stdb/n4;
						}
						
						stda = (n5*latdevsq5)-(sumlatdev5/7 * sumlatdev5/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std5 = stdb/n5;
						}
						
						stda = (n6*latdevsq6)-(sumlatdev6/7 * sumlatdev6/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std6 = stdb/n6;
						}
						
						stda = (n7*latdevsq7)-(sumlatdev7/7 * sumlatdev7/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std7 = stdb/n7;
						}
						
						stda = (n8*latdevsq8)-(sumlatdev8/7 * sumlatdev8/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std8 = stdb/n8;
						}
						
						stda = (n9*latdevsq9)-(sumlatdev9/7 * sumlatdev9/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std9 = stdb/n9;
						}
						
						stda = (n10*latdevsq10)-(sumlatdev10/7 * sumlatdev10/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std10 = stdb/n10;
						}
						
						stda = (n11*latdevsq11)-(sumlatdev11/7 * sumlatdev11/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std11 = stdb/n11;
						}
						
						stda = (n12*latdevsq12)-(sumlatdev12/7 * sumlatdev12/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std12 = stdb/n12;
						}
						
						stda = (n13*latdevsq13)-(sumlatdev13/7 * sumlatdev13/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std13 = stdb/n13;
						}
						
						stda = (n14*latdevsq14)-(sumlatdev14/7 * sumlatdev14/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std14 = stdb/n14;
						}
						//
						//std for 14 segments
						stdL30 = (std1+std2+std3+std4+std5+std6+std7+std8+std9+std10+std11+std12+std13+std14)/14;
				
						//squaresL30 = latdevsq1 + latdevsq2 + latdevsq3 + latdevsq4 + latdevsq5;// + latdevsq6 + latdevsq7 + latdevsq8 + latdevsq9 + latdevsq10 + latdevsq11 + latdevsq12 + latdevsq13 + latdevsq14;
						//msL30 = squaresL30/(n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//average of mean latdev for all 14 segments
						meanlatdevL30  = (meanlatdev1 + meanlatdev2 + meanlatdev3 + meanlatdev4 + meanlatdev5 +meanlatdev6 + meanlatdev7 + meanlatdev8 + meanlatdev9 + meanlatdev10 + meanlatdev11 + meanlatdev12 + meanlatdev13 + meanlatdev14)/14;// 
					
						meanlatdevsumm = meanlatdevL30;//temp for summ page
						
						//rmseL30 = sqrt(msL30);
						
						file_str_write(filehandle," Collisions: ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(no.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Speed Too Slow(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedtooslow);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdevL30);
							file_str_write(filehandle,",");
						file_str_write(filehandle," STD LatDev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,stdL30);//was rmseL30
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}////////////////////////////////////////////////////////////////////
	
	action  writeL30v2vars()  //assign to first ave sign
		{	//clear all variables when action loaded
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			msL30 = 1;
			rmseL30 = 1;
			stdL30a = 1;
			stdL30b = 1;
			stdL30 = 1;
			n1to14 = 1;//avoid operation with 0 wtih early kill
			n1 = 1; n2 =1;n3=1;n4=1;n5=1;n5a=1;n6=1;n7=1;n8=1;n9=1;
			latdevsq1 = 1;
			squaresL30 = 1;
			nsquaresL30 = 1;
			meanlatdev1 = 1;
			meanlatdevL30v2 = 1;
			sumoflatdev  = 1;
			stdL30v2 = 1;
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-11);
			}
			//write vars when ESC pressed
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L28DriveTestUrbanv2");
						str_cat(dummyname_str,"L28DriveTestUrbanv2");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						
						file_str_write(filehandle,"L28DriveTestUrbanv2: ");
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						//calculate std dev using raw score method
						//n1to14 = n1 + n2 + n3 + n4 + n5;// + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//calculate sum of scores converted to feet
						//sumoflatdev = sumlatdev1/7 + sumlatdev2/7 + sumlatdev3/7 + sumlatdev4/7 + sumlatdev5/7;// + sumlatdev6/7 + sumlatdev7 + sumlatdev8/7 + sumlatdev9/7 + sumlatdev10/7 + sumlatdev11/7 + sumlatdev12/7 + sumlatdev13/7 + sumlatdev14/7;
						//sum of squared scores
						var stda = 0;
						var stdb = 0;
						var stdc = 0;
						//
						// calculate std for each segment
						//
						stda = (n1*latdevsq1)-(sumlatdev1/7 * sumlatdev1/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std1 = stdb/n1;
						}
						
						stda = (n2*latdevsq2)-(sumlatdev2/7 * sumlatdev2/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std2 = stdb/n2;
						}
						
						stda = (n3*latdevsq3)-(sumlatdev3/7 * sumlatdev3/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std3 = stdb/n3;
						}
						
						stda = (n4*latdevsq4)-(sumlatdev4/7 * sumlatdev4/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std4 = stdb/n4;
						}
						
						stda = (n5*latdevsq5)-(sumlatdev5/7 * sumlatdev5/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std5 = stdb/n5;
						}
						
						stda = (n6*latdevsq6)-(sumlatdev6/7 * sumlatdev6/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std6 = stdb/n6;
						}
						
						stda = (n7*latdevsq7)-(sumlatdev7/7 * sumlatdev7/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std7 = stdb/n7;
						}
						
						stda = (n8*latdevsq8)-(sumlatdev8/7 * sumlatdev8/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std8 = stdb/n8;
						}
						
						stda = (n9*latdevsq9)-(sumlatdev9/7 * sumlatdev9/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std9 = stdb/n9;
						}
						
						stda = (n10*latdevsq10)-(sumlatdev10/7 * sumlatdev10/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std10 = stdb/n10;
						}
						
						stda = (n11*latdevsq11)-(sumlatdev11/7 * sumlatdev11/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std11 = stdb/n11;
						}
						
						stda = (n12*latdevsq12)-(sumlatdev12/7 * sumlatdev12/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std12 = stdb/n12;
						}
						
						stda = (n13*latdevsq13)-(sumlatdev13/7 * sumlatdev13/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std13 = stdb/n13;
						}
						
						stda = (n14*latdevsq14)-(sumlatdev14/7 * sumlatdev14/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std14 = stdb/n14;
						}
						//
						//std for 14 segments
						stdL30 = (std1+std2+std3+std4+std5+std6+std7+std8+std9+std10+std11+std12+std13+std14)/14;
				
						//squaresL30 = latdevsq1 + latdevsq2 + latdevsq3 + latdevsq4 + latdevsq5;// + latdevsq6 + latdevsq7 + latdevsq8 + latdevsq9 + latdevsq10 + latdevsq11 + latdevsq12 + latdevsq13 + latdevsq14;
						//msL30 = squaresL30/(n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//average of mean latdev for all 14 segments
						meanlatdevL30  = (meanlatdev1 + meanlatdev2 + meanlatdev3 + meanlatdev4 + meanlatdev5 +meanlatdev6 + meanlatdev7 + meanlatdev8 + meanlatdev9 + meanlatdev10 + meanlatdev11 + meanlatdev12 + meanlatdev13 + meanlatdev14)/14;// 
						
						meanlatdevsumm = meanlatdevL30v2;//temp for summ page
						
						//rmseL30 = sqrt(msL30);
						
						file_str_write(filehandle," Collisions: ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(no.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Speed Too Slow(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedtooslow);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdevL30v2);
							file_str_write(filehandle,",");
						file_str_write(filehandle," STD LatDev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,stdL30v2);//was rmseL30
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}////////////////////////////////////////////////////////////////////
	action  writeL30v3vars()  //assign to first ave sign
		{	//clear all variables when action loaded
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			msL30 = 1;
			rmseL30 = 1;
			stdL30a = 1;
			stdL30b = 1;
			stdL30v3 = 1;
			n1to14 = 1;//avoid operation with 0 wtih early kill
			n1 = 1; n2 =1;n3=1;n4=1;n5=1;n6=1;n7=1;n8=1;n9=1;
			latdevsq1 = 1;
			squaresL30 = 1;
			nsquaresL30 = 1;
			meanlatdev1 = 1;
			meanlatdevL30 = 1;
			sumoflatdev  = 1;
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-11);
			}
			//write vars when ESC pressed
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L26DriveTestUrbanv3");
						str_cat(dummyname_str,"L26DriveTestUrbanv3");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						
						file_str_write(filehandle,"L26DriveTestUrbanv3: ");
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						//calculate std dev using raw score method
						//n1to14 = n1 + n2 + n3 + n4 + n5;// + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//calculate sum of scores converted to feet
						//sumoflatdev = sumlatdev1/7 + sumlatdev2/7 + sumlatdev3/7 + sumlatdev4/7 + sumlatdev5/7;// + sumlatdev6/7 + sumlatdev7 + sumlatdev8/7 + sumlatdev9/7 + sumlatdev10/7 + sumlatdev11/7 + sumlatdev12/7 + sumlatdev13/7 + sumlatdev14/7;
						//sum of squared scores
						var stda = 0;
						var stdb = 0;
						var stdc = 0;
						//
						// calculate std for each segment
						//
						stda = (n1*latdevsq1)-(sumlatdev1/7 * sumlatdev1/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std1 = stdb/n1;
						}
						
						stda = (n2*latdevsq2)-(sumlatdev2/7 * sumlatdev2/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std2 = stdb/n2;
						}
						
						stda = (n3*latdevsq3)-(sumlatdev3/7 * sumlatdev3/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std3 = stdb/n3;
						}
						
						stda = (n4*latdevsq4)-(sumlatdev4/7 * sumlatdev4/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std4 = stdb/n4;
						}
						
						stda = (n5*latdevsq5)-(sumlatdev5/7 * sumlatdev5/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std5 = stdb/n5;
						}
						
						stda = (n6*latdevsq6)-(sumlatdev6/7 * sumlatdev6/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std6 = stdb/n6;
						}
						
						stda = (n7*latdevsq7)-(sumlatdev7/7 * sumlatdev7/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std7 = stdb/n7;
						}
						
						stda = (n8*latdevsq8)-(sumlatdev8/7 * sumlatdev8/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std8 = stdb/n8;
						}
						
						stda = (n9*latdevsq9)-(sumlatdev9/7 * sumlatdev9/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std9 = stdb/n9;
						}
						
						stda = (n10*latdevsq10)-(sumlatdev10/7 * sumlatdev10/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std10 = stdb/n10;
						}
						
						stda = (n11*latdevsq11)-(sumlatdev11/7 * sumlatdev11/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std11 = stdb/n11;
						}
						
						stda = (n12*latdevsq12)-(sumlatdev12/7 * sumlatdev12/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std12 = stdb/n12;
						}
						
						stda = (n13*latdevsq13)-(sumlatdev13/7 * sumlatdev13/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std13 = stdb/n13;
						}
						
						stda = (n14*latdevsq14)-(sumlatdev14/7 * sumlatdev14/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std14 = stdb/n14;
						}
						//
						//std for 14 segments
						stdL30v3 = (std1+std2+std3+std4+std5+std6+std7+std8+std9+std10+std11+std12+std13+std14)/14;
				
						//squaresL30 = latdevsq1 + latdevsq2 + latdevsq3 + latdevsq4 + latdevsq5;// + latdevsq6 + latdevsq7 + latdevsq8 + latdevsq9 + latdevsq10 + latdevsq11 + latdevsq12 + latdevsq13 + latdevsq14;
						//msL30 = squaresL30/(n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//average of mean latdev for all 14 segments
						meanlatdevL30v3  = (meanlatdev1 + meanlatdev2 + meanlatdev3 + meanlatdev4 + meanlatdev5 +meanlatdev6 + meanlatdev7 + meanlatdev8 + meanlatdev9 + meanlatdev10 + meanlatdev11 + meanlatdev12 + meanlatdev13 + meanlatdev14)/14;// 
					
						meanlatdevsumm = meanlatdevL30v3;//temp for summ page
						
						//rmseL30 = sqrt(msL30);
						
						file_str_write(filehandle," Collisions: ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(no.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Speed Too Slow(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedtooslow);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdevL30v3);
							file_str_write(filehandle,",");
						file_str_write(filehandle," STD LatDev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,stdL30v3);//was rmseL30
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}////////////////////////////////////////////////////////////////////
		
	action scenarioL31()  //Curves and Straights NIGHT
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			highbeam = 0;//set low beams
		
			camera.fog_start = 300;//was 1500 		//
			camera.fog_end = 	1555;//was 2555		//
			//player.spotlight = ON;
			//player.lightrange = 1000;//low beam
			//var d3d_lightres = on;
			//vec_set(d3d_spotlightcone.x,vector(20,1,0));
			//vec_set(d3d_spotlightcone.y,vector(20,1,0));
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(curvesandstraightsL28_wav,100,0);
					}
			
			if(instructionsflag == 0)
				{
				lesson31_txt.visible = ON;
				wait(-20);
				lesson31_txt.visible = OFF;
				}
				
			if((performflag == 0) && (lesson31_txt.visible == OFF))
				{
				numcollisions_txt.VISIBLE = ON; // label for collisions
				numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
				speedexceed_txt.VISIBLE = ON; //label for speed exceed
				speedexceeddisp.VISIBLE = ON; //num of speedexceed
				speedslow_txt.VISIBLE = ON; //label for speed exceed
				speedslowdisp.VISIBLE = ON; //num of speedexceed
				overroadedge_txt.VISIBLE = ON;
				overroadedgedisp.VISIBLE = ON;
				overmediandisp.VISIBLE = ON;
				overmedian_txt.VISIBLE = ON;
				overmediandisp.VISIBLE = ON;
				}
				
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
				
			//
			//
		}//end action
			
	action HighLowBeamL31()//Curves and Straights NIGHT
		{
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
				if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
				
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
					camera.fog_start = 2000;//was 2000 		//
					camera.fog_end = 	4555;//was 5555		//
					//player.spotlight = ON;
					//d3d_lightres = on; 
					//player.lightrange = 2000;// was 400
					//vec_set(d3d_spotlightcone.y,vector(30,1,0));//was 60
					//vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 60
					//vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = ON;//turn instrument icon on
					} //put highbeams on 
				else
					{
					highbeam = 0;
					camera.fog_start = 300;//was 1500 		//
					camera.fog_end = 	1555;//was 2555		//
					//player.spotlight = ON; 
					//d3d_lightres = on;
					//player.lightrange = 1000;
					//vec_set(d3d_spotlightcone.y,vector(20,1,0));//was 60
					//vec_set(d3d_spotlightcone.x,vector(20,1,0));//was 60
					//vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = OFF;//turn icon off
					}//put low beams on
				}
			wait(1);
			}
			//
			//
		}//end action
		
	action  writeL31vars()  //assign to 45mph sign CURVES AND STRAIGHTS NIGHT
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			highbeams.VISIBLE = OFF;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L31NightCurves");
						str_cat(dummyname_str,"L31NightCurves");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L31NightCurves ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		
		//////
		////// LESSON 32 Parking in Traffic, PARKING URBAN NIGHT
		//////
				
	action scenarioL32()  //assigned to bwk10 L32NightUrbanParking
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			highbeam = 0;
		
			camera.fog_start = 1000;//was 2000 		//
			camera.fog_end = 	10555;//was 2555		//
			player.spotlight = on;
			player.lightrange = 1000;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(parallelparkurbanL9_wav,100,0);
					}
			
			if(instructionsflag == 0)
				{
				lesson32_txt.visible = ON;
				wait(-20);
				lesson32_txt.visible = OFF;
				}
				
			if((performflag == 0) && (lesson32_txt.VISIBLE == OFF))
				{
				numcollisions_txt.VISIBLE = ON; // label for collisions
				numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
				speedexceed_txt.VISIBLE = ON; //label for speed exceed
				speedexceeddisp.VISIBLE = ON; //num of speedexceed
				}
				
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
				
			//
			//
		}//end action
			
	action HighLowBeamL32()//assigned to bwk1 L32NightUrbanParking
		{
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
				if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
			//	fog_color = 5;
				highbeam = 1;
				camera.fog_start = 1000;//was 2000 		//
				camera.fog_end = 	10555;//was 2555		//
				player.spotlight = on;
				player.lightrange = 2000;
				highbeams.VISIBLE = ON;//turn instrument icon on
					} //put highbeams on 
				else
					{
					highbeam = 0;
					player.spotlight = ON; 
					//d3d_lightres = on;
					player.lightrange = 1000;
					//vec_set(d3d_spotlightcone.y,vector(30,1,0));//was 60
					//vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 60
					//vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = OFF;//turn instrument icon off
					}//put low beams on
				}
			wait(1);
			}
			//
			//
		}//end action
		
	action  writeL32vars()  //assign to bwk8 L32NightUrbanParking
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			highbeams.VISIBLE = OFF;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L32NightUrbanParking");
						str_cat(dummyname_str,"L32NightUrbanParking");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L32NightUrbanParking ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
	
		action moveAppCarsL32() //assign to all opposing traffic
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			//
			//c_setminmax(my);
			//my.spotlight = ON;
			//my.lightrange = 1000;
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my.y < -11000)
			{
				if (player.y < -16000)//start move
				{
					c_move(my,vector(8*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1); 	
			}
			ent_remove(me);
			
		}
		action moveWithDriverL32() //assign to all traffic flowing With Driver in passing lane
		{
		//	fog_color = 5;
		//	clearInstructText();
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			my.spotlight = ON;
			my.lightrange = 1000;
			
			disable_z_glide = 1;
			//c_setminmax(my);
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//	
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			while(my.y > -30000) //while position is greater than -16800, continue moving
			{
				if (player.y < -16000)//start move
				{
					c_move(my,vector(9*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			ent_remove(me);
		}

		action moveWDrivL32End() //assign to all traffic flowing With Driver in passing lane
		{
			//fog_color = 0;
			//clearInstructText();
			disable_z_glide = 1;
			wait(1);	// wait 1 frame after creation
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			//my.spotlight = ON;
		//	my.lightrange = 1000;
			
			while(my.y < -13000) //while position is greater than -16800, continue moving
			{
				if (player.y < -16000)//start move
				{
					c_move(my,vector(7*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				}
				wait(1);
			}
			
			ent_remove(me);
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			
		}
		action endplayermoveL32()  //place in bwk1
		{
			while(1)
			{
				if (player.y < -22000)
				{
					if(verbalflag == 0)
						{
						snd_stop = navigation_handle;
						navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
						}
					endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
					collision_txt.VISIBLE = OFF;
					
					break; 
				}
				wait(1);
			}
		}
		
		////////
		////////Lesson 33 Left Turn NIGHT Heavy Traffic RURAL
		////////
		
		action scenarioL33()  //assigned to 45 mph sign //ranchhouseroadsig
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			highbeam = 0;
		//	player.spotlight = on;
		//	player.lightrange = 1000;
			camera.fog_start = 300;//was 2000 		//
			camera.fog_end = 	1555;//was 12555		//
 
	
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(leftturnnightL33_wav,100,0);
					}
			
			if(instructionsflag == 0)
				{
				lesson33_txt.visible = ON;
				wait(-20);
				lesson33_txt.visible = OFF;
				}
				
			if((performflag == 0) && (lesson33_txt.visible == OFF))
				{
				numcollisions_txt.VISIBLE = ON; // label for collisions
				numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
				speedexceed_txt.VISIBLE = ON; //label for speed exceed
				speedexceeddisp.VISIBLE = ON; //num of speedexceed
				noturnsignalcount_txt.VISIBLE = ON;
				noturnsignalcountdisp.VISIBLE = ON;
				}
				
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
				
			//
			//
		}//end action
		
		
		
		action moveBMWwDRL33()//assigned to BMW static at intersection
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
		}
		
		action moveMotorcycleL33()//out
		{
			fog_color = 5;
			
		
			while(my.x < 23000) //was my.x
			{
				if(player.x < 1400)
				{
					c_move(my,vector(30*time_step,0,0),nullvector,GLIDE + USE_AABB); // was 25 move ahead until end
				}
				wait(1);
				
			}
			ent_remove(me);
			collision_txt.VISIBLE = OFF;
		}
		
		action moveOncomingL33()//assign to oncoming traffic
		{
			fog_color = 5;
			player.spotlight = on;
			player.lightrange = 1000;
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			my.spotlight = ON;
			my.lightrange = 2000;
	
			
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
				if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(turnleftL7_wav,100,0);
					}
			
			if(instructionsflag == 0)
			{
			lesson33_txt.visible = ON;  //display instructions for lesson 33
			wait(-20);
			lesson33_txt.visible = OFF;
			}
			
			if(performflag == 0)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			noturnsignalcount_txt.VISIBLE = ON; //label for count
			noturnsignalcountdisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
			//
			//displaydistractmsg();
			//
			while(my.x < 23000) //was 6500
			{
				if(player.x < 1400)
				{
					c_move(my,vector(45*time_step,0,0),nullvector,GLIDE + USE_AABB); // was 37 move ahead until end
				}
				wait(1);
				
			}
			ent_remove(me);
			noturnsignal_txt.VISIBLE=OFF;	
			if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
		
			collision_txt.VISIBLE = OFF;
			
		}//end action oncomingL33
		
	action HighLowBeamL33()//assigned to general store
		{
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
				if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
					camera.fog_start = 1000;//was 2000 		//
					camera.fog_end = 	4555;//was 5555		//
					player.spotlight = ON;
					player.lightrange = 2000;// was 400
					vec_set(d3d_spotlightcone.y,vector(40,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(40,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = ON;//turn instrument icon on
					} //put highbeams on 
				else
					{
					highbeam = 0;
					camera.fog_start = 500;//was 300 		//
					camera.fog_end = 	2555;//was 2555		//
					player.spotlight = ON; 
					player.lightrange = 1000;
					vec_set(d3d_spotlightcone.y,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = OFF;//turn instrument icon off
					}//put low beams on
				}
			wait(1);
			}
			//
			//
		}//end action	
		
	action endscenarioL33 //in stop sign
	{
		
		wait(-6);
		
		while(1)
		{	
			if(player.y < 100)//player pos triggers endscenario on Pine Tree was -900
			{
				if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			wait(-4);
			endscenariopressESC_txt.VISIBLE = OFF;
			collision_txt.VISIBLE = OFF;
			break;
			}
		wait(1);
		}
	}
action progressinstructL33() //check for left turn assign to pine tree sign
		{
			
			//if((verbalflag == 0) || (instructionsflag == 0))
			//{
			wait(-6);
			//}
			
			while(1)
			{
				if((player.x > 2000) && (player.x < 2400))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
					turnleftPineTree_txt.VISIBLE=ON;
					wait(-4);
					turnleftPineTree_txt.VISIBLE=OFF;
				}
				
				wait(-1);
			}
		}	
	action turnsignalcheckL33() //check for left turn asign to village rd sign
		{
			///if((verbalflag == 0) || (instructionsflag == 0))
			//{
			wait(-6);
			//}
			
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
				}
				if((alertsflag == 0) && (player.x < 500) && (player.x > -228) && (joy_6 == 0) && (snd_playing(signal_handle) ==0) && (leftturnsignal == 0))	
				{
				noturnsignalcount += 1;	
				}
				wait(-1);
			}
		}

	action writeL33vars()  //assign to stop sign
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			highbeams.VISIBLE = OFF;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L33LftTrnNight");
						str_cat(dummyname_str,"L33LftTrnNight");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L33LftTrnNight ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						}
				if(endscenario_txt.VISIBLE == ON)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L33LftTrnNight");
						str_cat(dummyname_str,"L33LftTrnNight");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,"L33LftTrnNight ");
						file_str_write(filehandle," Collisions:");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle," Brake RT(sec.):");
						file_var_write(filehandle,brakeRT);
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
	
		///////////
		////////Lesson 34 NIGHT URBAN HAZARDS
		////////
		
		action scenarioL34()  //assigned to second bwk3 5246//
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			highbeam = 0;//set low beams
			//
			//light setting constant does not change with beam setting
			//
			camera.fog_start = 1000;//was 2000 		//
			camera.fog_end = 	10555;//was 12555		//
			
			player.spotlight = on;
			player.lightrange = 1000;
		//	var d3d_lightres = on;
			vec_set(d3d_spotlightcone.x,vector(15,1,0));//was 30,1,0
			vec_set(d3d_spotlightcone.y,vector(20,1,0));
			vec_set(d3d_pointlightfalloff,vector(5,1,0)); 
	
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
					{
					snd_stop(instruction_handle);
					instruction_handle = snd_play(nighturbanhazardsL34_wav,100,0);
					}
			
			if(instructionsflag == 0)
				{
				lesson34_txt.visible = ON;
				wait(-18);
				lesson34_txt.visible = OFF;
				}
				
			if((performflag == 0) && (lesson34_txt.visible == OFF))
				{
				numcollisions_txt.VISIBLE = ON; // label for collisions
				numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
				speedexceed_txt.VISIBLE = ON; //label for speed exceed
				speedexceeddisp.VISIBLE = ON; //num of speedexceed
				noturnsignalcount_txt.VISIBLE = ON;
				noturnsignalcountdisp.VISIBLE = ON;
				}
				
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
				}
				
			//
			//
		}//end action
		
	action proginstL34() // bwk5_mdl 5287 on brdwy
		{	
			wait(-3);
			endonceL34 = 0;
			while(1)
			{	
				//LEFT turn on BROADWAY from start PARKING LOT
				if((startonce == 0) && (player.x < 864) && (player.x > 224) && (player.y < -17100) && (player.y > -17344))		
				{
					if(verbalflag == 0)
					{
						snd_stop(navigation_handle);
						navigation_handle = snd_play(turnleftonstreetahead_wav,100,0);
					}
				
					turnleftprkingtobrdwy_txt.VISIBLE=ON;//turn left on to Broadway
					wait(-4);
					turnleftprkingtobrdwy_txt.VISIBLE=OFF;
					startonce = 1;//prevents repeat at end of scenario
				}
			
				//PROCEED thru First on BROADWAY
				if((player.x > -192) && (player.x < -16) && (player.y < -19100) && (player.y > -20000))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstbrdwy_txt.VISIBLE=ON;
					wait(-4);
					proceedthrufirstbrdwy_txt.VISIBLE=OFF;
				}
		
				//RIGHT turn on MARKET from BRDWY
				if((player.x > -176) && (player.x < 10) && (player.y > -28800) && (player.y < -28480))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmaintomrkt_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintomrkt_txt.VISIBLE=OFF;
				}
				
				//PROCEED East thru Intersection of MARKET and FIRST was -11800
				if((player.x < -6600) && (player.x > -7312) && (player.y < -30064) && (player.y > -30240))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				//RIGHT Turn Right (South) on to CENTER from MARKET was -11800
				if((player.x > -10800) && (player.x < -10300) && (player.y < -30064) && (player.y > -30240))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmrkttocenter_txt.VISIBLE = ON;
					wait(-4);
					turnrightmrkttocenter_txt.VISIBLE = OFF;
				}
				
				//PROCEED thru FIRST on CENTER
				if((player.x < -11984) && (player.x > -12192) && (player.y > -23400) && (player.y < -22700))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(proceedthruintersectahead_wav,100,0);
					}
					proceedthrufirstave_txt.VISIBLE = ON;
					wait(-4);
					proceedthrufirstave_txt.VISIBLE = OFF;
				}
				
				//RIGHT turn onto 3rd from CENTER
				
				if((player.x > -12176) && (player.x < -12000) && (player.y > -11000) && (player.y < -10400))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightctrto3rd_txt.VISIBLE = ON;
					wait(-4);
					turnrightctrto3rd_txt.VISIBLE = OFF;
				}
				
				//RIGHT turn onto MAIN from THIRD going N
				
				if((player.x > -9680) && (player.x < -9264) && (player.y > -8448) && (player.y < -8272))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightattrafficltahead_wav,100,0);
					}
					
					turnright3rdtoMain_txt.VISIBLE=ON;
					wait(-4);
					turnright3rdtoMain_txt.VISIBLE=OFF;
				}
				
				//LEFT turn onto SECOND from MAIN going W
				if((player.x > -7856) && (player.x < -7760) && (player.y > -13000) && (player.y < -12600))		
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftattrafficltahead_wav,100,0);
					}
					
					turnleftMainto2nd_txt.VISIBLE=ON;
					wait(-4);
					turnleftMainto2nd_txt.VISIBLE=OFF;
				}
				
	
				//RIGHT turn onto BRDWY from SECOND	
				if((player.x < -1000) && (player.x > -1600) && (player.y > -14416) && (player.y < -14176))	
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnrightatstopsignahead_wav,100,0);
					}
					turnrightmaintobrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnrightmaintobrdwy_txt.VISIBLE=OFF;
				}
				
			
				//N BOUND BROADWAY TURN LEFT into PARKING END SCENARIO 
				
				if((player.x < -16) && (player.x > -160) && (player.y < -15400) && (player.y > -16100))
				{
					if(verbalflag == 0)
					{
					snd_stop(navigation_handle);
					navigation_handle = snd_play(turnleftintoparklotahead_wav,100,0);
					}
					
					endonceL34 = 1;//flag set to allow end scenario instruction
					turnleftprkingbrdwy_txt.VISIBLE=ON;
					wait(-4);
					turnleftprkingbrdwy_txt.VISIBLE=OFF;
				}
					//END SCENARIO 
				
				if((endonceL34 == 1) && (player.x < 272) && (player.x > 224) && (player.y > -17504) && (player.y < -16944))	
				{
					if(verbalflag == 0)
					{
					snd_stop = navigation_handle;
					navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
					}
					endscenariopressESC_txt.VISIBLE=ON;
					wait(-4);
					endscenariopressESC_txt.VISIBLE=OFF;
					//break;
				}
			wait(-.1);
			}
		}//end action			
		
		
		action moveBMWwDRL34()//assigned to BMW near intersection
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 5;
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			//c_setminmax(my);
		
			while(player.y > 2770)
			{
				my.x = (player.x + 1000);
				wait(1);
			}
			ent_remove(me);
		}
	
		
	action moveWonMarktL34()
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
		//	my.FAT = ON; 
		//	my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
		
			while(my.x > 4000) //was 25500	
			{
				if((player.y < -27400) && (player.x < -7700) && (player.x > -10000))
				{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			ent_remove(me);
		}
		
	action moveEMrktEBrdwyL34()//Move trfc E of BRDWY E but W of Main
		{
			wait(-5);
		//	my.FAT = ON; 
		//	my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		
			while(my.x > -7450)
			{
			if((player.y < -29800) && (player.x < -64))
				{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			wait(-4);
			ent_remove(me);
		}
	action moveEMrktWBrdwyL34()//move trfc W of BRDWY E to stop sign assigned blu audi
		{
			wait(-5);
		//	my.FAT = ON; 
		//	my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
	
			while(my.x > 288)
			{
			if((player.y < -27000) && (player.x > -160) && (player.x < -16))//&& (player.y > -29920)
				{
				c_move(my,vector(10*time_step,0,0),nullvector,GLIDE);	
				}
				wait(1);
			}
			//wait(-4);
			//ent_remove(me);
		}
	action MoveTrfcSCenterL34 //assigned to wht van,  grn bmw
	{
	//	my.FAT = ON; 
	//	my.NARROW = ON;
		vec_set(my.min_x,vector(-20,-20,-20));
		vec_set(my.max_x,vector(20,20,20));
		my.ENABLE_SCAN = ON; 
		my.ENABLE_DETECT = ON; 
	//	my.event = scan_event;
		while(my.y < -22000)
		{
		if((player.y < -22000)	&& (player.y > -30208) && (player.x < -9300)) //trigger trfc
					{
					c_move (me,vector(10*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
					}	
		 wait(1);
		}
		wait(-5);//wait 5 sec
		ent_remove(me);	
	}
action MoveTrfcW2ndL34 //assigned to wht van, blu audi
	{
		//my.FAT = ON; 
		//my.NARROW = ON;
		vec_set(my.min_x,vector(-20,-20,-20));
		vec_set(my.max_x,vector(20,20,20));
	//	my.ENABLE_SCAN = ON; 
	//	my.ENABLE_DETECT = ON; 
	//	my.event = scan_event;
		while(my.x < -320)
		{
		if ((player.x > -7968) && (player.y < -13840) && (player.y > -14688))////trigger trfc
				{
				c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //
				}	
		 wait(1);
		}
		wait(-5);
		ent_remove(me);	
	}
action moveonCenterNL34() //assign to white van
	{
		wait(-15);
			//my.FAT = ON; 
			//my.NARROW = ON;
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
		
		while(my.y > -29000) //to end to Center st 17500
			{
				if ((player.y > -28800)	&& (player.x < -12000) && (player.x > -12176))	//trigger move
					{
					c_move (me,vector(15*time,0,0),nullvector,IGNORE_YOU|GLIDE); //move sideways to road
					}

				wait(1);            
			}
			ent_remove(me);	
	}
				
action HighLowBeamL34()//assigned to bwk4 5299
		{
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
				if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
					//camera.fog_start = 1000;//was 2000 		//
					//camera.fog_end = 	12555;//was 5555		//
					player.spotlight = ON;
					//d3d_lightres = on; 
					player.lightrange = 2000;// was 400
					vec_set(d3d_spotlightcone.y,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = ON;//turn instrument icon on
					} //put highbeams on 
				else
					{
					highbeam = 0;
				//	camera.fog_start = 1000;//was 1500 		//
				//	camera.fog_end = 	12555;//was 2555		//
					player.spotlight = ON; 
					//d3d_lightres = on;
					player.lightrange = 1000;
					vec_set(d3d_spotlightcone.y,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = OFF;//turn instrument icon off
					}//put low beams on
				}
			wait(1);
			}
			//
			//
		}//end action	
		
	action MoveTrfcNonBrdwyL34 //assigned to stalled white van
	{
		
	//	my.FAT = ON; 
	//	my.NARROW = ON;
		my.ENABLE_SCAN = ON; 
		my.ENABLE_DETECT = ON; 
		
		vec_set(my.min_x,vector(-20,-20,-20));
		vec_set(my.max_x,vector(20,20,20));
	
		while(my.y > -27952)//stop when short of Market
		{
			if(player.y < -20784)//execute loop when Player is short of First-BRDWY intersection
			{
			c_move(my,vector(6*time_step,0,0),nullvector,GLIDE|USE_AABB);
			}
			if((my.y < -27902) && (my.x > -185))
			{
			c_move(my,vector(0,-6*time_step,0),nullvector,GLIDE|USE_AABB);
			}
			wait(1);	
		}
		//ent_remove(me);
	}
action fem5walkmainL34()  //red female on MAIN/SECOND intersection jaywalk against light
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			hasbraked2 = 0;
			brakeRT2 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -8240) //move fem until past road
			{
				if ((player.x > -7888) && (player.x < -7728) && (player.y < -13456))//trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 20 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
			
				wait(-.1);
			}
			ent_remove(me);
			
		}
	action moveTrfcSbrdwyL34()// move blu audi etc S on brdwy
		 {
		 	wait(-5);
		 	//my.FAT = ON; 
			//my.NARROW = ON;
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			vec_set(my.min_x,vector(-20,-20,-20));
			vec_set(my.max_x,vector(20,20,20));
		 	while(my.y < -21792)
			{
				if((player.x < -16) && (player.x > -176) && (player.y < -21616) || (player.y > -16720))
				{
				c_move(my,vector(7*time_step,0,0),nullvector,GLIDE|USE_AABB); // was AABB move ahead until en		
				}
				wait(1);
			}
			//move again later
			while(my.y < -14154)
			{
				if((player.x < -16) && (player.x > -176) && (player.y < -14700) && (player.y > -16864))// at 2nd and Brdwy intersection
				{
				c_move(my,vector(30*time_step,0,0),nullvector,GLIDE|USE_AABB); // was AABB move ahead until en		
				}
				wait(1);
			}
			wait(-5);		
			ent_remove(me);
		}
action frau1marketL34()  //move across market east of Main
		
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.y > -30400) //move until past road
			{
				if ((player.y > -30240) && (player.y < -30096) &&  (player.x < -8900)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 22 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(6 *time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
				
				wait(-.1);
			}
			ent_remove(me);
	}
	action	bluefemwalkL34() //on center st
	
	{		
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			hasbraked5 = 0;
			brakeRT5 = 0;
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x > -12384) //move until past road
			{
				if ((player.y > -11000) && (player.x < -12000) && (player.x > -12176)) //trigger fem from roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 20 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(5*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
		
				wait(-.1);
			}
			ent_remove(me);
		}
		action moveBluFem3rdL34() //
	{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			var anim_speed = 0;
			my.frame = 1;
			
			while(my.x < -10500) //move fem 
			{
				if ((player.x > -11760) && (player.y > -8464) && (player.y < -8272))//trigger walk woman roadside
					{
					my.frame = 0;
					my.frame += time_step / 16;
					anim_speed += 20 * time_step; // 2 = walk animation speed x 10
					ent_animate(my, "walk", anim_speed, ANM_CYCLE);
					c_move (me,vector(7*time,0,0),nullvector,IGNORE_YOU|GLIDE); //x 10
					}
					
				wait(-.1);
			}
			//ent_remove(me);
		}
	action movetrfcNMainL34//move all trfc N on Main thru Second ave intersect
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);
			}
			
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			while(my > -17000)
			{
				if((player.x > -8200) && (player.y < -8256) && (player.y > -14384))//cont move until past 2nd ave
				{
					c_move (me,vector(11*time,0,0),nullvector,IGNORE_YOU|GLIDE); //move sideways to road
				}
				wait(1);
			}
			ent_remove(me);
		}	
	action endscenarioL34 //bwk3
	{
		//if((verbalflag == 0) || (instructionsflag == 0))
		 //{
		wait(-6);
		//}
		
		while(1)
		{	
			if(player.y < -900)
			{
				if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
			endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			wait(-4);
			endscenariopressESC_txt.VISIBLE = OFF;
			collision_txt.VISIBLE = OFF;
			break;
			}
		wait(1);
		}
	}
	
	action turnsignalcheckL34() //bwk5 5258
		{
			wait(-5);
			
			while(1)
			{	
				if(fullscreen == 1)//FULL SCREEN
				{
				noturnsignalcount_txt.pos_x = 650;
				noturnsignalcount_txt.pos_y = 570;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 570;
				}
				if(fullscreen == 0)//Windowed
				{
				noturnsignalcount_txt.pos_x = 630;
				noturnsignalcount_txt.pos_y = 610;
				noturnsignalcountdisp.pos_x = 806;
				noturnsignalcountdisp.pos_y = 610;
				}
				
				//check RIGHT turn on MRKT from BRDWY going E
				if((player.x < -16) && (player.x > -228) && (player.y > -30000) && (player.y < -29300) && (joy_5 == 0) && (snd_playing(signal_handle) == 0))	
				{
				noturnsignalcount += 1;	
				}
				
				//check RIGHT turn on to Center from MARKET
				if((player.y < -30064) && (player.y > -30224) && (player.x > -11888) && (player.x < -11188)  && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
				//check RIGHT turn on THIRD from CENTER 
				
				if((player.x < -11968) && (player.x > -12176 ) && (player.y > -9200) && (player.y < -8600) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
				//check RIGHT turn on MAIN from THIRD 
				
				if((player.x > -8400 ) && (player.y < -8256) && (player.y > -8448) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))		
				{
					noturnsignalcount +=1;
				}
				
				//check LEFT turn on SECOND from MAIN 
				if((player.x < -7760 ) && (player.x > -7920 ) && (player.y < -13588) && (player.y > -14000) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))
				{
					noturnsignalcount +=1;
				}
				
				//check LEFT turn signal intersection flash Yellow	into parking lot
				//if((player.x < -7552 && player.x > -7728) && (player.y > -12692 && player.y < -12420) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))	
				//{
				//noturnsignalcount +=1;
				//}
				
				//check RIGHT turn signal intersection SECOND and BRDWY	
				if((player.x < -240) && (player.x > -590) && (player.y < -14192) && (player.y > -14384) && (joy_5 == 0) && (snd_playing(signal_handle) ==0))	
				{
				noturnsignalcount +=1;
				}
				
				//check LEFT turn from BRDWY into parking lot
		
				if((player.x < -16) && (player.x > -160) && (player.y < -16100) && (player.y > -16800) && (joy_6 == 0) && (snd_playing(signal_handle) ==0))
				{
					noturnsignalcount +=1;
				}
			wait(-1);
			}//end loop
			
		}//end action	
			
	action writeL34vars()  //bhouse10nmdl5350
				//clear all variables when action loaded
		{
			numcollisions = 0;
			speedexceed = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			msL30 = 1;
			rmseL30 = 1;
			stdL30a = 1;
			stdL30b = 1;
			stdL30 = 1;
			n1to14 = 1;//avoid operation with 0 wtih early kill
			n1 = 1; n2 =1;n3=1;n4=1;n5=1;n5a=1;n6=1;n7=1;n8=1;n9=1;
			latdevsq1 = 1;
			squaresL34 = 1;
			nsquaresL34 = 1;
			meanlatdev1 = 1;
			meanlatdevL34 = 1;
			sumoflatdev  = 1;
			stdL34 = 1;
			highbeams.VISIBLE = OFF;
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-11);
			}
			//write vars when ESC pressed
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L34NightUrbanHazards");
						str_cat(dummyname_str,"L34NightUrbanHazardsL34");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						
						file_str_write(filehandle,"L34NightUrbanHazards: ");
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						//calculate std dev using raw score method
						//n1to14 = n1 + n2 + n3 + n4 + n5;// + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//calculate sum of scores converted to feet
						//sumoflatdev = sumlatdev1/7 + sumlatdev2/7 + sumlatdev3/7 + sumlatdev4/7 + sumlatdev5/7;// + sumlatdev6/7 + sumlatdev7 + sumlatdev8/7 + sumlatdev9/7 + sumlatdev10/7 + sumlatdev11/7 + sumlatdev12/7 + sumlatdev13/7 + sumlatdev14/7;
						//sum of squared scores
						var stda = 0;
						var stdb = 0;
						var stdc = 0;
						//
						// calculate std for each segment
						//
						stda = (n1*latdevsq1)-(sumlatdev1/7 * sumlatdev1/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std1 = stdb/n1;
						}
						
						stda = (n2*latdevsq2)-(sumlatdev2/7 * sumlatdev2/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std2 = stdb/n2;
						}
						
						stda = (n3*latdevsq3)-(sumlatdev3/7 * sumlatdev3/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std3 = stdb/n3;
						}
						
						stda = (n4*latdevsq4)-(sumlatdev4/7 * sumlatdev4/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std4 = stdb/n4;
						}
						
						stda = (n5*latdevsq5)-(sumlatdev5/7 * sumlatdev5/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std5 = stdb/n5;
						}
						
						stda = (n6*latdevsq6)-(sumlatdev6/7 * sumlatdev6/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std6 = stdb/n6;
						}
						
						stda = (n7*latdevsq7)-(sumlatdev7/7 * sumlatdev7/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std7 = stdb/n7;
						}
						
						stda = (n8*latdevsq8)-(sumlatdev8/7 * sumlatdev8/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std8 = stdb/n8;
						}
						
						stda = (n9*latdevsq9)-(sumlatdev9/7 * sumlatdev9/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std9 = stdb/n9;
						}
						
						stda = (n10*latdevsq10)-(sumlatdev10/7 * sumlatdev10/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std10 = stdb/n10;
						}
						
						stda = (n11*latdevsq11)-(sumlatdev11/7 * sumlatdev11/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std11 = stdb/n11;
						}
						
						stda = (n12*latdevsq12)-(sumlatdev12/7 * sumlatdev12/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std12 = stdb/n12;
						}
						
						stda = (n13*latdevsq13)-(sumlatdev13/7 * sumlatdev13/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std13 = stdb/n13;
						}
						
						stda = (n14*latdevsq14)-(sumlatdev14/7 * sumlatdev14/7);
						if(stda >= 1)
						{
						stdb = sqrt(stda);
						std14 = stdb/n14;
						}
						//
						//std for 14 segments
						stdL30 = (std1+std2+std3+std4+std5+std6+std7+std8+std9+std10+std11+std12+std13+std14)/14;
				
						//squaresL30 = latdevsq1 + latdevsq2 + latdevsq3 + latdevsq4 + latdevsq5;// + latdevsq6 + latdevsq7 + latdevsq8 + latdevsq9 + latdevsq10 + latdevsq11 + latdevsq12 + latdevsq13 + latdevsq14;
						//msL30 = squaresL30/(n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12 + n13 + n14);
						//average of mean latdev for all 14 segments
						meanlatdevL34  = (meanlatdev1 + meanlatdev2 + meanlatdev3 + meanlatdev4 + meanlatdev5 +meanlatdev6 + meanlatdev7 + meanlatdev8 + meanlatdev9 + meanlatdev10 + meanlatdev11 + meanlatdev12 + meanlatdev13 + meanlatdev14)/14;// 
						
						meanlatdevsumm = meanlatdevL34;//temp for summ page
						
						//rmseL30 = sqrt(msL30);
						
						file_str_write(filehandle," Collisions: ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(no.): ");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Speed Too Slow(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,speedtooslow);
							file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
							file_str_write(filehandle,",");
						file_str_write(filehandle," Mean Lat Dev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,meanlatdevL34);
							file_str_write(filehandle,",");
						file_str_write(filehandle," STD LatDev(ft.): ");
							file_str_write(filehandle,",");
						file_var_write(filehandle,stdL34);//was rmseL30
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						
						break;
						}
				wait(-.1);
				}
		}
		////////////////////////////////////////////////////////////////////
		action moveBluBMWCommL34()    //move Blue Car to across Commerce intersection from First
		{
			if((verbalflag == 0) || (instructionsflag == 0))
			{
			wait(-15);//wait 
			}
			
			while(my.x < 8000) //
				{
				if((player.y < -21072) && (player.x > 7936) && (player.x < 8064))
					{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move ahead until
					}
				wait(1);	
				}
				
			wait(-3);
			
			while(my.x > 7856)
				{
				c_move(my,vector(12*time_step,0,0),nullvector,GLIDE); // move backward until
				}	
				wait(1);
		//	ent_remove(me);
		}
		
		/////////////////////
		//////////Scenario L35 Passing Opposing Night 40 mph
		////////////////////
			
action  scenarioL35() //NOT ASSIGNED pinetree road sign
		{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
			

			
		//	my.FAT = ON; 
		//	my.NARROW = ON;
		//	vec_set(my.min_x,vector(-15,-15,-15));
		//	vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingoncomL4_wav,100,0);
			} 
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson35_txt.VISIBLE = ON;
			wait(-23);
			lesson35_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0) && (lesson35_txt.VISIBLE == OFF)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
		
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		//	my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
		
			followtooclose_txt.pos_x = 650; //was 570
			followtooclose_txt.pos_y = 550;//was 550
			followtooclosedisp.pos_x = 806;     // Position the  display was 165
			followtooclosedisp.pos_y = 550;   // Use 4 and 600 for 1024
			
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			//
			//
			while(my.x < -5320)
			{
				if(player.x > -11360)
				{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 138000)
			{
				c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			ent_remove(me);
			//endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		}
	
	action moveOncomingL35()  //move oncoming cars along RanchHouse Rd.
		{
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
		//	my.spotlight = on;
		//	my.lightrange = 1000;
		//	var d3d_lightres = on;
			vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 30,1,0
			vec_set(d3d_spotlightcone.y,vector(30,1,0));
			vec_set(d3d_pointlightfalloff,vector(5,1,0));
			
			disable_z_glide = 1;
			while(my.x > -8000)//was -10400
			{
				if(player.x > -9000)//was -11360
				{
					c_move(my,vector(35*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			ent_remove(me);
		}
	
	action   moveWithDriverL35() //move cars in Driver lane along RanchHouse Rd.
		{	
			my.FAT = ON; 
			my.NARROW = ON;
			vec_set(my.min_x,vector(-15,-15,-15));
			vec_set(my.max_x,vector(15,15,15));
			
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
		
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		//	my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
		//	my.spotlight = on;
		//	my.lightrange = 1000;
		//	var d3d_lightres = on;
			vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 30,1,0
			vec_set(d3d_spotlightcone.y,vector(30,1,0));
			vec_set(d3d_pointlightfalloff,vector(5,1,0));
			//
			while(my.x < -5320)
			{
				if(player.x > -11000)//was -11360
				{
					c_move(my,vector(12*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end	
				}
				wait(1);
			}
			while(my.x < 138000)
			{
				c_move(my,vector(17*time_step,0,0),nullvector,GLIDE + USE_AABB); // move ahead until end
				wait(1);
			}
			ent_remove(me);
			//endscenariopressESC_txt.VISIBLE = ON; //request user to press ESC key
			collision_txt.VISIBLE = OFF;
			
		}
	
action latdevL35()  //placed in ranchouserd sign
		{
	//	if((verbalflag == 0) || (instructionsflag == 0))
	//	{
		wait(-5);
	//	}
		
		n4 = 0;
		latdev = 0;
		sumlatdev = 0;
		meanlatdev = 0;
		latdevsq4 = 0;
		rmse = 0;
		
		while(1)//road edge is y 2701
			{
				if((player.y > 2672) && (player.y < 2857) && (player.x > -9183) && (player.x < 147200))
				{
				
					n4 += 1;//increment sample size
					latdev = (player.y - 28) - 2701;//correct for width of car from eyepoint
					sumlatdev += abs((player.y - 28) - 2701);
					meanlatdev = (sumlatdev/n4)/7;
					latdevsq4 += latdev4 * latdev4;
					ms  = latdevsq4/n4;
					rmse = (sqrt(ms))/7;//no negative numbers
				}	
			wait(-.1);
			}
		
}//end of action

action scenariotimeL35//placed in bhouse2
{
			{
			mouse_pointer = 0;
			mouse_mode = 0;
			numcollisions_txt.VISIBLE = OFF; // label for collisions
			numcollisionsdisp.VISIBLE = OFF; //panel contain num of collisions
			speedexceed_txt.VISIBLE = OFF; //label for speed exceed
			speedexceeddisp.VISIBLE = OFF; //num of speedexceed
			followtooclose_txt.VISIBLE = OFF;
			followtooclosedisp.VISIBLE = OFF;
			noturnsignalcount_txt.VISIBLE = OFF;
			noturnsignalcountdisp.VISIBLE = OFF;
			brakeRT_txt.VISIBLE = OFF;
			brakeRTdisp.VISIBLE = OFF;
			fog_color = 0;
		
			player.spotlight = on;
			player.lightrange = 1000;
			//	var d3d_lightres = on;
			vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 30,1,0
			vec_set(d3d_spotlightcone.y,vector(30,1,0));
			vec_set(d3d_pointlightfalloff,vector(5,1,0));
		
			fog_color = 5;
		
			camera.fog_start = 1000;//was 2000 		//
			camera.fog_end = 	8555;//was 10555	
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
			if(verbalflag == 0)
			{
			snd_stop(instruction_handle);
			instruction_handle = snd_play(passingoncomL4_wav,100,0);
			} 
			
			if(instructionsflag == 0)//show instructions if zero
			{
			lesson35_txt.VISIBLE = ON;
			wait(-23);
			lesson35_txt.VISIBLE = OFF;
			}
			
			if(performflag == 0) && (lesson35_txt.VISIBLE == OFF)
			{
			numcollisions_txt.VISIBLE = ON; // label for collisions
			numcollisionsdisp.VISIBLE = ON; //panel contain num of collisions
			speedexceed_txt.VISIBLE = ON; //label for speed exceed
			speedexceeddisp.VISIBLE = ON; //num of speedexceed
			}
		
			my.ENABLE_SCAN = ON; 
			my.ENABLE_DETECT = ON; 
			my.event = scan_event;
		//	my.ENABLE_IMPACT = ON; //detection for collision
			my.ENABLE_ENTITY = ON;
		
			followtooclose_txt.pos_x = 630; //was 570
			followtooclose_txt.pos_y = 610;//was 550
			followtooclosedisp.pos_x = 806;     // Position the  display was 165
			followtooclosedisp.pos_y = 610;   // Use 4 and 600 for 1024
		
			if(performflag == 0)
			{
			followtooclose_txt.VISIBLE = ON;
			followtooclosedisp.VISIBLE = ON;
			}
			
			if(displaydistractflag == 0)//show display distract if flag is 0
				{
					distractDisplay_ent.VISIBLE = ON;//show distractor display
					//displaydistractmsg();
				}
			//
			disable_z_glide = 1;
			//Throttle_Toggle = 0;
			pressbrake_txt.VISIBLE = OFF;
			wait(-1);
			
		
			
	/////
	/////
	scenariotime = 0;
	while(1)//4 min duration
		{
		if(scenariotime < 240)
			{
			scenariotime += 1;
			}
		wait(-1);
		else
			{break;}
		}
		if(verbalflag == 0)
				{
				snd_stop = navigation_handle;
				navigation_handle = snd_play(EndofscenariopressESCkey_wav,100,0);
				}
	endscenariopressESC_txt.VISIBLE = ON;
	
}
	action HighLowBeamL35()//assigned to 
		{
			while(1)
			{
				if(fullscreen == 1)//FULL SCREEN
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -38.0;	//was -38		// Position
				}
				if(fullscreen == 0)//WINDOWED
				{
					highbeams.x = 125;				//pos_x = 200; 
					highbeams.y = 50; //was 45
					highbeams.z = -30.0;			// Position
				}
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
					//camera.fog_start = 1000;//was 2000 		//
					//camera.fog_end = 	12555;//was 5555		//
					player.spotlight = ON;
					//d3d_lightres = on; 
					player.lightrange = 2000;// was 400
					vec_set(d3d_spotlightcone.y,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = ON;//turn instrument icon on
					} //put highbeams on 
				else
					{
					highbeam = 0;
				//	camera.fog_start = 1000;//was 1500 		//
				//	camera.fog_end = 	12555;//was 2555		//
					player.spotlight = ON; 
					//d3d_lightres = on;
					player.lightrange = 1000;
					vec_set(d3d_spotlightcone.y,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(20,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					highbeams.VISIBLE = OFF;//turn instrument icon off
					}//put low beams on
				}
			wait(1);
			}
			//
			//
		}//end action	
action writeL35vars()  //assigned to stopsign3_mdl_2119
		{
			numcollisions = 0;
			speedexceed = 0;
			speedtooslow = 0;
			noturnsignalcount = 0;
			followtooclose = 0;
			brakeRT = 0;
			meanlatdev = 0;
			rmse = 0;
			highbeams.VISIBLE = OFF;
			while(1)
				{
					if(key_esc)
						{
						str_cpy(dummyname_str,"               ");
						str_cpy(dummyname_str, filename_str);
						str_cpy(scenarioname_str,"L35PassOppNt");
						str_cat(dummyname_str,"L35PassOppNt");
						str_cat(dummyname_str,text_str);	
						filehandle=file_open_append(dummyname_str);
						file_var_write(filehandle,sys_month);
						file_var_write(filehandle,sys_day);
						file_var_write(filehandle,sys_year);
						file_str_write(filehandle,",");
						file_var_write(filehandle,sys_hours);
						file_var_write(filehandle,sys_minutes);
						file_str_write(filehandle,",");
						file_str_write(filehandle,"L35PassOppNt ");
						file_str_write(filehandle,",");
						file_str_write(filehandle," Collisions:");
						file_str_write(filehandle,",");
						file_var_write(filehandle,numcollisions);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Exceed Speed(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,speedexceed);
						file_str_write(filehandle,",");
						file_str_write(filehandle," No Turn Signal(sec.)");
						file_str_write(filehandle,",");
						file_var_write(filehandle,noturnsignalcount);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Follow Too Close(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,followtooclose);
						file_str_write(filehandle,",");
						file_str_write(filehandle," Brake RT(sec.):");
						file_str_write(filehandle,",");
						file_var_write(filehandle,brakeRT);
						//file_str_write(filehandle," Mean Lat Dev(ft.): ");
						//file_str_write(filehandle,",");
						//file_var_write(filehandle,meanlatdev);
						//file_str_write(filehandle,",");
						file_asc_write(filehandle, 13);
						file_asc_write(filehandle, 10);
						break;
						}
				wait(-.1);
				}
		}
			
	action highbeamon() //execute high beams on
		{
			//Logitech G27G29
			while(1)
			{
			if ((joy_7 > 0) || (key_h))
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
				//	camera.fog_start = 2000;//was 2000 		//
				//	camera.fog_end = 	5555;//was 5555		//
					player.spotlight = ON;
					d3d_lightres = on; 
					player.lightrange = 2000;// was 400
					vec_set(d3d_spotlightcone.y,vector(40,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(40,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					} //put highbeams on 
				else
					{
					highbeam = 0;
				//	camera.fog_start = 1500;//was 1500 		//
				//	camera.fog_end = 	2555;//was 2555		//
					player.spotlight = ON; 
					d3d_lightres = on;
					player.lightrange = 1500;
					vec_set(d3d_spotlightcone.y,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.x,vector(30,1,0));//was 60
					vec_set(d3d_spotlightcone.z,vector(5,1,0));
					}//put low beams on
				}
			wait(1);
			}	
		}
	
	action streetlampon //light output of streetlamp
		{
			my.lightrange = 500;
		}
	
		/////////////////////////////////////////////////////////////////////
		action cone_collision() //L1 get started set cone collision size
		{
			//c_setminmax(my);
			wait(1);	// wait 1 frame after creation
			vec_set(my.min_x,vector(5,5,5));
			vec_set(my.max_x,vector(5,5,5));
		}
		////////////////////////////////////////////////////////////////////////
		//  FUNCTION:  player_car_move()
		// Desc: Main shopping list for vehicle action
		//			   called from ACTION player_car 
		////////////////////////////////////////////////////////////////////////
		//  Expects:  initial variables to be set
		//  Provides: my_angle.pan, my_angle.roll, my.pan, my.roll, my.tilt
		//            my_angle.tilt, my.pan, my.roll, my.tilt
		//            my_floornormal, my_floornormal.x, my_floornormal.y, 
		//  Calls:    car_player_intentions(), car_scan_floor(), car_physics(), 
		//            car_steering(), car_move_gravity(), car_view()
		//             and others (see below)
		//

		// Increment driverreverse variable to reverse
		//set back to drive if more than one press on joy_3
		
		// set to drive gear = 1; // was joy_3==0 which allows reverse with button held down only 
		//if joy_3 > 0 no reverse possible

		
		function drivereverse_toggle() // Check the drivereverse input toggle
		{
			//if (joy_3 > 0)   //button 3 pressed (nonzero) while in drive
			//Logitech G27
			if ((stantrans ==0) && (key_r))   //joy_8 button 8 pressed (nonzero) while in drive
			{
				if(drivereverse == 0)	
				{drivereverse = 1; gear=0;} //put car in reverse 
				//wait(-2);
				else
				{drivereverse = 0;gear=1;}	
			}
		} 
		
		function fullscreen_toggle() // Called by the F10 key
		{
			fullscreen = 1;//FULL SCREEN
			//video_window(NULL,sys_metrics(77),1,NULL);
			video_set(1366,768,0,1);//no window full screen
			//video_switch(0,0,1);
			
				speeddial.pos_x = 404;//was 404
				speeddial.pos_y = 550;//was 550 verical
				tachdial.pos_x = 223;     // Position the tachometer, was 203
				tachdial.pos_y = 550;   // Use 4 and 600 for 1024
				
				sneedle.scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
				sneedle.scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
				sneedle.scale_z = 0.22;  // Thickness - not really used    
				tneedle.scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
				tneedle.scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
				tneedle.scale_z = 0.22;  // Thickness - not really used
				
				sneedle.x = 210; // distance ahead of the view entity
				sneedle.y = 28.3; // was 27 left-right distance, incr value to move left decr value moves to rt
				sneedle.z = -66.9; // was -51 up-down was -66.9
				tneedle.x = 210; // distance ahead of the view
				tneedle.y = 60.7;// was 57.0 left-right distance 0 = center (use 97.5 for 1024) was 52.5
				tneedle.z = -66.9; //up-down was -60
				
				turnsignalleft.scale_x = 0.13;//was .15
				turnsignalleft.scale_y = 0.14;//was .14
				turnsignalleft.scale_z = 0.21;// was .22
				
				rightturnsignal.scale_x = 0.13;
				rightturnsignal.scale_y = 0.14;
				rightturnsignal.scale_z = 0.21;
				
				turnsignalleft.x = 201;// incr to raise
				turnsignalleft.y = 49; //was 52 left-right incr to move left
				turnsignalleft.z = -41.0;// Position up down
				
				rightturnsignal.x = 201;// 
				rightturnsignal.y = 38; //was 40
				rightturnsignal.z = -41.0;//incr to raise  mor neg lowers
		
				numcollisions_txt.pos_x = 650; //was 570 collision label
				numcollisions_txt.pos_y = 550;//was 520 vertical
				numcollisionsdisp.pos_x = 806;//horizontal number
				numcollisionsdisp.pos_y = 550;//vertical
				
				speedexceed_txt.pos_x = 650;//speed exceed label horiz
				speedexceed_txt.pos_y = 560;//speed exceed label vertical
				speedexceeddisp.pos_x = 806;
				speedexceeddisp.pos_y = 560;//vertical speed exceed number
				
				followtooclose_txt.pos_x = 650;//label horiz
				followtooclose_txt.pos_y = 570;
				followtooclosedisp.pos_x = 806;//number horiz
				followtooclosedisp.pos_y = 570;
				
			//	noturnsignalcount_txt.pos_x = 650;
			//	noturnsignalcount_txt.pos_y = 580;
			//	noturnsignalcountdisp.pos_x = 806;
			//	noturnsignalcountdisp.pos_y = 580;
						
			//	collision_txt.pos_x = 500; //was 570
			//	collision_txt.pos_y = 300;//was 480
		
		}
		
		function windowed()
		{
			fullscreen = 0;//WINDOWED default at startup
		//	video_window(NULL,sys_metrics(77),16,"DrivingSimEX");//,vector(1366,768,2),1,NULL);//sys_metrics(78),sys_metrics(79)
			wait(1);
			video_set(1366,768,0,2);
			
				speeddial.pos_x = 404;//was 404
				speeddial.pos_y = 570;//was 550
				tachdial.pos_x = 223;     // Position the tachometer, was 203
				tachdial.pos_y = 570;   // Use 4 and 600 for 1024
				
				sneedle.scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
				sneedle.scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
				sneedle.scale_z = 0.22;  // Thickness - not really used    
				tneedle.scale_x = 0.15;  // Scaled width of needle - use 0.15 for 1024
				tneedle.scale_y = 0.24;  // Scaled length of needle - use 0.25 for 1024
				tneedle.scale_z = 0.22;  // Thickness - not really used
				
				sneedle.x = 201; // was 201 distance ahead of the view entity
				sneedle.y = 27.5; // was -2.0 left-right distance 0 = center (use 98.0 for 1024) was 17
				sneedle.z = -50.1; // was -51 up-down incre neg to raise
				tneedle.x = 201; // distance ahead of the view
				tneedle.y = 58.7;// was 57.5 left-right distance 0 = center
				tneedle.z = -50.1; //up-down
				
				turnsignalleft.scale_x = 0.12;//was .15
				turnsignalleft.scale_y = 0.13;//was .14
				turnsignalleft.scale_z = 0.20;//was .22
				rightturnsignal.scale_x = 0.12;//was .15
				rightturnsignal.scale_y = 0.13;//was .14
				rightturnsignal.scale_z = 0.20;//was .22
				
				turnsignalleft.x = 215;//pos_x = 200; an entity up down incr to raise
				turnsignalleft.y = 52; //was 30 left-right
				turnsignalleft.z = -38.0;// Position the turnsignalleft up down
				rightturnsignal.x = 215;//pos_x = 200 up-down 
				rightturnsignal.y = 40; //was 30 left-right
				rightturnsignal.z = -38.0;// Position the right was -38
				
				numcollisions_txt.pos_x = 630; //was 650 collision label
				numcollisions_txt.pos_y = 590;//vertical label
				numcollisionsdisp.pos_x = 806;//was 550 collision number
				numcollisionsdisp.pos_y = 590;//vertical number
				
				speedexceed_txt.pos_x = 630;//speed exceed label horiz
				speedexceed_txt.pos_y = 600;//label vertical
				speedexceeddisp.pos_x = 806;//speed numb horiz
				speedexceeddisp.pos_y = 600;//speed exceed number vertical
				
				followtooclose_txt.pos_x = 630;//label horiz
				followtooclose_txt.pos_y = 610;
				followtooclosedisp.pos_x = 806;//number horiz
				followtooclosedisp.pos_y = 610;
			
			//	collision_txt.pos_x = 500; //was 570 cllision warning
			//	collision_txt.pos_y = 300;//was 480
		}	
		
/*	function varynightlevels()
		{
			//Logitech G27/29
			while(1)
			{
			if ((joy_3 > 0) || (key_h))//was joy_7 for g27
				{
				if(highbeam == 0)	
					{
					highbeam = 1;
					camera.fog_start = 500;
					camera.fog_end =  1555; 
					player.lightrange = 400;
					} //put highbeams on 
				else
					{
					highbeam = 0;
					camera.fog_start = 1200;
					camera.fog_end = 2555;
					player.lightrange = 1000;
					}
				}
			wait(1);
			}	
		}
*/

		function player_car_move() //called by loop in Player_Car action 
		{
			if(my.client == 0) { player = me; } // created on the server?
			my_type = type_player;
			my.ENABLE_SCAN = ON;	// so that AI cars can detect me

			if((my.trigger_range == 0) && (my.ENABLE_TRIGGER ==ON)) { my.trigger_range = 32; }
			
			//key_force.y = 0; // disable strafing
			
			
			car_player_intentions();   //  Get Player Input
			car_scan_floor();   // find ground below (set tilt, roll, my_height, my_floornormal)
			car_physics();      //  Calculate car vectors, torque, acceleration, etc.	
			car_steering();     //  Calculate car steering
			car_move_gravity(); // Move the car	
			car_view();         // Update the main camera view (Car Cam)
			
			// Do some housekeeping with helper functions	    
			tune_esound();      // Set engine sound according to RPM 
			sneedle_roll();     // Sets the angle of the speedometer needle 
			tneedle_roll();     // Sets the angle of the tachometer needle
			//
			car_motion();       // Check if moving forward, braking or backing-up
			car_gear();         // Shift gears when needed, including reverse
			drivereverse_toggle();  //execute toggle state function
			//highbeamon(); //execute high beams on
			//joyhat();//operate joyhat
			//car_toggle();       // Check toggles for steering and throttle input types
			
		}
		/////////////////////////////////////////////////////////////////////////
		//  FUNCTION:  car_player_intentions() 
		//  Desc:  Gets steering and throttle input from the player
		//  Expects:  car_sstrength, car_tstrength
		//  Uses:     joy_raw.z, joy_raw.x, key_cuu, key_cud, key_cul, key_cur,
		//            mickey.x, mickey.y, Throttle_Text.string, Steering_text.string
		//  Provides: throttle, steering
		//  Calls:   nothing
		//	Called by: Carplayer_move via Player_car_move (in loop) via Player_car Action

  function car_player_intentions() //called by player_car_move loop 
		{
			
			if ((Throttle_Toggle == 2) && (drivereverse == 0))
			{
				// accelerator enabled
				gear = 1;
				//Logitech G29 
				//joy.raw.x used for steering wheel all Logitech G series
				//throttle enabled using joy_raw.z
				//Logitech G920
				///joy_raw.z for Brake
				///joy_raw.y for Throttle
				
				if(displayG27G29flag == 1)//default
				{
				throttle = int(joy_raw.z/4.2166-40);//for G29 was raw.y
				}
				//
				if(displayT150T300flag == 1)//Thrustmaster T150
				{
				throttle = int(joy_rot.x/4.2166-40);//for T150
				}
				//
				if(displayTMXTMXProflag == 1)//Thrustmaster TMX
				{
				throttle = int(joy_rot.x/4.2166-40);//for T150
				}
			
				throttle = -throttle * car_tstrength; //  "car_tstrength" is a throttle adjustment
				throttle = max(0,(min(throttle,100)));  // Limit throttle to 0 to +100
				
				//Logitech G29
				//brake pedal enabled using joy_rot.x
				if(displayG27G29flag == 1)//default
					{
				  	brakepedal= int(joy_rot.x);////for g29 was rot.z raw.z no G29 and yes G920
					}
					//
				if(displayT150T300flag == 1)
					{
					brakepedal= int(joy_raw.y);// for T150
					}
					//
				if(displayTMXTMXProflag == 1)
					{
					brakepedal= int(joy_raw.y);// for T150
					}
					//
				clutchpedal = int(joy_raw.y);//was rot.x no G29 and yes G920
			}	
			
			if ((throttle_toggle == 2) && (drivereverse == 1)) //put gear into REVERSE
			{
				gear = 0;
				
				if(displayG27G29flag == 1)//default
				{
				throttle = int(joy_raw.z/4.2166-40); //for G29 was raw.y
				}
				//
				if(displayT150T300flag == 1)
				{
				throttle = int(joy_rot.x/4.2166-40);//for T150
				}
				//
				if(displayTMXTMXProflag == 1)//Thrustmaster TMX
				{
				throttle = int(joy_rot.x/4.2166-40);//for T150
				}
			
				throttle = throttle * car_tstrength;  //subtract from throttle
				throttle = max(-20,(min(throttle,0)));//was -20, 0; limit throttle -20 to 0
			
				// BRAKE pedal enabled
				if(displayG27G29flag == 1)//default
				{
				brakepedal= int(joy_rot.x);//was rot.z raw.z no for G29 and yes G920
				}
				//
				if(displayT150T300flag == 1)
				{ 
				brakepedal= int(joy_raw.y);// for T150
				}
				//
				if(displayTMXTMXProflag == 1)
				{
				brakepedal= int(joy_raw.y);// for TMX
				}
				clutchpedal = int(joy_raw.y);//was rot.x no G29 and yes G920
			}
				
			if((Throttle_Toggle == 0) && (drivereverse == 0))// Keyboard cursors forward drive
			{
				if(key_cuu)
				{
					brakepedal = 0;
					gear = 1;
					throttle +=5;
					throttle = max(0,(min(throttle,100)));
				}
				if(key_cud)
				{
					throttle = 0;
					//throttle = max(0,(min(throttle,100)));
				}
				if(key_space)//apply full brakes
				{ 
					brakepedal = -1;
					throttle = 0; 
				}
			}
			
	
			if ((throttle_toggle == 0) && (drivereverse == 1) && (key_cuu)) //put gear into reverse
			{
				brakepedal = 0;
				throttle = -5;  //subtract from throttle
				
				if(key_space)//apply full brakes
				{ 
					brakepedal = -1;
					throttle = 0; 
				}
			}
			if((throttle_toggle == 0) && (drivereverse == 1) && (key_space))//apply full brakes
				{ 
					brakepedal = -1;
					throttle = 0; 
				}
			//
			/////////////  Now get steering forces   ////////////////////
			//
			
			if (Steering_Toggle == 0)
			{
				// Keyboard steering enabled
				steering += key_cur * 0.1 * car_sstrength; // If "Right Cursor" key pushed, steering +0.1
				steering -= key_cul * 0.1 * car_sstrength; // If "Left Cursor" key pushed, steering -0.1
				if ( (key_cur == 0) && (key_cul == 0) ) {steering = 0;}  // No key pressed - center steering
				Steering_text.string = Steer_kb;          // Display keyboard steering mode
			}
			if (Steering_Toggle == 1)
			{
				// Mouse steering enabled
				steering += mickey.x / 25;        // Mouse controls throttle
				steering *= car_sstrength;        // "car_sstrength" is a steering adjustment
				Steering_text.string = Steer_ms;  //  Display mouse steering mode
			}
			
			if (Steering_Toggle == 2)    
			{
				//  Joy stick steering enabled
				//Default car_sstrength = 3.0;
				steering = (joy_raw.x/42) * car_sstrength; //raw.x for all mods
				Steering_text.string = Steer_js;  //  Display joystick steering mode
				if(abs(steering) < 0.3) {steering=0;} // Leave a steering "dead spot" in the center   was 0.3   
			}
			if (((key_pgup) || (joy_buttons & 512)) && (car_sstrength < 6))
			{car_sstrength += 0.25;} //increase steering sensitivity
			if (((key_pgdn) || (joy_buttons & 2048)) && (car_sstrength > 1))
			{car_sstrength -= 0.25;} //decrease steering sensitivity
		//Out for G920
		
			if ((car_velocity < 10) && (Airborne == 0)) 
			{
				car_sstrength =1.4;
			}
			if ((car_velocity >= 10) && (car_velocity < 15) && (Airborne == 0))
			{
				car_sstrength = 1.4;//was 2.0
			}
			if ((car_velocity >= 15) && (car_velocity < 30) && (Airborne == 0))
			{
				car_sstrength = 1.4;//was 1.5
			}
			if ((car_velocity >= 30) && (car_velocity < 64 ) && (Airborne == 0))
			{
				car_sstrength = 1.4;// was 1.4
			}
			if ((car_velocity >= 64) && (car_velocity < 90 ) && (Airborne == 0))
			{
				car_sstrength = 1.0;// was .4
			}
			if ((car_velocity >= 90) && (Airborne == 0))
			{
				car_sstrength = .9;//over 50 mph
			}
			
			//my.pan = joy_hat;car_sstrength 
		}
		//if (airborne == 1) {steering = 0;}     // Prevent steering while in the air
		//steering = max(1,(min(steering,6)));  // Limit steering to -6 to +6

		/////////////////////////////////////////////////////////////////////////
		// FUNCTION  car_physics(); Calculates speed, vectors, acceleration, rpm, etc.
		//
		//   Engine Torque (Torq_Engine) is controlled by both the accelerator, and the rpm 
		//   of the engine. The engine torque is calculated with a torque/rpm "look-up" table, 
		//   as part of a speed/wheel/drive train feedback loop to the engine.
		//   
		//   Engine Torque goes through the drive train, (including changing gears),
		//   to provide torque to the rear wheels, and then the road.  The total amount 
		//   of road force also includes air and rolling resistance, and power losses 
		//   due to turning or climbing hills.
		//
		//   The amount of acceleration determines the "slip_ratio".
		//   Slip Ratio can be determined by calculating and comparing the angular velocity
		//   of the front and rear wheels.  However, this requires considerably more cpu 
		//   power than just testing the rate of acceleration.
		//   The variable "Slip_Ratio" is not used in the calculations.  Instead, the value
		//   in "Car_Accel" is used to trigger tire squeal, raise up or nose down, etc.  
		//   "Corner_Lean" and "Steering" are used to squeal tires in a sharp turn, and 
		//   to reduce acceleration (or speed) when the wheels are turned.
		//   
		//   Gear shifting is done by testing the engine RPM.
		//
		function car_physics()
		{
			// Calculate the torque through the drive train
			accelerator = throttle / 100;  // Convert from keyboard or joystick input
			// Vary engine torque depending on RPM   Ranges from .8 to 1.0+
			lookup_torque = 1.5 + (rpm /30000);  //was 0.8
			// Max_Torq was calculated from "Horsepower" value in "Car Specific Values" table
			// Accelerator can range from 0.0 through 1.0 
			Torq_Engine = Max_Torq * accelerator * lookup_torque; 
			
			Torq_Drive_Train = Torq_Engine * gear_ratio[Use_Gear] * differential_ratio * gear_efficiency;
			// Power change when climbing or descending 
			Torq_Drive_Train -= (my.tilt/Hill_Effect)*Max_Torq;  
			// Speed loss due to turning (Ignore when going very slowly)
			if(abs(car_velocity) > 10) {Torq_Drive_Train -= (abs(steering)/Turn_Effect)*Max_Torq;}
			
			Check_Brake();  // Check if brakes are applied
			T_wheel = Torq_Drive_Train + T_brake; // Torque to wheels - Unless braking, T_brake=0
			Drive_torq = T_wheel / wheel_radius_feet;

			// Calculate resistance factors that reduce speed
			Air_Resistance = -Drag * car_velocity * abs(car_velocity); // Works in forward or reverse
			Rolling_Resistance = -Resistance * car_velocity;           // Works in forward or reverse
			T_Eng_Resis = (-Max_Torq) * (rpm / 18000)* gear_ratio[Use_Gear]; // Engine resistance was 18000
			if (abs(car_velocity) < 5) {T_Eng_Resis = 0;} // Eliminate low speed reverse "creep"
			
			// Calculate forces acting on the car - reduce drive force by the resistance
			Road_Force =  Drive_Torq + Air_Resistance + Rolling_Resistance + T_Eng_Resis; 
			if (airborne == 1) { Road_Force = Air_Resistance;}  // No engine power
			
			// Get car acceleration   F= M*A and A = F/M   Can be a negative value
			Car_Accel = (Road_Force / Car_Weight)*time_step/Acel_Val; // Amount to accelerate
			if ( (rpm >= Max_RPM) && (car_velocity > 0) )
			{ Car_Accel = min(0,Car_Accel); } // Engine maxed out in forward, no + acceleration
			if ( (rpm >= Max_RPM) && (car_velocity < 0) )
			{ Car_Accel = max(0,Car_Accel); } // Engine maxed out in reverse, no - acceleration
			// Now calculate the velocity of the car
			Car_Velocity += Car_Accel;    //  Velocity in M.P.H. after acceleration is applied
			
			// Eliminate "creep" at very slow speeds
			if ( (abs(car_velocity) < 3) && (abs(accelerator) < .03) ) { car_velocity = 0; }   

			dist.x = car_velocity * time_step / 2;   // Distance - used for "car_move_gravity" function
			
			// For Axle_RPM, if wheel_radius is inches use 168, if radius is in feet, use 14
			Axle_RPM = ( Car_Velocity * 14 ) / Wheel_Radius_Feet;  // Car velocity in M.P.H.
			//clutch in or shifter to neutral
			if(use_gear == 7) //engine rpm slow to idle&& (calc_rpm > 600))
				{
					calc_rpm -= 20; //reduce by 100
					wait(-.1); //every .1 sec
				}
			// else Calculate engine rpm from Axle_RPM
				else
				{
				calc_rpm = abs(Axle_RPM) * gear_ratio[Use_Gear] * differential_ratio;
				}
			
			if(use_gear == 7) //gear is in neutral or clutch pedal is depressed
				{calc_rpm += throttle;} //accelerator pedal is depressed
			 
			// Displayed RPM
			rpm = max(calc_rpm, 550);   //  RPM can't go to zero - can't be less than idle (550 rpm)
			if ( (rpm > Max_RPM) || (Airborne == 1) ) {rpm = Max_RPM;}    
		}
		/////////////////////////////////////////////////////////////////////////
		//        FUNCTION car_scan_floor()
		// Desc: scan for a surface below the ME entity
		//       set my_floornormal vector to the normal of the surface
		//			 set my_height to the distance between ME.MIN_Z and the surface
		//			 set floorspeed to the X & Y speed of any platform ME is on.
		//			 set on_passable_, in_passable_, and in_solid_ to the 'offset SONAR' values.
		//
		//  Expects:  my.x
		//  Uses:     vecFrom. vecTo, normal.x, normal.y, normal.z
		//  Provides: vecTo.z, my_height, my_height_passable, on_passable, in_passable, in_solid
		//            my_floornormal.x, my_floornormal.y, my_floornormal_z, my_floorspeed.x,
		//            my_floorspeed.y 
		//  Calls:    trace
		//
		function car_scan_floor()//was ignore models
		{
			trace_mode =  ignore_passents + IGNORE_ME + scan_texture + use_box ;//+ ignore_sprites + + ignore_passents 
			vec_set(vecFrom,my.x);
			vec_set(vecTo,my.x);
			vecTo.z -= 4000;

			my_height = trace(vecFrom,vecTo);  
			//         trace sets "target" vector to position of suface encountered
			//         trace sets "normal" vector to the normal of the surface detected
			//         trace returns the distance to the hit point	(In this case - "my_height") else 0
			//         trace sets "you" pointer to the entity encountered - else "null"
			//               with scan_texture, also sets tex_name, tex_flag1...8, tex_light, tex_fog
			my_height_passable = 4;
			on_passable = on_passable;
			in_passable = in_passable;
			in_solid = in_solid;
			my_floornormal_x = normal.x; 	// set my_floornormal to the normal of the surface
			my_floornormal_y = normal.y;
			my_floornormal_z = normal.z;
			my_floorspeed_x = 0; 			// reset floorspeed to zero
			my_floorspeed_y = 0;
			
			// if he is on a slope, change his angles
			my_angle.tilt = 0;   // Adapt the player angle to the floor slope
			my_angle.roll = 0;
			
			if (my_height < 100)  // was 5
			{		
				if( (my_floornormal.x != 0) || (my_floornormal.y != 0) )
				{
					// rotate the floor normal relative to the player
					my_angle.pan = -my.pan;
					vec_rotate(my_floornormal,my_angle);
					// calculate the destination tilt and roll angles
					my_angle.tilt = -asin(my_floornormal.x);
					my_angle.roll = -asin(my_floornormal.y);
					// change the player angles towards the destination angles
					my.tilt += 0.2 * ang(my_angle.tilt-my.tilt);
					my.roll += 0.2 * ang(my_angle.roll-my.roll);
				}
				else
				{
					// If roll or tilt is not equal to zero, set them to floor normal (zero)
					if (my.roll != 0) {my.roll -= 0.2 * ang(my.roll);}
					if ( abs(my.roll) < 0.2) {my.roll = 0;}
					if (my.tilt != 0) {my.tilt -= 0.2 * ang(my.tilt);}
					if ( abs(my.tilt) < 0.2) {my.tilt = 0;}
				}
			}
			else { my.tilt += -0.5;}  // Height over 5 - airborne, starting to nose down...was -.2
			// Rock Back - Nose lift when accelerating, or "dipping" while braking
			// This effect is controlled by the value in "Rock_Back" in 
			// "Other table values you can adjust".  To disable this effect,
			//  either set "Rock_Back" to zero, or comment out the following line
			my.tilt += Rock_Back * car_accel;
		
	
			////////////////////////////////////////////////////////////////////
			// Corner Leaning - Car will "lean" when taking a corner too fast.
			//   Combines turning force and car velocity in "Internal Variables"
			//   Change the amount (or direction) with the "Corner_Lean" variable
			//     which is set in "Other table values you can adjust"
			//   Reverse the sign of "Corner_Lean" to tilt the other direction
			//   Increase "Corner_Lean" to tip the car enough to roll over (be careful out there!)
			//   (The vehicle can go past 90 degrees, but resets to upright when landing.)
			//  To disable the leaning effect, comment out the second line
			//  To disable both leaning and squealing, set Corner_Lean to zero
			Corner_Squeal = (steering/10) * (car_velocity/20) * Corner_Lean;
			//my.roll += Corner_Squeal;
			//////////////////////////////////////////////////////////////////  
			if (my_height < 500) {Airborne = 0;}  // We are on the ground..was 100
			if (my_height >=500) {Airborne = 1;}  // We are in the air..was 200
			//////////////////////

		}
		///////////////////////////////////////////////////////////////////
		//   FUNCTION  car_move_gravity()   Called from  player_car_move
		//
		//  Description: Performs the actual move of the model
		//  Expects:  Airborne, dist vector, absdist vector, movement_scale
		//  Uses:     vec_scale, move_mode, result
		//  Provides: Actual movement of the model
		//  Calls:    On_Ground(); or In_Air();

		function car_move_gravity()
		{
			if (Airborne == 0) { On_Ground();}  // On some surface
			if (Airborne == 1) { In_Air();}	    // In the air, due to a jump ?

			// Now move ME by the relative and the absolute speed
			you = null;	// YOU entity is considered passable by MOVE
			vec_scale(dist,movement_scale);	// scale distance by movement_scale
			move_mode = ignore_you + ignore_passable + ignore_push + activate_trigger + glide;
			result = ent_move(dist,absdist);
			// Did we go anywhere?
			if(result > 0)
			{
				my_dist = vec_length(dist);  // Relative distance traveled
			}
			else
			{
				my_dist = 0;  // Player is not moving
			}
			car_speed = my_dist / time_step;  // Show speed based on actual movement
		}

		/////////////////////////////////////////////////////////
		//     FUNCTION  car_steering()     steering
		//
		//
		function car_steering()
		{
			dist_y = 0;
			steer_force = -steering;  //  Set turning force (-6 to +6)
			steer_speed = time_step * 4.6 * steer_force;	// was 2.3
			if ( (car_velocity != 0) && (Airborne == 0) ) 
			
				{ 
				// "steer_ratio" determines steering quickness, by speed
				// Steer_Damage is mormally one, but can be changed to damage steering
				steer_ratio = sin(car_velocity/2) * steer_damage; //was 2
				my.pan += steer_speed * time_step * steer_ratio;
				}
			
			
			if (my.pan > 360) { my.pan -= 360; }
			if (my.pan < 0) { my.pan += 360; }
			

		}
		///////////////////////////////////////////////////////////
		// Check toggles for steering and throttle input types
		// 0 is keyboard, 1 is mouse, 2 is joystick
// You can have only input source active for steering
// and one source for throttle (steering and throttle 
// can be set to different inputs at the same time)
//
// The "key_press" variables keep the toggle from repeating, or "bouncing"
//
function car_toggle() 
	{
 // Check the steering input toggle
 /*
  if ((key_s == 1) && (key_press1 == 0))   
   {
    Steering_Toggle += 1;   // Increment Steering_Toggle
    key_press1 = 1;         // Avoid "key bounce" or a repeating toggle
   } 
  else
   {
    if (key_s != 1) {key_press1=0;}  // Reset, if key_s is not still pressed
   }
   
   
  if (Steering_Toggle > 2) 
  { Steering_Toggle = 0;}
  */
  
  
 // Check the throttle input toggle
 
  if ((key_t == 1) && (key_press2 == 0))   
   {
    Throttle_Toggle += 1;  // Increment Throttle_Toggle
    key_press2 = 1;        // Avoid "key bounce" or a repeating toggle
   }
 else
  {
   if (key_t != 1) 
   {key_press2=0;}  // Reset if key_s is not still pressed
  }  
 if (Throttle_Toggle > 2) 
 { Throttle_Toggle = 0;}
} 
///////////////////////////////////////////////////////////
// Function Set_car_values()      (parameters)
//   Unused gears can be any value
//
function car_init()//called by Player Car action once
{ 
//     Set gear ratios here - Don't forget to set "Num_gears"
gear_ratio[0] = 4.16;     // Reverse gear  
  gear_ratio[1] = 2.26;     // First gear        1.86
  gear_ratio[2] = 2.05;     // Second gear   1.75
  gear_ratio[3] = 1.50;      // Third gear     1.60  
  gear_ratio[4] = 1.05;
  gear_ratio[5] = .80;     // Fifth gear 
  gear_ratio[6] = .70;     // Sixth gear 
gear_ratio[7] = .00;     // Neutral gear 
// Initialize physics values  
  absdist.x = 0;
  absdist.y = 0;
  absdist.z = 0;
  accelerator = 0;  // Accelerator - based on joystick throttle or keyboard -.2 to +1.0, was = 0
  Acel_Val = max(1, Acel_Val);  // Prevent possible divide by zero in script
  calc_rpm = 0;     // Calculated rpm
  car_velocity = 0; // (calculated)
  dist.x = 0;
  dist.y = 0;
  dist.z = 0;
  Drag *= 0.13;     // Modifies Drag for air density and car frontal area (calculated)
  gear = 1;         // Gear number in use - initially first gear (calculated)
  Max_Torq = horse_power * (550/32.1); // Max engine power, in foot pounds (calculated)
  Resistance = Drag * 188; // was 108, Rolling resistance, based on air Drag (calculated)
  Turn_Effect = max(1, Turn_Effect);  // Prevent possible divide by zero in script
  Vert_Accel = -Grav / Car_Weight;  // Vertical force on car (calculated)
  Wheel_Radius_Feet = Wheel_Radius_Inch / 12;  // Wheel radius converted to feet (calculated)
  Wheel_Dist = Wheel_Radius_Feet * 2 * pi; // Distance wheel travels per rotation (calculated)

//  Do housekeeping 
  if (Eng_Snd_On != 0)  {enghandle = snd_loop (engsound,20, 0);} // start engine sound
  //if (Horn_Snd_On != 0) {Car_Horn();}      // Start looking for horn button
  if (Squeal_On != 0)   {Car_Squeal();}    // Start looking for tire squeals
  if (RV_Mirror_On != 0){camera2_view.visible = ON;} // Show Rear_View Mirror
  if (Car_Hud_On != 0)  {Show_Hud();}      // Shows the on-screen displays
 //	if (Joy_Hat_On != 0)	{joy_hat();}		//operate joyhat
 // Adjust_Screen();     // Adjust on-screen display if 800x600 or 640x480
  show_turnsignals();
  
}
  
ifndef menu_wdl;
define menu_wdl;
include <saveLoad00.wdl>;
include <saveLoad01.wdl>;
SAVEDIR "C:\\BRSimData";



// ---------------------------------------------------------------------
// STARTHEADER
//
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Menu (01)
// class: INTERFACE
// type: USER
// image: menuSimple.pcx

// help: Simple menu includes: load, help, quit
// help: [ESC] key brings up main menu.
//
// needs: gid01.wdl, saveLoad00.wdl, saveLoad01.wdl, miscInput01.wdl
//
// prefix: menu01_
// idcode: 00F
//
// ENDHEADER
// ---------------------------------------------------------------------


//----------------------------------------------------------------------
// section: Main Menu Bitmaps

// entry: Item Background Bitmap
// help: Background image placed behind each menu item.
// id: 1
BMAP menu01_item_background_bmp = <menuBackground.pcx>;

// entry: Item Select Bitmap
// help: Background image placed behind the current selected menu item.
// id: 2
BMAP menu01_item_select_bmp = <menuSelect.pcx>;
var_nsave filehandle;

BMAP	saveLoad00_load_mouse_bmp = "arrow_blue.pcx";

//bmap	saveLoad00_tmp_mouse_bmp;
//----------------------------------------------------------------------
// section: Main Menu Positions

// entry: Starting X
// id: 3
var menu01_pos_x = 10;
// entry: Starting Y
// id: 4
var menu01_pos_y = 10;

// entry: X Offset
// help: X offset of menu text relative to button.
// id: 5
var menu01_txt_off_x = 2;
// entry: Y Offset
// help: Y offset of menu text relative to button.
// id: 6
var menu01_txt_off_y = 1;

// entry: X Offset
// help: X offset of menu buttons
// id: 7
var menu01_butt_off_x = 4;
// entry: Y Offset
// help: Y offset of menu buttons
// id: 8
var menu01_butt_off_y = 12;

//----------------------------------------------------------------------
// section: Main Menu Item Strings and Order

// entry: Item Font
// help: Font used for menu item strings
// id: 9
font menu01_item_font = "Arial",1,14;
FONT help_txt_font = "Arial",1,12;
// entry: "New Game" item string
// help: The string used for the "New Game" menu item.
// id: 10
string menu01_item_new_game_str = "Restart Simulator";
// entry: Position in main menu.
// help: Enter 0 to remove this item from menu.
// id: 11
var menu01_item_new_game_pos = 0;

// entry: "Load Game" item string
// help: The string used for the "Load Game" menu item.
// help: Blank out string to disable this item.
// id: 12
string menu01_item_load_game_str = "Load Scenario";
// entry: Position in main menu.
// help: Enter 0 to remove this item from menu.
// id: 13
var menu01_item_load_game_pos = 1; //was 

// entry: "Save Game" item string
// help: The string used for the "Save Game" menu item.
// help: Blank out string to disable this item.
// id: 14
string menu01_item_save_game_str = "Help";
// entry: Position in main menu.
// help: Enter 0 to remove this item from menu.
// id: 15
var menu01_item_save_game_pos = 2; //was 2

// entry: "Quit Game" item string
// help: The string used for the "Quit Game" menu item.
// help: Blank out string to disable this item.
// id: 16
string menu01_item_quit_game_str = "Quit Simulator";
// entry: Position in main menu.
// help: Enter 0 to remove this item from menu.
// id: 17
var menu01_item_quit_game_pos = 3; //was 3


//----------------------------------------------------------------------
//----------------------------------------------------------------------
// section: Confirm Menu Bitmaps

// entry: Confirm (yes/no) Background Bitmap
// help: background image placed behind the "yes/no" confirmation menu.
// id: 18
bmap menu01_confirm_panel_bmp = <confirmPanel.pcx>;
// entry: Confirm (yes/no) Item Bitmap
// help: background image placed behind the "yes/no" confirmation items.
// id: 19
bmap menu01_confirm_background_bmp = <confirmBackground.pcx>;
// entry: Confirm (yes/no) selected item bitmap
// help: background image placed behind selected "yes/no" confirmation items.
// id: 20
bmap menu01_confirm_select_bmp = <confirmSelect.pcx>;
//
BMAP helpwindow_bmp = "helpbrsimdrive15.bmp";
BMAP closehelpwinbutton_bmp = "closehelpwinbutton.bmp";
//----------------------------------------------------------------------
// section: Activate Confim Menu?

// entry: Confirm Quit? (1-yes, 0-no)
// id: 21
var menu01_confirm_quit_b = 1;
// entry: Confirm "Quit" string
// help: String displayed on confirm quit dialog
// id: 22
string menu01_confirm_quit_str = "Quit Simulator?";

// entry: Confirm New? (1-yes, 0-no)
// id: 23
var menu01_confirm_new_b = 1;
// entry: Confirm "Quit" string
// help: String displayed on confirm new dialog
// id: 24
string menu01_confirm_new_str = "Restart Simulator?";

//----------------------------------------------------------------------
// section: Confirm Menu Positions

// entry: Starting X
// id: 25
var menu01_confirm_pos_x = 10;
// entry: Starting Y
// id: 26
var menu01_confirm_pos_y = 10;

// entry: X offset
// help: X offset of menu text relative to button.
// id: 27
var menu01_confirm_txt_off_x = 2;
// entry: Y offset
// help: Y offset of menu text relative to button.
// id: 28
var menu01_confirm_txt_off_y = 1;

// entry: X offset of menu buttons
// id: 29
var menu01_confirm_butt_off_x = 4;
// entry: Y offset of menu buttons
// id: 30
var menu01_confirm_butt_off_y = 12;

// entry: Width of confirm buttons
// id: 31
var menu01_confirm_butt_width = 28;

//----------------------------------------------------------------------
// section: Menu input (keyboard)

// entry: Activate menu key
// id: 32
//string menu01_activate_key_c = "ESC";

// entry: Next item down key
// id: 33
string menu01_item_down_key_c = "cud";
var	menu01_item_down_scancode = 0;
// entry: Previous item up key
// id: 34
string menu01_item_up_key_c = "cuu";
var	menu01_item_up_scancode = 0;
// entry: Previous item to the left key
// id: 35
string menu01_item_left_key_c = "cul";
var	menu01_item_left_scancode = 0;
// entry: Next item to the right key
// id: 36
string menu01_item_right_key_c = "cur";
var	menu01_item_right_scancode = 0;
// entry: Execute the current item key
// id: 37
string menu01_item_execute_key_c = "enter";
var	menu01_item_execute_scancode = 0;

//----------------------------------------------------------------------
// section: Menu Selection Sounds

// entry: Selection Sound
// help: Sound played when the user moves to another selection.
// id: 38
sound  menu01_select_snd = <click.wav>;

// entry: Execute Sound
// help: Sound played when the user selects a menu item.
// id: 39
sound  menu01_execute_snd = <beep.wav>;


//----------------------------------------------------------------------
// section: Misc Menu Options

// enable: Freeze the game when the menu is displayed?
// id: 40
define menu01_freeze_game_b;


/////////////////////////////////////////////////////////////////////////
// Local variables

// is the menu active (0- no, 1- main menu, 2- confirm menu)
var menu01_active_b = 0; //was 0

// number of menu items
var menu01_item_count = 0;

// return value
//var 	mouse_map;
var	menu01_rtn = 0;
var	mouse_mode = 0;
var	old_mouse_mode;
//old_mouse_mode = mouse_mode;
//saveLoad00_tmp_mouse_bmp = mouse_map;



// Local function prototypes
function menu01_play_select_snd();	// play click sound
function	menu01_select_new();			// new selected
function	menu01_select_quit();		// quit selected
function	menu01_select_save();		// save selected
function	menu01_select_load();		// load selected
function menu01_closehelpwindow();


// Function pointers
action* menu01_action1_ptr;
action* menu01_action2_ptr;
action* menu01_action3_ptr;
action* menu01_action4_ptr;

// functions used in the menu item panels
function menu01_item_1_function(){menu01_action1_ptr();}  // run function attached to item 1
function menu01_item_2_function(){menu01_action2_ptr();}  // run function attached to item 2
function menu01_item_3_function(){menu01_action3_ptr();}  // run function attached to item 3
function menu01_item_4_function(){menu01_action4_ptr();}  // run function attached to item 4


// The items of which the menu really consists.
// Each item is a panel with a single button.
PANEL menu01_item_1_pan =
{
	layer = 200;
	flags = refresh;

	button = 0,0,								// x,y position
				menu01_item_select_bmp,		// button selected
				menu01_item_background_bmp,// button not selected
				menu01_item_select_bmp,  	// mouse over
				menu01_item_1_function,		// action on click
				NULL, 							// action on release
				menu01_play_select_snd; 	// action on mouse over
}
PANEL menu01_item_2_pan =
{

	layer = 200;
	flags = refresh;

	button = 0,0,								// x,y position
				menu01_item_select_bmp,		// button selected
				menu01_item_background_bmp,// button not selected
				menu01_item_select_bmp,  	// mouse over
				menu01_item_2_function,		// action on click
				NULL, 							// action on release
				menu01_play_select_snd; 	// action on mouse over
}
PANEL menu01_item_3_pan =
{

	layer = 200;
	flags = refresh;

	button = 0,0,								// x,y position
				menu01_item_select_bmp,		// button selected
				menu01_item_background_bmp,// button not selected
				menu01_item_select_bmp,  	// mouse over
				menu01_item_3_function,		// action on click
				NULL, 							// action on release
				menu01_play_select_snd; 	// action on mouse over
}

PANEL menu01_item_4_pan =
{
	layer = 200;
	flags = refresh;

	button = 0,0,								// x,y position
				menu01_item_select_bmp,		// button selected
				menu01_item_background_bmp,// button not selected
				menu01_item_select_bmp,  	// mouse over
				menu01_item_4_function,		// action on click
				NULL, 							// action on release
				menu01_play_select_snd; 	// action on mouse over
}


PANEL menu01_item_select =
{
	layer = 201.5;
	bmap = menu01_item_select_bmp;
	flags = REFRESH,TRANSPARENT;
}
PANEL help_pan =//help window
 	{
 		bmap = helpwindow_bmp;
 		pos_x = 380;
 		pos_y = 70;
 		//flags = overlay;
 		layer = 6;//was 6
	}


// Texts on the menu item buttons
TEXT menu01_item_1_txt { layer = 201; FONT menu01_item_font; STRING = ""; }
TEXT menu01_item_2_txt { layer = 201; FONT menu01_item_font; STRING = ""; }
TEXT menu01_item_3_txt { layer = 201; FONT menu01_item_font; STRING = ""; }
TEXT menu01_item_4_txt { layer = 201; FONT menu01_item_font; STRING = ""; }

STRING menu01_endscenario_str = "End of Scenario. Saving Data to File.";

TEXT menu01_endscenario_txt =      //End of Scenario, Press ESC key
		{
			pos_x = 400; //was 570
			pos_y = 320;//was 480
			scale_x = 1.0;
			scale_y = 1.0;
			font = big20_font;
			string (menu01_endscenario_str);
		}

// Desc: Play the 'select another item' sound
function menu01_play_select_snd()
{
	// play select sound at 40% volume center balance.
	snd_play(menu01_select_snd,40,0);
}

// Desc: Play the 'execute menu item' sound
function menu01_play_execute_snd()
{
	// play select sound at 40% volume center balance.
	snd_play(menu01_execute_snd,40,0);
}

// Desc: assign str to menu item text
function menu01_set_text_main(item,str)
{
	if(1 == item)
	{
		menu01_item_1_txt.string = str;
	}
	if(2 == item)
	{
		menu01_item_2_txt.string = str;
	}
	if(3 == item)
	{
		menu01_item_3_txt.string = str;
	}
	if(4 == item)
	{
		menu01_item_4_txt.string = str;
	}
}


// desc: this function should never be called
function	menu01_dummy_function()
{
	return(1);  // continue the loop
}

// desc: return function pointer based on cmd
//  	1- new game function ptr
//		2- load game function ptr
//		3- save game function ptr
//		4- quit game function ptr
function	menu01_rtn_action_main(cmd)
{
	if(1 == cmd) { return(menu01_select_new);  } // return function ptr to new function
	if(2 == cmd) { return(menu01_select_load); } // return function ptr to load game menu
	if(3 == cmd) { return(menu01_select_save); } // return function ptr to save game menu
	if(4 == cmd) { return(menu01_select_quit); } // return function ptr to new function

	return(menu01_dummy_function);	// attach nothing
}

// Desc: assign the appropriate action to this menu item
function	menu01_set_action_main(item,cmd)
{
	if(1 == item)
	{
		menu01_action1_ptr = menu01_rtn_action_main(cmd);
	}
	if(2 == item)
	{
		menu01_action2_ptr = menu01_rtn_action_main(cmd);
	}
	if(3 == item)
	{
		menu01_action3_ptr = menu01_rtn_action_main(cmd);
	}
	if(4 == item)
	{
		menu01_action4_ptr = menu01_rtn_action_main(cmd);
	}
}



// Desc: Show the main menu panels.
function menu01_show_main()
{
	freeze_mode=1; //freeze
	menu01_active_b = 1;
	snd_stopall(4);
	if(menu01_item_count > 0)
	{
		// Set position button panel
		menu01_item_1_pan.POS_X = menu01_pos_x;
		menu01_item_1_pan.POS_Y = menu01_pos_y;

		// Set position of text
		menu01_item_1_txt.POS_X = menu01_pos_x + menu01_txt_off_x;
		menu01_item_1_txt.POS_Y = menu01_pos_y + menu01_txt_off_y;

		// Make visible
		menu01_item_1_pan.visible = ON;
		menu01_item_1_txt.visible = ON;
	}
	if(menu01_item_count > 1)
	{
		// Set position button panel
		menu01_item_2_pan.POS_X = (menu01_butt_off_x) + menu01_pos_x; //was 1
		menu01_item_2_pan.POS_Y = (menu01_butt_off_y) + menu01_pos_y;

		// Set position of text
		menu01_item_2_txt.POS_X = (menu01_butt_off_x) + menu01_pos_x + menu01_txt_off_x;
		menu01_item_2_txt.POS_Y = (menu01_butt_off_y) + menu01_pos_y + menu01_txt_off_y;

		// Make visible
		menu01_item_2_pan.visible = ON;
		menu01_item_2_txt.visible = ON;
	}
	if(menu01_item_count > 2)
	{
		// Set position button panel
		menu01_item_3_pan.POS_X = (2*menu01_butt_off_x) + menu01_pos_x; //was 2
		menu01_item_3_pan.POS_Y = (2*menu01_butt_off_y) + menu01_pos_y;

		// Set position of text
		menu01_item_3_txt.POS_X = (2*menu01_butt_off_x) + menu01_pos_x + menu01_txt_off_x;
		menu01_item_3_txt.POS_Y = (2*menu01_butt_off_y) + menu01_pos_y + menu01_txt_off_y;

		// Make visible
		menu01_item_3_pan.visible = ON;
		menu01_item_3_txt.visible = ON;
	}
	if(menu01_item_count > 3) //quit simulator
	{
		// Set position button panel
		menu01_item_4_pan.POS_X = (3*menu01_butt_off_x) + menu01_pos_x; //was 3
		menu01_item_4_pan.POS_Y = (3*menu01_butt_off_y) + menu01_pos_y;

		// Set position of text
		menu01_item_4_txt.POS_X = (3*menu01_butt_off_x) + menu01_pos_x + menu01_txt_off_x;
		menu01_item_4_txt.POS_Y = (3*menu01_butt_off_y) + menu01_pos_y + menu01_txt_off_y;

		// Make visible
		menu01_item_4_pan.visible = ON;
		menu01_item_4_txt.visible = ON;
	}

	menu01_item_select.visible = OFF;
}

// Desc: Hide the menu panels.
function	menu01_hide_main()
{
	
	menu01_item_1_pan.visible = OFF;
	menu01_item_1_txt.visible = OFF;
	menu01_item_2_pan.visible = OFF;
	menu01_item_2_txt.visible = OFF;
	menu01_item_3_pan.visible = OFF;
	menu01_item_3_txt.visible = OFF;
	menu01_item_4_pan.visible = OFF;
	menu01_item_4_txt.visible = OFF;

	menu01_item_select.visible = OFF;
	if(menu01_active_b == 2){freeze_mode = 1;}  //freeze if confirm menu active
		else{freeze_mode=0;} //unfreeze
	 
		
}


// desc: highlight the current selected menu item
function	menu01_highlight(cur_item)
{
 	menu01_item_select.POS_X = menu01_pos_x + ((cur_item-1) * menu01_butt_off_x);
	menu01_item_select.POS_Y = menu01_pos_y + ((cur_item-1) * menu01_butt_off_y);
	menu01_item_select.visible = ON;
}


// desc: run the function attached to the menu item selected
function menu01_select(item)
{
 	if(1 == item)
	{
		menu01_action1_ptr();
	}
	if(2 == item)
	{
		menu01_action2_ptr();
	}
	if(3 == item)
	{
		menu01_action3_ptr();
	}
	if(4 == item)
	{
		menu01_action4_ptr();
	}
}

// desc: toggle on/off the menu loop
function	menu01_toggle_loop()
{
	if(menu01_active_b >= 1)    // is a menu already open?
		{
		menu01_active_b = 0;
		if(help_pan.VISIBLE == ON)
				{
				menu01_closehelpwindow();
				}
		return;
			
		}
			// only one menu should be active
	
	menu01_active_b = 1;

	//proc_kill(4);		// only one menu should be running
	snd_stopall(4);
	var	cur_item; // current selected item

	cur_item = 1;

	menu01_show_main();

	ifdef menu01_freeze_game_b;
	//if(menu01_freeze_game_b == 1)
	//{
		//freeze_mode = 1;	// when the menu is on screen, the game freezes
	//}
	endif;

	menu01_highlight(cur_item);	// show highlight

	while(menu01_active_b >= 1)
	{
		while(menu01_active_b >= 2)	// in a sub menu
		{
			wait(1);
		}

		// handle keyboard input
		if(Key_Pressed(menu01_item_down_scancode))// || (joy_buttons & 128))
		{
			cur_item += 1; //was 1
			if(cur_item > menu01_item_count) { cur_item = menu01_item_count; }
			else { menu01_play_select_snd(); }
			menu01_highlight(cur_item);
			wait(0.125); // wait an eigth of a second
		}
		if(Key_Pressed(menu01_item_up_scancode))// || (joy_buttons & 32))
		{
			cur_item -= 1; //was 1
			if(cur_item < 1) { cur_item = 1; }
			else { Menu01_Play_Select_Snd(); }
			menu01_highlight(cur_item);
			wait(0.125); // wait an eigth of a second
		}
		
		if(Key_Pressed(menu01_item_execute_scancode) || (joy_2))
		{
			menu01_play_execute_snd();			// play execute sound
			wait(0.250); // wait a quarter second
			menu01_select(cur_item);
		}


		wait(1);//was -.08
	}
	menu01_hide_main();	// hide the menu
	ifdef menu01_freeze_game_b;
	//if(menu01_freeze_game_b == 1)
	//{
		freeze_mode = 0;	// un-freeze game
	//}
	endif;
	menu01_active_b = 0;	// menu is no longer active

}


// Desc: init the menu
starter menu01_Init()
{
	diag("\nWDL-Loaded:menu01.wdl");

	menu01_item_count = 0; // no items in menu
	menu01_active_b = 0; // menu not active

	/////////////////////////////
	// Set up keyboard scancodes
	/////////////////////////////
	// use MiscInput01_Key_For_Str() to convert strings into scancodes
	// next item down key
	str_cpy(miscInput01_temp_str,menu01_item_down_key_c);
	menu01_item_down_scancode = MiscInput01_Key_For_Str();
	// prev item up key
	str_cpy(miscInput01_temp_str,menu01_item_up_key_c);
	menu01_item_up_scancode = MiscInput01_Key_For_Str();
	// prev item left key
	str_cpy(miscInput01_temp_str,menu01_item_left_key_c);
	menu01_item_left_scancode = MiscInput01_Key_For_Str();
	// next item right key
	str_cpy(miscInput01_temp_str,menu01_item_right_key_c);
	menu01_item_right_scancode = MiscInput01_Key_For_Str();
	// select item key
	str_cpy(miscInput01_temp_str,menu01_item_execute_key_c);
	menu01_item_execute_scancode = MiscInput01_Key_For_Str();

	// check items
	if( menu01_item_new_game_pos > 0 )
	{
		// new game item valid
		menu01_item_count = menu01_item_new_game_pos;
		menu01_set_text_main(menu01_item_new_game_pos,menu01_item_new_game_str); // set text
		menu01_set_action_main(menu01_item_new_game_pos,1);	// set action
	}
	if( menu01_item_load_game_pos > 0 )
	{
		// load game item valid
		if(menu01_item_count < menu01_item_load_game_pos)
		{
			menu01_item_count = menu01_item_load_game_pos;
		}
		menu01_set_text_main(menu01_item_load_game_pos,menu01_item_load_game_str);
		menu01_set_action_main(menu01_item_load_game_pos,2);	// set action
	}
	if( menu01_item_save_game_pos > 0 )
	{
		 //save game item valid
		if(menu01_item_count < menu01_item_save_game_pos)
		{
			menu01_item_count = menu01_item_save_game_pos;
		}
		menu01_set_text_main(menu01_item_save_game_pos,menu01_item_save_game_str);
		menu01_set_action_main(menu01_item_save_game_pos,3);	// set action
	}
	if( menu01_item_quit_game_pos > 0 )
	{
		// quit game item valid
		if(menu01_item_count < menu01_item_quit_game_pos)
		{
			menu01_item_count = menu01_item_quit_game_pos;
		}
		menu01_set_text_main(menu01_item_quit_game_pos,menu01_item_quit_game_str);
		menu01_set_action_main(menu01_item_quit_game_pos,4);	// set action
	}


}

STRING help1_str =
"CONTROLS\n
Keyboard:
  	ESC Key - Pauses simulator and shows main menu 
  	ENTER key - execute menu selection
  	ARROW Keys - Navigate menu
  	KEY R - Toggles drive/reverse
  	KEY H - Toggles low/high beams
  	KEY F10 - Fullscreen
  	KEY F12 - Window
Mouse - Use mouse to navigate lesson menu, load lesson, close windows\n
Steering Wheel
  Thrustmaster or Logitech FFB steering wheel/pedal set. 
  	 Latest Thrustmaster or Logitech drivers/firmware should be installed.
    To change steering and other control sensitivity use your Driver
    Software application, 
  Wheel Button controls programmed:
    Left paddle - Lft turn signal, click to start, press to stop
    Right paddle - Rt turn signal, click to start, press to stop
    POV Button - Slews roadway view 360 deg left or right
Scenario Loading Speed
	When loading from disc, load speed depends on DVD-ROM access speed. To increase load
	speed copy disc software to hard drive and execute simulator from there. Note: Requires
	about 500 MB of hard disc space.
Performance Measures
  Collisions with other objects and speed exceedances are displayed and recorded for all 
  scenarios. NoTurnsignalCount, Following-too-close, and BrakeRT and others are recorded for 
  relevant scenarios. Brake Reaction Time (RT) is measured from the time a hazard appears in the 
  roadway to the time the driver presses the brake pedal. All performance measures are stored 
  permanently in the BRSimData folder on your C: drive. If you delete or move the data (.txt) 
  files from the folder, a new data file will be created when that scenario is run. Do NOT delete, move,
  or rename the BRSimData folder itself. If needed, copy contents to another folder.
Display
  Designed for 1366 x 768 resolution with 256 MB video card or better.
  You can expand window size by lowering your monitor resolution but not below 1366 x 768. 
  Use anti-aliasing and anistropic settings on your video card software to improve image quality.  
Trouble Shooting
  See DVD case inserts for troubleshooting information\n";

TEXT help1_txt =
{
    pos_x = 425;//was 205
    pos_y = 160;
    layer = 7;
    font = help_txt_font;
    string = <help1_str>;
    //scale_x = .9;
    //scale_y = 1.0;
	flags = condensed;
  }
 
PANEL closehelp_pan
 	{
 	pos_x = 880;
 	pos_y = 110;
	layer = 11;
	flags = overlay;
	bmap = closehelpwinbutton_bmp;
	on_click = menu01_closehelpwindow();
	}
/////////////////////////////////////////////////////////////////////////
// Yes/No confirm

text	menu01_confirm_txt { layer = 203; FONT menu01_item_font; STRING = ""; }
text	menu01_confirm_yes_txt { layer = 203; FONT menu01_item_font; STRING = "Yes"; }
text	menu01_confirm_no_txt { layer = 203; FONT menu01_item_font; STRING = "No"; }

PANEL menu01_confirm_pan =
{
	layer = 202;
	flags = refresh;
	bmap = menu01_confirm_panel_bmp;
}

PANEL menu01_confirm_yes_pan =
{
	layer = 202.5;
	flags = refresh;
	button = 0,0,									// x,y position
				menu01_confirm_select_bmp,		// button selected
				menu01_confirm_background_bmp,// button not selected
				menu01_confirm_select_bmp,  	// mouse over
				NULL,									// action on click
				NULL, 								// action on release
				menu01_play_select_snd; 		// action on mouse over
}
PANEL menu01_confirm_no_pan =
{
	layer = 202.5;
	flags = refresh;
	button = 0,0,									// x,y position
				menu01_confirm_select_bmp,		// button selected
				menu01_confirm_background_bmp,// button not selected
				menu01_confirm_select_bmp,  	// mouse over
				NULL,									// action on click
				NULL, 								// action on release
				menu01_play_select_snd; 		// action on mouse over
}
PANEL  menu01_confirm_select_pan
{
	layer = 203.5;
	bmap = menu01_confirm_select_bmp;
	flags = REFRESH,TRANSPARENT;
}

 function menu01_closehelpwindow()
{
	help_pan.VISIBLE = OFF;  //hide help window, does not unfreeze
	closehelp_pan.VISIBLE = OFF; //hide close button
	help1_txt.VISIBLE = OFF; //hide help text
	mouse_mode = 0;
	menu01_active_b = 1; //make main menu active
}
// desc: ....
function	menu01_confirm_select(cur_item)
{
	return(0);
}

// desc: highlight the current selected menu item
function	menu01_confirm_highlight(cur_item)
{
	menu01_confirm_select_pan.POS_X = menu01_confirm_pos_x + ((cur_item-1) * menu01_confirm_butt_off_x);
	menu01_confirm_select_pan.POS_Y = menu01_confirm_pos_y + menu01_confirm_butt_off_y;
	if(cur_item == 2) { menu01_confirm_select_pan.POS_X += menu01_confirm_butt_width; }
}

// desc: display the string and a simple "yes/no" confirm dialog
// sets temp to 1 - if user selected yes, 0 - otherwise
function	menu01_confirm_yn(str)
{
	var	cur_item; // current selected item
	cur_item = 1;  	// start with yes
	menu01_active_b = 2;	// let main menu know we are in a sub-menu

	// set up confirm menu position and strings
	menu01_confirm_txt.string = str;
	menu01_confirm_txt.pos_x = menu01_confirm_pos_x + menu01_confirm_txt_off_x;
	menu01_confirm_txt.pos_y = menu01_confirm_pos_y + menu01_confirm_txt_off_y;

	menu01_confirm_yes_txt.pos_x = menu01_confirm_pos_x + menu01_confirm_butt_off_x;
	menu01_confirm_yes_txt.pos_y = menu01_confirm_pos_y + menu01_confirm_butt_off_y;
	menu01_confirm_no_txt.pos_x =  menu01_confirm_pos_x + menu01_confirm_butt_off_x + menu01_confirm_butt_width;
	menu01_confirm_no_txt.pos_y =  menu01_confirm_pos_y + menu01_confirm_butt_off_y;

	menu01_confirm_pan.pos_x = menu01_confirm_pos_x;
	menu01_confirm_pan.pos_y = menu01_confirm_pos_y;

	// make visible
	menu01_confirm_txt.visible = on;
	menu01_confirm_yes_txt.visible = on;
	menu01_confirm_no_txt.visible = on;
	menu01_confirm_pan.visible = on;
	menu01_confirm_select_pan.visible = on;

	// highlight yes
	menu01_confirm_highlight(cur_item);

	// hide other panels
	menu01_hide_main();


	// user must release the select key
	while(Key_Pressed(menu01_item_execute_scancode)) { wait(1); }

	while(menu01_active_b >=1 )//
	{  //
		// handle keyboard input
		if(Key_Pressed(menu01_item_right_scancode) || (joy_buttons & 256))
		{
			cur_item += 1;
			if(cur_item > 2) { cur_item = 2; }
			else { menu01_play_select_snd(); }
			menu01_confirm_highlight(cur_item);
			wait(0.125); // wait an eighth of a second
		}
		if(Key_Pressed(menu01_item_left_scancode) || (joy_buttons & 64))
		{
			cur_item -= 1;
			if(cur_item < 1) { cur_item = 1; }
			else { menu01_play_select_snd(); }
			menu01_confirm_highlight(cur_item);
			wait(0.125); // wait an eighth of a second
		}
		if(Key_Pressed(menu01_item_execute_scancode)  || (joy_3))
		{
			menu01_play_execute_snd();			// play execute sound
			
			menu01_confirm_select(cur_item);//
			wait(0.125); // wait a quarter of a second
			break;
		}

		wait(1);
	}
	// hide
	menu01_confirm_txt.visible = off;
	menu01_confirm_yes_txt.visible = off;
	menu01_confirm_no_txt.visible = off;
	menu01_confirm_pan.visible = off;
	menu01_confirm_select_pan.visible = off;

	if(menu01_active_b == 0)
	{
		// the user has escaped out of the menu
		menu01_rtn = 0; // don't quit
		return;
	}

	// user must release the select key
	while(Key_Pressed(menu01_item_execute_scancode)) { wait(1); }

	// return selection
	if(cur_item == 1)
	{
		menu01_rtn = 1; // user selected 'yes'
	}
	else
	{
		menu01_rtn = 0;	// user selected 'no'
	}

	menu01_active_b = 1; // return to main menu
	// show main menu panels
	menu01_show_main();

}


/////////////////////////////////////////////////////////////////////////
// Menu Item Functions
// Note: These are the default functions for each of the menu items.
//You can overwrite these with your own by redefining them after this
//script.

// function prototypes
//function main_restart_game();	// from the 'main' template
//function main_quit();			// from the 'main' template

// desc:
function	menu01_select_quit()
{
	menu01_rtn = -1;

	if(1 == menu01_confirm_quit_b)
	{
		menu01_rtn = -1;
		menu01_confirm_yn(menu01_confirm_quit_str);
  //		while(menu01_active_b >= 2)
		while(menu01_rtn < 0)
		{
			wait(1);
		}
		if(menu01_rtn == 0) { return(1); } // keep running menu
	}


	main_quit();	// call the quit function from the main template
	return(0);	// do not continue
}

function	menu01_select_new()
{
	menu01_rtn = -1;

	if(1 == menu01_confirm_new_b)
	{
		menu01_confirm_yn(menu01_confirm_new_str);
		while(menu01_active_b >= 2)
		{
			wait(1);
		}
		if(menu01_rtn == 0) { return(1); } // keep running menu
	}

	main_restart_game();
}

// Desc: open up the Help window
//			pause the main menu for the durration of the sub-menu's run
//			quit the main menu on exit
function	menu01_select_save() //for Help
{
	//menu01_hide_main();	// hide the menu and unfreeze
	//menu01_active_b = 3;	// signal that we are in a sub-menu

	help_pan.visible = ON;  //show Help window
	help1_txt.VISIBLE = ON; //show page 1 text
	closehelp_pan.VISIBLE = ON; //show close button
	//freeze_mode = 1;
	mouse_pointer = 0;
	mouse_map = saveLoad00_load_mouse_bmp;
	MOUSE_MODE = 1;

	
		
  if (MOUSE_MODE > 2) // was it already on?
  {  
    MOUSE_MODE=0;
  }
  while (MOUSE_MODE > 0) // move it over the screen
  {  
    MOUSE_POS.X = mouse_cursor.x;
    MOUSE_POS.Y = mouse_cursor.y;
		
    wait(1);
  }

}

// Desc: open up the load sub-menu
//			pause the main menu for the duration of the sub-menu's run
//			quit the main menu on exit
function	menu01_select_load()
{
	menu01_active_b = 3;	// signal that we are in a sub-menu

	// call up a simple (00) saveLoad help panel and pass control to it.
	//menu01_endscenario_txt.VISIBLE = ON;
	//wait(-3);
	//menu01_endscenario_txt.VISIBLE = OFF;

//Show Drive Sim Summary
//
if(scenariosummflag == 0)
	{
wait(2);
	menu01_hide_main();
	speeddial.VISIBLE = OFF;
	tachdial.VISIBLE = OFF;
	sneedle.VISIBLE = OFF;
	tneedle.VISIBLE = OFF;
	toprearmirror_pan.VISIBLE = OFF;
	leftrearmirror_pan.VISIBLE = OFF;
	rightrearmirror_pan.VISIBLE = OFF;
	truckleftrearmirror_pan.VISIBLE = OFF;
	truckrightrearmirror_pan.VISIBLE = OFF;
	distractDisplay_ent.VISIBLE = OFF;
	highbeams.VISIBLE = OFF;
	level_load ("");
	whitebackgrd_pan.VISIBLE = ON;
	freeze_mode = 1;
	//L1 file
	
	
	//str_cat(filename_str,"L1");//filename_str contains driver name and id
	//str_cat(filename_str,"GetStart");
	//str_cat(filename_str,".txt");
	//filehandle=file_open_read("atlee1111L1GetStart.txt");
	//fhandle_2 = file_open_read(filename_str);//atlee4444L1Getstart.txt
	//if(filehandle == file_open_read("atlee1111L1GetStart.txt") == 0)
	//{
	//filename_txt.VISIBLE = ON;
	//wait(-3);
	//filename_txt.VISIBLE = OFF;
	//}

	//str_cpy(delimit_str,",");//end input string
	//file_str_read(filehandle,datetime_str);//find 
	
	
	//numcollisions = file_var_read(fhandle_2);//read collisions into var
	wait(-.5);
	
	driveridnumber_txt.VISIBLE = ON;
	drivsimsumm_pan.VISIBLE = ON;
	closedrivsumm_pan.VISIBLE = ON;
	savedrivsumm_pan.VISIBLE = ON;
	sys_monthdisp.VISIBLE = ON;
	sys_daydisp.VISIBLE = ON;
	sys_yeardisp.VISIBLE = ON;
	sys_hoursdisp.VISIBLE = ON;
	sys_minutesdisp.VISIBLE = ON;
	scenarioname_txt.VISIBLE = ON;
	numcollisionssumm.VISIBLE = ON;
	speedlimitsumm.VISIBLE = ON;
	speedtooslowsumm.VISIBLE = ON;
	noturnsignalsumm.VISIBLE = ON;
	followtooclosesumm.VISIBLE = ON;
	meanlatdevsumm_pan.VISIBLE = ON;
	overroadedgesumm.VISIBLE = ON;
	overmediansumm.VISIBLE = ON;
	brakertsumm.VISIBLE = ON;
	}
	mouse_mode = 1;
	while(drivsimsumm_pan.VISIBLE == ON)
	{
	mouse_pos.x = mouse_cursor.x;
	mouse_pos.y = mouse_cursor.y;
	wait(1);
	}
	mouse_mode = 0;
	whitebackgrd_pan.VISIBLE = OFF;
	distractDisplay_ent.VISIBLE = OFF;
	driveridnumber_txt.VISIBLE = OFF;
	drivsimsumm_pan.VISIBLE = OFF;
	closedrivsumm_pan.VISIBLE = OFF;
	savedrivsumm_pan.VISIBLE = OFF;
	sys_monthdisp.VISIBLE = OFF;
	sys_daydisp.VISIBLE = OFF;
	sys_yeardisp.VISIBLE = OFF;
	sys_hoursdisp.VISIBLE = OFF;
	sys_minutesdisp.VISIBLE = OFF;
	scenarioname_txt.VISIBLE = OFF;
	numcollisionssumm.VISIBLE = OFF;
	speedlimitsumm.VISIBLE = OFF;
	speedtooslowsumm.VISIBLE = OFF;
	noturnsignalsumm.VISIBLE = OFF;
	followtooclosesumm.VISIBLE = OFF;
	meanlatdevsumm_pan.VISIBLE = OFF;
	overroadedgesumm.VISIBLE = OFF;
	overmediansumm.VISIBLE = OFF;
	brakertsumm.VISIBLE = OFF;
	clearInstructText();
	geardisp.VISIBLE = OFF;
	
	saveLoad00_active = 1;
	SaveLoad00_LoadState_Display();	// run the saveLoad load lesson panel

	while(saveLoad00_active == 1) { wait(1); }	// load lesson panel is running...
	
	//menu01_active_b = 0;	// menu is no longer active (quit)
	return(0);	// do not continue
}
ON_F10 fullscreen_toggle;
ON_F12 windowed;
ON_ESC menu01_toggle_loop;//toggles menu
//ON_JOY1 menu01_toggle_loop;

endif;
////////////////////////////////////////////////////////////// 
include <Car_Cam.wdl>;  // Include the Car Cam wdl file (script)

