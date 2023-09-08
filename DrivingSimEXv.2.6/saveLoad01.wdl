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
// help: Allows the user to save the current state of a game/simulation/etc under a name of their choising.
// help:User can then load this saved state back at a later time.
//
//
// prefix: saveLoad01_
// idcode: 019
//
// ENDHEADER
// ---------------------------------------------------------------------





string	saveLoad01_dir_str = "";	// save game directory (pathed from game directory)

//----------------------------------------------------------------------
// section: Save Game Panel

// entry: The "Save Game" Background panel bitmap
// id: 1
bmap saveLoad01_save_bmp = <saveLoad_save_bmp.pcx>;

// Used to tell the calling function when we are finished displaying save/load menus
// 1 - active, 0 - done
var saveLoad01_active = 0;

panel saveLoad01_save_pan
{
// entry: Layer
// id: 2
	layer = 10;
// entry: Position X
// id: 3
	pos_x = 0;
// entry: Position Y
// id: 4
	pos_y = 0;

	bmap = saveLoad01_save_bmp;

	window = 307, 15,      		// offset into panel
				320, 240,			// size of image
				saveLoad01_save_bmp,//saveLoad01_tmp_bmp, // source image
				0, 0;					// x,y offset in source


 	flags = refresh;
}



// ---------------------------------------------------------------------
// Basic Functions

starter SaveLoad01_Load()
{
	diag("\nWDL-Loaded:saveLoad01.wdl");
}


// Desc: save the current state using the file name given
// Input: name (string) name of the save game (including path)
// Input: num (var) number appendend to save game name
// Input: mode the save mode (see game_save documentation)
// Return: -1 on error, 1 on success
function SaveLoad01_SaveState(name, num, mode)
{
	if(game_save(name,num,mode) <= 0) { return(-1); }       // error occured durring save
	else { return(1); }							// state save successful
}


// Desc: Load a game state from a file name given.
// Input: name (string)
// Return: -1 on error, 1 on success
function SaveLoad01_LoadState(name, num)
{
	if(game_load(name,num) <= 0) { return(-1); }       // error occured durring load
	else { return(1); }							// load state successful
}


// Desc: Display save game panel, allow user the option to save game state
function SaveLoad01_SaveState_Display()
{
	// take a picture of everything
	wait(1);	// allow the calling function to remove any menus
	screenshot("saveLoad_tmp_bmp",0);
	wait(1);	// wait for screenshot to finish before displaying this menu

	// Display panel
	saveLoad01_save_pan.visible = on;

	sleep(2);


	saveLoad01_save_pan.visible = off;
	saveLoad01_active = 0; 	// signal calling function that we are done
}



endif;