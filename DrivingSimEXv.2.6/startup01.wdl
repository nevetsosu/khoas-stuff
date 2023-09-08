ifndef startup_wdl;
define startup_wdl;

// ---------------------------------------------------------------------
// STARTHEADER
//
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Start up screen(s)
// class: INTERFACE
// type: USER
// image: startup01.pcx
// help: Define the start screens (up to 2)
//
//
// prefix: startup01_
// idcode: 01C
//
// needs: gid01.wdl
//
// ENDHEADER
// ---------------------------------------------------------------------

//camera.VISIBLE = OFF;

// entry: Select the background bitmap
// help: This will coverup the game window while the logos are being displayed.
// id: 9
BMAP startup01_backgrnd_bmp = "black.bmp"; // the default A6 logo in templates


// entry: Select the first bitmap (logo bitmap)
// help: Note: Unless you own Pro edition, the first bitmap must be an A7 logo bitmap.
// id: 1
BMAP startup01_logo1_bmp = "logodark.bmp"; // the new A7 logo in templatesplace

// entry: Select the second bitmap (project bitmap)
// help: Note: The second bitmap can be anything you like.
// id: 3
BMAP startup01_logo2_bmp = "drivingsimex26.bmp"; //  DrivingSim logo here




PANEL startup01_backgrnd_pan 
	{ 
	bmap = startup01_backgrnd_bmp; 
	layer = 1000; 
//	flags = refresh,d3d; 
	}

PANEL startup01_logo1_pan 
	{ 
	bmap = startup01_logo1_bmp; 
	layer = 1001; 
	flags = refresh,d3d; 
	}
PANEL startup01_logo2_pan 
	{ 
	bmap = startup01_logo2_bmp; 
	layer = 1002; 
	flags = refresh,d3d; 
	}


// Desc: Show the splash screens at startup
starter	Startup01_show_start_screens()
{
	// once only values

	// section: Panel #1
	// entry: "Up Time"
	// help: Select the amount of time (seconds) the logo is displayed
	// help: Note: A6 logo must be displayed for at least 1 second
	// cntl: spin 1 x 1
	// id: 2
	var	startup01_logo1_time = 1;

	// entry: Fade in time
	// help: If greater then 0, the amount of seconds it takes to fade this logo in from black.
	// id: 5
	var	startup01_logo1_fadein = 2;

	// entry: Fade out time
	// help: If greater then 0, the amount of seconds it takes to fade this logo to black.
	// help: If less then 0, don't wait until this logo has faded out to continue with the next panel.
	// id: 6
	var	startup01_logo1_fadeout = -2;


	// section: Panel #2
	// entry: "Up Time"
	// help: Select the amount of time (seconds) the logo is displayed
	// id: 4
	var	startup01_logo2_time = 2;

	// entry: Fade in time
	// help: If greater then 0, the amount of seconds it takes to fade this logo from black.
	// id: 7
	var	startup01_logo2_fadein = 2;

	// entry: Fade out time
	// help: If greater then 0, the amount of seconds it takes to fade this logo to black.
	// help: If less then 0, don't wait until this logo has faded out to continue.
	// id: 8
	var	startup01_logo2_fadeout = 3;

	screen_color.red   = 5;
	screen_color.green = 5;
	screen_color.blue  = 5;

	// cover up any other panels
//	startup01_backgrnd_pan.scale_x = (screen_size.x/bmap_width(startup01_backgrnd_bmp));
//	startup01_backgrnd_pan.scale_y = (screen_size.y/bmap_height(startup01_backgrnd_bmp));
//	startup01_backgrnd_pan.pos_x = 0;
//	startup01_backgrnd_pan.pos_y = 0;
	startup01_backgrnd_pan.visible = on;

	wait(5);  // allow first level to load
	diag("\nWDL-Loaded:Startup01.wdl");

	// don't display the level
	camera.visible = off;

	// TODO: Pause gameplay
	// Start Screen #1
	if(startup01_logo1_time > 0)
	{
		// center the logo panel
//		startup01_logo1_pan.pos_x = (screen_size.x - bmap_width(startup01_logo1_bmp))/2;
//		startup01_logo1_pan.pos_y = (screen_size.y - bmap_height(startup01_logo1_bmp))/2;

		// scale panel to fill screen
		startup01_logo1_pan.scale_x = (screen_size.x/bmap_width(startup01_logo1_bmp));
		startup01_logo1_pan.scale_y = (screen_size.y/bmap_height(startup01_logo1_bmp));
 		startup01_logo1_pan.pos_x = 0;
		startup01_logo1_pan.pos_y = 0;


		// Optional Fade in
		if(startup01_logo1_fadein > 0)
		{
			Clib_Panel_Fade(startup01_logo1_pan,0,100,startup01_logo1_fadein);
			sleep(startup01_logo1_fadein);
		}
		else
		{
			// set it visible
			startup01_logo1_pan.visible = on;
		}
		// screen time
		sleep(startup01_logo1_time);

		// Optional Fade out
		if(startup01_logo1_fadeout != 0)
		{
			if(startup01_logo1_fadeout < 0)
			{
				// crossfade
				startup01_logo1_fadeout = abs(startup01_logo1_fadeout);
				Clib_Panel_Fade(startup01_logo1_pan,100,0,startup01_logo1_fadeout);
			}
			else
			{
				Clib_Panel_Fade(startup01_logo1_pan,100,0,startup01_logo1_fadeout);
		  		sleep(startup01_logo1_fadeout);
			}
		}
		else
		{
			startup01_logo1_pan.visible = off;
		}
	}

	// Start Screen #2
	if(startup01_logo2_time > 0)
	{
		// center the logo panel
//		startup01_logo2_pan.pos_x = (screen_size.x - bmap_width(startup01_logo2_bmp))/2;
//		startup01_logo2_pan.pos_y = (screen_size.y - bmap_height(startup01_logo2_bmp))/2;

		// scale panel to fill screen
		startup01_logo2_pan.scale_x = (screen_size.x/bmap_width(startup01_logo2_bmp));
		startup01_logo2_pan.scale_y = (screen_size.y/bmap_height(startup01_logo2_bmp));
 		startup01_logo2_pan.pos_x = 0;
		startup01_logo2_pan.pos_y = 0;

		// Optional Fade in
		if(startup01_logo2_fadein > 0)
		{
			Clib_Panel_Fade(startup01_logo2_pan,0,100,startup01_logo2_fadein);
			sleep(startup01_logo2_fadein);
		}
		else
		{
			// set it visible
			startup01_logo2_pan.visible = on;
		}

 		sleep(startup01_logo2_time);

		// Optional Fade out
		if(startup01_logo2_fadeout != 0)
		{
			if(startup01_logo2_fadeout < 0)
			{
				startup01_logo2_fadeout = abs(startup01_logo2_fadeout);
				Clib_Panel_Fade(startup01_logo2_pan,100,0,startup01_logo2_fadeout);
			}
			else
			{
				Clib_Panel_Fade(startup01_logo2_pan,100,0,startup01_logo2_fadeout);
				sleep(startup01_logo2_fadeout);
			}
		}

		startup01_logo2_pan.visible = off;

	}
	


	// return camera control
camera.visible = on;
	freeze_mode = 0;

	startup01_backgrnd_pan.visible = off;

	// clean up
	bmap_purge(startup01_logo1_bmp);
	bmap_purge(startup01_logo2_bmp);
	bmap_purge(startup01_backgrnd_bmp);
	
	
}


endif;