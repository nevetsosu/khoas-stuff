ifndef display_wdl;
define display_wdl;

// ---------------------------------------------------------------------
// STARTHEADER
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Display
// class: MISC
// type: USER
// image: display.pcx
// help: The display represents the screen that all windows are rendered to.
//
// needs: gid01.wdl
//
// prefix: display00_
// idcode: 00A
//
// ENDHEADER
// ---------------------------------------------------------------------



//----------------------------------------------------------------------
// section: General Settings

// entry: Screen Resolution
// help: Set the initial screen resolution.
// help: Note: Some resolutions may not be available on all video cards.
// help:or for all versions of GStudio.
// help: 1 - 320x200, 2 - 320x240, 3 - 320x400, 4 - 400x300,
// help: 5 - 512x384, 6 - 640x480, 7 - 800x600, 8 - 1024x768
// help: 9 - 1280x960, 10 - 1400x1050, 11 - 1600x1200
// cntl: spin 1 11 1
// id: 1
//var   video_set(1280,1024,16,2)
//var   video_switch(9,16,2)
//var   video_mode = 8;	// 1024x768 or 8

// entry: Color Depth
// help: Video color depth. Can be set to 16 (high-color) or 32 (true-color)
// cntl: spin 16 32 16
// id: 2
var 	video_depth = 16; // 16bit high-color


//1 no border 
//2 thin border 
//4 thick border 
//16 title bar and border 
//48 title bar with system menu 
//112 title bar with system menu and minimize button 
//256 hide the window 

var video_window = 16;

// entry: Force Full/Window?
// help: Force display to fullscreen (1) or windowed (2), or leave unchanged (0)
// cntl: spin 0 2 1
// id: 3
define	display00_force_window_full_const = 2;//was 1

// entry: Watermark Loc
// help: Select the corner where the watermark will appear.
// help:(0-off, 1-4 select corner)
// cntl: spin 0 4 1
// id: 4
var logo = 0;

//----------------------------------------------------------------------
// section: Limits

// entry: Max Entities
// help: Set the maximum number of entities.
// cntl: spin 0 x x
// id: 5
var max_entities = 500;

// entry: Max Particles
// help: Set the maximum number of Particles
// cntl: spin 0 x x
// id: 6
var max_particles = 2000;


//----------------------------------------------------------------------
// section: Frames Per Second (FPS)

// entry: FPS MAX
// help: Maximum frame per second (FPS)
// cntl: spin 1 x 1
// id: 7
var fps_max = 30;

// entry: FPS MIN
// entry: Keep time_step above this frame per second (FPS) value 
// cntl: spin 1 x 1
// id: 8
var fps_min = 16;//was 16

// entry: Smoothing
// help: Average the last couple of frames to reduce "jerks"
// help: 0 = no smoothing, 0.5 = 2 frames, 0.99 = 10 frames
// id: 54
var	time_smooth = 0.66;//was .66

//----------------------------------------------------------------------
// section: Lighting

// entry: Max Dynamic
// help: Gives the maxium number of dynamic lights (including the sun) that
// help: can be active at the same time (Range: 2..8 for A6, 2..1000 for A7).
// cntl: spin 2 8 1
// id: 10
var max_lights = 20;//was 8

// enable: Dynamic Sun?
// help: Use directional light for sun?
// help: Note: This will use one of the dynamic lights.
// id: 11
var sun_light = 1;

//----------------------------------------------------------------------
// section: Shadow

// entry: Shadow Offset
// help: Set the distance that entity shadows are offset from the floor
// id: 12
var shadow_offset = 2.5;

// entry: Stencil Shadow
// help: Stencil shadows 'bend' around corners, and objects cast shadows on themselves.
// id: 53
var shadow_stencil = 1;


//----------------------------------------------------------------------
// section: Entity Display Settings


// entry: Floor Range
// help: Set the range within which the light value of a entity is effected.
// cntl: spin 0 x 1
// id: 13
var floor_range = 1000;

// enable: Disable Trans. Sort
// help: (Advanced) Disable sorting of transparent entities
// id: 14
// var d3d_entsort = 0;

// enable: Share textures?
// help: (Advanced) Make map entities share texture with level and each other.
// id: 15
var tex_share = 1;



//----------------------------------------------------------------------
// section: Mouse

// entry: Mouse Icon
// help: Set the look of the windows mouse pointer when over the application window.
// help:   0: The mouse pointer is always switched off over the window.
// help:   1: The mouse pointer is switched off when mouse_mode is activated
// help:        and a mouse_map is set, otherwise it's a hand.
// help:   2: Like 1, but the mouse pointer is the standard arrow.
// help:   3: Like 1, but the mouse pointer is a crosshair.
// help:   4: Like 1, but the mouse pointer is a hourglass.
// cntl: spin 0 4 1
// id: 20
var	mouse_pointer = 0;	// turn off mouse pointer


