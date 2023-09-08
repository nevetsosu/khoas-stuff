
////////////////////////////////////////////////////////////////////////
// File: camera.wdl
////////////////////////////////////////////////////////////////////////
///BRDrivingSimEXM v. 2.6
///

var car_view_switch = 0;   // Contains view number, set by "function cycle_car_view()"

// Function prototypes
function Ahead_View();	   // View through the windshield
//function joy_hat();
//function Tail_view();      // View from behind the vehicle
//function Helo_View();      // Helicopter view, above and behind the vehicle
//function Follow_View();    // Same as Helicopter view, but distance varies with speed
//function Overhead_View();  // A satellite view, centered on the vehicle
//function car_view();		   // Select function to set the camera view
//function cycle_car_view(); // Toggle selector function, to switch views
//function slewViewright();
//function panning_view();  //players head view for panning



///////////////////////////////////////////////////////////////////////
// Desc: Ahead_View - Looking out the windshield
//       View number 0  (The default view)
//


function slewViewright()
{
	
	while(key_pressed(81) == ON)//press pagedown
	{
	camera.pan = player.pan;
	camera.x = player.x;    // place camera at player's location
	camera.y = player.y;
	//camera.z = player.z + player.MIN_Z;  // start at 'feet', move up later...
	camera.pan = 180;
	speeddial.VISIBLE = OFF;
	tachdial.VISIBLE = OFF; 
	sneedle.VISIBLE = OFF; 
	tneedle.VISIBLE = OFF;
	geardisp.VISIBLE = OFF;
	toprearmirror_pan.VISIBLE = OFF;
	leftrearmirror_pan.VISIBLE = OFF;
	rightrearmirror_pan.VISIBLE = OFF;
	truckrightrearmirror_pan.VISIBLE = OFF;
	truckleftrearmirror_pan.VISIBLE = OFF;
	camera2_view.VISIBLE = OFF;
	camera3_view.VISIBLE = OFF;
	camera4_view.VISIBLE = OFF;
	camera5_view.VISIBLE = OFF;
	camera6_view.VISIBLE = OFF;
	wait(1);
	}

}
function slewViewleft()
{
	
	while(key_pressed(79) == ON)//press End
	{
	camera.pan = player.pan;
	camera.x = player.x;    // place camera at player's location
	camera.y = player.y;	
	//camera.z = player.z + player.MIN_Z;  // start at 'feet', move up later...	
	camera.pan = 360;
	speeddial.VISIBLE = OFF;
	tachdial.VISIBLE = OFF; 
	sneedle.VISIBLE = OFF; 
	tneedle.VISIBLE = OFF;
	geardisp.VISIBLE = OFF;
	toprearmirror_pan.VISIBLE = OFF;
	leftrearmirror_pan.VISIBLE = OFF;
	rightrearmirror_pan.VISIBLE = OFF;
	truckrightrearmirror_pan.VISIBLE = OFF;
	truckleftrearmirror_pan.VISIBLE = OFF;
	camera2_view.VISIBLE = OFF;
	camera3_view.VISIBLE = OFF;
	camera4_view.VISIBLE = OFF;
	camera5_view.VISIBLE = OFF;
	camera6_view.VISIBLE = OFF;
	wait(1);
	}

}

