ifndef gid_wdl;
define gid_wdl;

// ---------------------------------------------------------------------
// STARTHEADER
//
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Global Identifiers (01)
// class: TOOLS
// type: SUPPORT
// image: gid.pcx
// help: Most scripts that deal with an entity require this script. It is used
/// to give each type of entity a unique identification number. This identification
/// number is used by other scripts to determine behavior.
// help:
// help: Global Identifiers also contains skill defines for values like velocity,
/// damage, distance, and time. These "generic values" can be used to pass
/// information between scripts.
// help:
// help: This is also where global 'event varibles' are stored.
//
// needs:
//
// external:
//
// prefix: gid01_
// idcode: 000
//
// ENDHEADER
// ---------------------------------------------------------------------


////////////////////////////////////////////////////////////////////////
// Global

var	temp2[3];

entity* temp_ent;


////////////////////////////////////////////////////////////////////////
// Entity IDs (stored in SKILL48)
define	_gid01_id, skill48;
// player IDs
define gid01_player_const = 1; 		// player id

// AI ids (64-127)
define gid01_ai_const = 64;			// generic AI



// Map entity IDs
define gid01_platform_const = 128; 		// moving platform id (lift01)
define gid01_water_const = 129;			// generic water id
define gid01_forcefield_const = 130; 	// force field id
define gid01_door_const = 131;			// door id (door01)
define gid01_damagefield_const = 132;  // dmage field id

// shared skills:


// Message Passing Skill (set by other entities to pass messages.
define	_gid01_message, skill49;

// Velocity in quants/tick
define	_gid01_vel_x, skill21;        // current velocity (quants/tick)
define	_gid01_vel_y, skill22;        // current velocity (quants/tick)
define	_gid01_vel_z, skill23;        // current velocity (quants/tick)

// ang velocity in deg/tick
define _gid01_ang_vel_pan, SKILL24;
define _gid01_ang_vel_tilt, SKILL25;
define _gid01_ang_vel_roll, SKILL26;



////////////////////////////////////////////////////////////////////////
// Shared vars (used for passing "event values")

// Type of event being preformed:
var	gid01_event_type;
// -null event
define	gid01_event_null = 0;

// -entity is being activated by a scan (i.e. open door, pickup item, etc.)
define	gid01_event_scan_activate = 1;

// - entity is being scanned passively (i.e. in player scan cone but not being activated)
define	gid01_event_scan_passive = 6;

// -entity has been shot by a projectile
define	gid01_event_projectile_damage = 2;

// -entity is in a blast radius
define	gid01_event_blast_damage = 5;

// -"alert" sound scan (guard raising alarm, siren going off, etc.)
define	gid01_event_alert_sound = 3;


// - push event
define	gid01_event_push = 4;



// Value associated with current 'gid01_event_type'
// (e.g. if gid01_event_type == gid01_event_projectile_damage, then
// gid01_event_value == Damage_Done)
var	gid01_event_value;


////////////////////////////////////////////////////////////////////////
// Global State values

// state of the level
var	gid01_level_state = 0;
// level is not loaded
define	gid01_level_not_loaded = 0;
// level is loaded
define	gid01_level_loaded = 1;
// level is being restarted
define	gid01_level_restart = 2;
// level is changing (e.g. level1 to level2)
define	gid01_level_change = 3;
// level is paused
define	gid01_level_pause = 4;


//----------------------------------------------------------------------
// Temp values
string gid01_temp_mdl = <temp.mdl>;	// placeholder model
var	 gid01_vec[3];						// temp vec
var	 gid01_vec2[3];					// temp vec2



// Misc Values
define	gid01_max_value = 999999.999;
define	gid01_min_value = -999999.999;

define	gid01_smallest_value = 0.001;	// values smaller than this could be rounded off to zero


panel* clib_panel;
// Desc: Fade a panel in or out.
//
// Use: Clib_Panel_Fade(my_pan,100,0,5);	// fade from 100 to 0 in 5 seconds
function Clib_Panel_Fade(pan,from,to,secs)
{
   clib_panel = pan;
   clib_panel.visible = on;
   clib_panel.transparent = on;

   var t = 0;
   while(t < secs*16)
	{
		clib_panel = pan;	// in case global pointer is overwritten
		clib_panel.alpha = from + (to-from)*t/(secs*16);
		t += time_step;
		wait(1);
   }
	clib_panel = pan;	// in case global pointer is overwritten
   clib_panel.alpha = to;
   if (clib_panel.alpha <= 0) { clib_panel.visible = off; }
   if (clib_panel.alpha >= 100) { clib_panel.transparent = off; }
   clib_panel = NULL; // indicate termination
}


define	clib_panel_center = 0;
define	clib_panel_upleft = 1;
define	clib_panel_upright = 2;
define	clib_panel_downleft = 3;
define	clib_panel_downright = 4;
define	clib_panel_up = 5;
define	clib_panel_down = 6;
define	clib_panel_left = 7;
define	clib_panel_right = 8;
// Desc: Place a panel in one of the four corners, in the center, or
//      centered along one of the sides.
//
// Use:
function Clib_Panel_Position(pan,pos,width,height)
{
   clib_panel = pan;

	if((pos <= clib_panel_center) || (pos > clib_panel_right))
	{
		// centered or out-of-range
		clib_panel.pos_x = (screen_size.x - width)/2;
		clib_panel.pos_y = (screen_size.y - height)/2;

		return;
	}

	// handle corners
	if(pos <= clib_panel_downright)
	{
		if(pos <= clib_panel_upleft)
		{
			// 1-upper left
			clib_panel.pos_x = 0;
			clib_panel.pos_y = 2;   // bug(?) requires a 2 pixel offset to show digits
			return;
		}

		if(pos <= clib_panel_upright)
		{
			// 2-upper right,
			clib_panel.pos_x = (screen_size.x - width);
			clib_panel.pos_y = 2;  // bug(?) requires a 2 pixel offset to show digits
			return;

		}

		if(pos <= clib_panel_downleft)
		{
			// 3-lower left
			clib_panel.pos_x = 0;
			clib_panel.pos_y = (screen_size.y - height);
			return;
		}

		// 4-lower right
		clib_panel.pos_x = (screen_size.x - width);
		clib_panel.pos_y = (screen_size.y - height);

		return;
	} // end handle corners


	// handle sides
	if(pos <= clib_panel_up)
	{
		// 5-up
		clib_panel.pos_x = (screen_size.x - width)/2;
		clib_panel.pos_y = 2;   // bug(?) requires a 2 pixel offset to show digits
		return;
	}

	if(pos <= clib_panel_down)
	{
		// 6-down,
		clib_panel.pos_x = (screen_size.x - width)/2;
		clib_panel.pos_y = (screen_size.y - height);
		return;

	}

	if(pos <= clib_panel_left)
	{
		// 7-left
		clib_panel.pos_x = 0;
		clib_panel.pos_y = (screen_size.y - height)/2;
		return;
	}
	// 8-right
	clib_panel.pos_x = (screen_size.x - width);
	clib_panel.pos_y = (screen_size.y - height)/2;
	return;

	// end handle sides

}


endif;