//----------------------------------------------------------------------
// section: Advanced Settings

// entry: Anisotopy
// help: Maximum level of anisotropy (0 - off)
// help: Used to help eliminate distortion in textures whose surfaces
// help:are oriented with respect to the screen plane.
// help: Set to a value greater than 1.0 to activate.
// id: 21
var	d3d_anisotropy = 4;//was 4

// enable: Force Triple Buffer?
// help: (Advanced) Force triple buffering?
// id: 22
//var d3d_triplebuffer = 1;


// enable: Force VSync
// help: (Advanced) Force vertical sync?
// id: 24
//var d3d_vsync = 1;


// enable: Disable Mipmapping
// help: Deactivate mipmapping
// id: 26
var d3d_mipmapping = 2;//1 for polygon; 2 for scanline was 2

// entry: Mipmap dist (flat)
// help: Set the relative distance for switching mipmap textures on flat surfaces
// id: 27
var mip_flat = 3.0;//was 1.5

// entry: Mipmap dist (shaded)
// help: Set the relative distance for switching mipmap textures on shaded surfaces
// id: 28
var mip_shaded = 3.0;

// enable: Adv. Light Res?
// help: Improve light resolution
// id: 29
// var d3d_lightres = 1;

// enable: Monochrome?
// help: Disable color lights
// id: 30
// var d3d_monochrome = 1;


// entry: Detail pixel num.
// help: Set the number of detail pixels per terrain surface pixel.
// id: 32
var detail_size = 4;//was 4




// An array of bit-encoded fields which tell which, if any, camera is
//currently assigned to update a particular camera.
// Index: 0:main view, 1-4: sub views 1-4
var	display_active_camera_vec[5];

// Count of the number of active views
// default to just the main view (1)
var 	display_active_views = 1;//was 1




//----------------------------------------------------------------------
// section: Clip Ranges

// entry: Clip Factor
// help: Multiplier for the clipping range or world (BSP) polygons.
// help: Example: A value of 2 would clip world polygons at twice
// help:the distance as object polygons.
// id: 40
var clip_factor = 2.0;

// entry: Clip Particles
// help: Multiplier for the clipping range of particles.
// help: Example: A value of 0.5 would clip particles at half the
// help:distance as object polygons.
// id: 41
var clip_particles = 0.5;

// entry: Clip Size
// help: Minimum number of pixels a polygon must cover before being clipped.
// help: Example: a value of 0.5 would clip polygons whose size is less
// help:than half a pixel.
// id: 42
var clip_size = 0.5;




// function_help: Init display values
// Init values
// Update views using assigned update functions
starter	Display00_Init()
{
	diag("\nWDL-Loaded:display00.wdl");
	// Init display

// entry: Near Camera clip
// help: Reduce this value if you can see through near objects
// cntl: spin 1 x 1
// id: 43
	camera.clip_near = 5;

// entry: Far Camera clip
// help: Increase this value if objects vanish too soon.
// cntl: spin 1 x 1
// id: 44
	camera.clip_far = 40000; //was 40000

	// force a switch on the video modes if display00_force_window_full_const is set
if(display00_force_window_full_const != 0) { video_switch(0,0,display00_force_window_full_const); }

//----------------------------------------------------------------------
// section: Background Color

// entry: Red
// help: Set background color's red component.
// help: Note: if all three components are set to 0, no background color is drawn.
// cntl: spin 0 255 1
// id: 45
	bg_color.red = 1;
// entry: Green
// help: Set background color's green component.
// help: Note: if all three components are set to 0, no background color is drawn.
// cntl: spin 0 255 1
// id: 46
	bg_color.green = 1;
// entry: Blue
// help: Set background color's blue component.
// help: note: if all three components are set to 0, no background color is drawn.
// cntl: spin 0 255 1
// id: 47
	bg_color.blue = 1;


//----------------------------------------------------------------------
//  section: Fog Settings

// entry: Fog color Index
// help: Select the fog color from the Map Prop panel in WED.
// cntl: spin 0 5 1
// id: 52
	fog_color = 0; // 1 = white, 0 = off

// entry: Fog Start
// help: Percent of clip_range until fog start
// help: There won't be any fog closer than fog_start
// id: 50
	camera.fog_start = .90;
	camera.fog_start /= .90; // fog in rear view
	if(camera.fog_start < 0) { camera.fog_start = 0; }


// entry: Fog End
// help: Percent of clip_range until fog end
// help:  The world will be all foggy beyond fog_end
// id: 51
	//camera.fog_end = .95;
	//camera.fog_end /= .95; // fog in rear view mirror
	if(camera.fog_end < 0) { camera.fog_end = 0; }

	//camera.fog_start = camera.fog_start *  camera.clip_far; // fog at 80% of clip_range
	//camera.fog_end = camera.fog_end *  camera.clip_far; // fog till 90% of clip_range
}


endif;