function Ahead_View()//called by play_car_move function which is called by Playr_Car move
{
	//camera.VISIBLE = OFF;//hide camera
	//	camera.diameter = 0;		// make the camera passable
		//pos_x = 652;  // x distance from upper left corner of screen
	//pos_y = 22;    // y distance from top of screen
	//camera.size_x = 224; // x size of view window, in pixels
	//camera.size_y = 268; 
//
		//camera.genius = player;	// don't display parts of ME
	// Position the camera		
	  camera.x = player.x;    // place camera at player's location
		camera.y = player.y;
		camera.z = player.z + player.MIN_Z;  // start at 'feet', move up later...
		
		
	if(car_weight == 2600)
		{
		camera.z += (player.MAX_Z-player.MIN_Z) -5.5; // was -2.5
		player.z += 1; //was 3
		camera2_view.VISIBLE = ON;
		camera3_view.VISIBLE = ON;
		camera4_view.VISIBLE = ON;
		toprearmirror_pan.VISIBLE = ON;
		leftrearmirror_pan.VISIBLE = ON;
		rightrearmirror_pan.VISIBLE = ON;
		camera5_view.VISIBLE = OFF;//truck
		camera6_view.VISIBLE = OFF;
		truckrightrearmirror_pan.VISIBLE = OFF;
		truckleftrearmirror_pan.VISIBLE = OFF;
		}
		
  	if(car_weight == 16000)//settings for truck
  		{
  		camera.z += (player.MAX_Z-player.MIN_Z) -2.5; // was +8
  	//	player.z += 10;
	//	player.z += 51;
		camera2_view.VISIBLE = OFF;	
		camera3_view.VISIBLE = OFF;
		camera4_view.VISIBLE = OFF;
		toprearmirror_pan.VISIBLE = OFF;
		leftrearmirror_pan.VISIBLE = OFF;
		rightrearmirror_pan.VISIBLE = OFF;
		camera5_view.VISIBLE = ON;
		camera6_view.VISIBLE = ON;
		truckrightrearmirror_pan.VISIBLE = ON;
		truckleftrearmirror_pan.VISIBLE = ON;
		}
		 // 
	on_end = slewViewleft;
	on_pgdn = slewViewright;
	
	camera.pan = player.pan;   // Camera faces the same way as the player
	//	while(1)
	//	{
			if (joy_hat > -1)// view hat pressed
				
				{
					
					if(car_weight==16000) //truck
						{
				
						camera2_view.VISIBLE = OFF; //no rearview mirror
					//	camera5_view.VISIBLE = ON;
					//	camera6_view.VISIBLE = ON;
		
						if(joy_hat == 360)	//allow views to sectors indicated
							{
							camera.pan -= joy_hat;  //= 0;use of - to align hat with pan
							camera2_view.VISIBLE = OFF;
							camera3_view.VISIBLE = OFF;
							camera4_view.VISIBLE = OFF;
							camera5_view.VISIBLE = OFF;
							camera6_view.VISIBLE = OFF;
					
							speeddial.VISIBLE = OFF;
							tachdial.VISIBLE = OFF; 
							sneedle.VISIBLE = OFF; 
							tneedle.VISIBLE = OFF;
							geardisp.VISIBLE = OFF;
							toprearmirror_pan.VISIBLE = OFF;
							leftrearmirror_pan.VISIBLE = OFF;
							rightrearmirror_pan.VISIBLE = OFF;
							}
						if((joy_hat == 90))	//
							{
							camera.pan -= joy_hat;  //180;
							camera2_view.VISIBLE = OFF;
							camera3_view.VISIBLE = OFF;
							camera4_view.VISIBLE = OFF;
							camera5_view.VISIBLE = OFF;
							camera6_view.VISIBLE = OFF;
							toprearmirror_pan.VISIBLE = OFF;
							leftrearmirror_pan.VISIBLE = OFF;
							rightrearmirror_pan.VISIBLE = OFF;
							speeddial.VISIBLE = OFF;
							tachdial.VISIBLE = OFF; 
							sneedle.VISIBLE = OFF; 
							tneedle.VISIBLE = OFF;
							geardisp.VISIBLE = OFF;
							}
						if(joy_hat == 45)	//restrict view of right 
							{
							camera.pan -= joy_hat;  //180;
							camera2_view.VISIBLE = OFF;
							camera3_view.VISIBLE = OFF;
							camera4_view.VISIBLE = OFF;
							camera5_view.VISIBLE = OFF;
							camera6_view.VISIBLE = OFF;
								toprearmirror_pan.VISIBLE = OFF;
							leftrearmirror_pan.VISIBLE = OFF;
							rightrearmirror_pan.VISIBLE = OFF;
							speeddial.VISIBLE = OFF;
							tachdial.VISIBLE = OFF; 
							sneedle.VISIBLE = OFF; 
							tneedle.VISIBLE = OFF;
							geardisp.VISIBLE = OFF;
							}
							
				
						if(joy_hat == 315)	//restrict view
							{
							camera.pan -= joy_hat;  //180;
							camera2_view.VISIBLE = OFF;
							camera3_view.VISIBLE = OFF;
							camera4_view.VISIBLE = OFF;
							camera5_view.VISIBLE = OFF;
							camera6_view.VISIBLE = OFF;
							toprearmirror_pan.VISIBLE = OFF;
							leftrearmirror_pan.VISIBLE = OFF;
							rightrearmirror_pan.VISIBLE = OFF;
							speeddial.VISIBLE = OFF;
							tachdial.VISIBLE = OFF; 
							sneedle.VISIBLE = OFF; 
							tneedle.VISIBLE = OFF;
							geardisp.VISIBLE = OFF;
							}
							
							if((joy_hat == 270))	//allow view to 0 pan
							{
							camera.pan -= joy_hat;  //90;
							camera2_view.VISIBLE = OFF;
							camera3_view.VISIBLE = OFF;
							camera4_view.VISIBLE = OFF;
							camera5_view.VISIBLE = OFF;
							camera6_view.VISIBLE = OFF;
							toprearmirror_pan.VISIBLE = OFF;
							leftrearmirror_pan.VISIBLE = OFF;
							rightrearmirror_pan.VISIBLE = OFF;
							speeddial.VISIBLE = OFF;
							tachdial.VISIBLE = OFF; 
							sneedle.VISIBLE = OFF; 
							tneedle.VISIBLE = OFF;
							geardisp.VISIBLE = OFF;
							}
							
						}
							
				
					else //joy hat slew view for 2600 lb vehicles
						{
						camera2_view.VISIBLE = ON; 
						//camera5_view.VISIBLE = OFF;
						//camera6_view.VISIBLE = OFF;
						camera.pan -= joy_hat;
						camera2_view.VISIBLE = OFF;
						camera3_view.VISIBLE = OFF;
						camera4_view.VISIBLE = OFF;
						camera5_view.VISIBLE = OFF;
						camera6_view.VISIBLE = OFF;
						toprearmirror_pan.VISIBLE = OFF;
						leftrearmirror_pan.VISIBLE = OFF;
						rightrearmirror_pan.VISIBLE = OFF;
						speeddial.VISIBLE = OFF;
						tachdial.VISIBLE = OFF; 
						sneedle.VISIBLE = OFF; 
						tneedle.VISIBLE = OFF;
						geardisp.VISIBLE = OFF;
						}	 
						
				}//end conditional for 16000
				//slew view to left and right	
			
		if(joy_hat <= -1)//when joy_hat is NOT pressed
			{
			if (car_weight == 2600)
				{
				camera.pan = player.pan;
				camera2_view.VISIBLE = ON;
				toprearmirror_pan.VISIBLE = ON;
				camera3_view.VISIBLE = ON;
				camera4_view.VISIBLE = ON;
				toprearmirror_pan.VISIBLE = ON;
				leftrearmirror_pan.VISIBLE = ON;
				rightrearmirror_pan.VISIBLE = ON;
				camera5_view.VISIBLE = OFF;
				camera6_view.VISIBLE = OFF;
				
				speeddial.VISIBLE = ON;
				tachdial.VISIBLE = ON;
				sneedle.VISIBLE = ON; 
				tneedle.VISIBLE = ON;
				geardisp.VISIBLE = ON; 	 // no key pressed
				}
			if (car_weight == 16000)
				{
				camera.pan = player.pan;
				camera2_view.VISIBLE = OFF;
				camera3_view.VISIBLE = OFF;//adjust higher
				camera4_view.VISIBLE = OFF;
				toprearmirror_pan.VISIBLE = OFF;
				camera5_view.VISIBLE = ON;
				camera6_view.VISIBLE = ON;
				speeddial.VISIBLE = ON;
				tachdial.VISIBLE = ON;
				sneedle.VISIBLE = ON; 
				tneedle.VISIBLE = ON;
				geardisp.VISIBLE = ON; 	 // 
				}
			}//end view hat NOT pressed
		//wait(5);
	//}//end loop for view hat
}
		/*while(1)
		{
			if (key_z || joy_4) {camera.pan += .09 * time_step; camera2_view.VISIBLE = OFF;
				speeddial.VISIBLE = OFF; tachdial.VISIBLE = OFF; sneedle.VISIBLE = OFF; 
				tneedle.VISIBLE = OFF; geardisp.VISIBLE = OFF;} //slew view to left
				//tarrow.VISIBLE = OFF;
				
			if (key_c || joy_5) {camera.pan -= .09 * time_step; camera2_view.VISIBLE = OFF;
				speeddial.VISIBLE = OFF; tachdial.VISIBLE = OFF; sneedle.VISIBLE = OFF; 
				tneedle.VISIBLE = OFF; geardisp.VISIBLE = OFF;} //slew view to right
				//tarrow.VISIBLE = OFF;
			if ((key_z || joy_4 == 0) && (key_c || joy_5 == 0)){camera.pan = player.pan;camera2_view.VISIBLE = ON;
				speeddial.VISIBLE = ON; tachdial.VISIBLE = ON; sneedle.VISIBLE = ON; 
				tneedle.VISIBLE = ON; geardisp.VISIBLE = ON; }	 // no key pressed
				//tarrow.VISIBLE = ON;
			//else {camera.pan = player.pan;}
			 	
			//else   // Camera faces the same way as the player
		wait(4);
		}
		camera.tilt = player.tilt; // Camera tilts with the vehicle
		camera.roll = player.roll; // Camera rolls with the vehicle
	*/
}//end function
/////////////////////////////////////////////////////////////////////////
// Desc: Tail view - directly behind the vehicle (and slightly above)
//       View number 1
//
function Tail_view()
{
 		//camera.diameter = 0;		// make the camera passable
	 // place camera behind and slightly above player's location
	  camera.x = player.x + cos(player.pan) * (-300);  // Offset from player
		camera.y = player.y + sin(player.pan) * (-300);  // Offset from player
		camera.z = player.z + player.MIN_Z;  // start at 'feet', move up later...
		camera.z += (player.MAX_Z-player.MIN_Z) + 40;
		camera.pan = player.pan;   // Camera faces the same way as the player
		camera.tilt = -2;          // Fixed camera tilting
		camera.roll = 0;           // No camera rolling 

}
/////////////////////////////////////////////////////////////////////////
// Desc: Helicopter view, above and behind the vehicle
//       View number 2

function Helo_View()
{
 		//camera.diameter = 0;		// make the camera passable
	 // place camera above and behind player's location
	  camera.x = player.x + cos(player.pan) * (-800);  // Offset from player
		camera.y = player.y + sin(player.pan) * (-800);  // Offset from player
		camera.z = player.z + 800; // Distance above player's origin
		camera.pan = player.pan;   // Camera faces the same way as the player
		camera.tilt = -10;         // Fixed camera tilting
		camera.roll = 0;           // No camera rolling
}
/////////////////////////////////////////////////////////////////////////
// Desc: Follow view, above and behind the vehicle
//       Catches up, or falls back, depending on vehicle speed
//       View number 3
//
function Follow_View()
{
 		//camera.diameter = 0;		// make the camera passable
   // Place camera behind player's location		
	  camera.x = player.x+cos(player.pan) * (-(500+abs(car_velocity*3))); // Offset from player    
		camera.y = player.y+sin(player.pan) * (-(500+abs(car_velocity*3))); // Offset from player
		camera.z = player.z + 80 + abs(car_velocity)*2; // Distance above player's origin
		camera.pan = player.pan;   // Camera faces the same way as the player
		camera.tilt = -(abs(car_velocity)/16);          // Fixed camera tilting
		camera.roll = 0;           // No camera rolling
}
/////////////////////////////////////////////////////////////////////////
// Desc: Overhead_View
// A satellite view, centered on the vehicle
//  WARNING:  If your sky box is not high enough, this may give
//            you a bad view.  Either raise the top of your sky box,
//            or lower the overhead camera height (see below)
//       View number 4
//
function Overhead_View()  
{
 	//	camera.diameter = 0;		// make the camera passable
	// Position the camera
	  camera.x = player.x;    // place camera above player's location
		camera.y = player.y;
		camera.z = player.z + 3000; // Change this value to raise or lower camera height
		camera.pan = player.pan;   // Camera faces the same way as the player
		camera.tilt = -60;         // Point the camera almost straight down
		camera.roll = 0;           // No camera rolling
}
/////////////////////////////////////////////////////////////////////
// Desc: Call the appropriate function to move the camera
//       If you add more views, change the "IF" test number in 
//        "function cycle_car_view()"  (below)
//	
function car_view()
{
	if(player == null) { player = me; }	// this action needs the player pointer
	if(player == null) { return; }			// still no player -> can't work

	if(car_view_switch == 0) {Ahead_View();}
	///if(car_view_switch == 1) {Tail_view();}
	//if(car_view_switch == 2) {Helo_View();}
	//if(car_view_switch == 3) {Follow_View();}
	//if(car_view_switch == 4) {Overhead_View();}

				
}
/////////////////////////////////////////////////////////////////////
// Desc: Cycle car views, based on car_view_switch
//
//	
function cycle_car_view()
{
  car_view_switch = 0;
  if (car_view_switch > 4) {car_view_switch = 0;}
 // Change the number in the above "IF" statement to add more views
}

// Define ON_KEY functions
// On V, middle mouse button, or Joy4, switch views

on_v	cycle_car_view();   // Change "on_z" to use a different key to select views
//on_joy4 cycle_car_view(); // Change "on_joy4" to use a different joystick button
on_mouse_middle cycle_car_view(); 