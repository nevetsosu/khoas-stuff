ifndef miscInput_wdl;
define miscInput_wdl;

// ---------------------------------------------------------------------
// STARTHEADER
//
// ver: 5.0
// engineReq: 6.4
// date: 061011
//
// title: Misc Input Functions (01)
// class: INTERFACE
// type: SUPPORT
// image: miscInput01.pcx
// help: A collection of functions that allows keyboard, mouse, and joystick buttons to be mapped.
// note: Assume we are using a US keyboard layout.
//
// needs:
//
// uses:
//
// prefix: miscInput01_
// idcode: 010
//
// ENDHEADER
// ---------------------------------------------------------------------



string	miscInput01_temp_str[256];	// temp string

// Desc: Return the scancode for the key corresponding to the string passed in
//
// Note: Assume we are using a US keyboard layout.
function	MiscInput01_Key_For_Str()
{
	// check for single letter strings
	if(str_len(miscInput01_temp_str) == 1)
	{
		// simple keycode (A-Z, 0-9)
		return(Key_For_Str(miscInput01_temp_str));
	}

	// Note: str_cmpi is string compare without case sensitivity.


	// Mouse Buttons
  	if(1 == str_cmpni(miscInput01_temp_str,"mouse")) // possible mouse button
	{
  		if(1 == str_cmpi(miscInput01_temp_str,"mouse_left")) // left mouse button
		{
			return(280);	// left mouse button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"mouse_middle")) // middle mouse button
		{
			return(282);	// middle mouse button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"mouse_right")) // right mouse button
		{
			return(281);	// right mouse button scancode
		}
	}

	// Joystick Buttons
  	if(1 == str_cmpni(miscInput01_temp_str,"joy")) // possible joystick button
	{
  		if(1 == str_cmpni(miscInput01_temp_str,"joy2")) // possible second joystick button
		{
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_1")) // joy2 1 button
			{
				return(268);	// joy2 1 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_2")) // joy2 2 button
			{
				return(269);	// joy2 2 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_3")) // joy2 3 button
			{
				return(270);	// joy2 3 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_4")) // joy2 4 button
			{
				return(271);	// joy2 4 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_5")) // joy2 5 button
			{
				return(272);	// joy2 5 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_6")) // joy2 6 button
			{
				return(273);	// joy2 6 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_7")) // joy2 7 button
			{
				return(274);	// joy2 7 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_8")) // joy2 8 button
			{
				return(275);	// joy2 8 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_9")) // joy2 9 button
			{
				return(276);	// joy2 9 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_10")) // joy2 10 button
			{
				return(277);	// joy2 10 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_11")) // joy2 9 button
			{
				return(278);	// joy2 9 button scancode
			}
  			if(1 == str_cmpi(miscInput01_temp_str,"joy2_12")) // joy2 10 button
			{
				return(279);	// joy2 10 button scancode
			}
		}// end joy2_ buttons

		// first joystick buttons
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_1")) // joy 1 button
		{
			return(256);	// joy 1 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_2")) // joy 2 button
		{
			return(257);	// joy 2 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_3")) // joy 3 button
		{
			return(258);	// joy 3 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_4")) // joy 4 button
		{
			return(259);	// joy 4 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_5")) // joy 5 button
		{
			return(260);	// joy 5 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_6")) // joy 6 button
		{
			return(261);	// joy 6 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_7")) // joy 7 button
		{
			return(262);	// joy 7 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_8")) // joy 8 button
		{
			return(263);	// joy 8 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_9")) // joy 9 button
		{
			return(264);	// joy 9 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_10")) // joy 10 button
		{
			return(265);	// joy 10 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_11")) // joy 11 button
		{
			return(266);	// joy 10 button scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"joy_12")) // joy 12 button
		{
			return(267);	// joy 10 button scancode
		}
	}// end joystick buttons


	// keyboard function keys
  	if(1 == str_cmpni(miscInput01_temp_str,"f")) // possible function key
	{
  		if(1 == str_cmpi(miscInput01_temp_str,"f12")) // F12 key
		{
			return(88);	// f12 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f11")) // F11 key
		{
			return(87);	// f11 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f10")) // F10 key
		{
			return(68);	// f10 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f9")) // F9 key
		{
			return(67);	// f9 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f8")) // F8 key
		{
			return(66);	// f8 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f7")) // F7 key
		{
			return(65);	// f7 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f6")) // F6 key
		{
			return(64);	// f6 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f5")) // F5 key
		{
			return(63);	// f5 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f4")) // F4 key
		{
			return(62);	// f4 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f3")) // F3 key
		{
			return(61);	// f3 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f2")) // F2 key
		{
			return(60);	// f2 scancode
		}
  		if(1 == str_cmpi(miscInput01_temp_str,"f1")) // F1 key
		{
			return(59);	// f1 scancode
		}
	}

	// other special keyboard keys
  	if(1 == str_cmpi(miscInput01_temp_str,"esc")) // esc key
	{
		return(1);	// esc key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"bksp")) // backspace key
	{
		return(14);	// backspace or Losch key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"tab")) // tab key
	{
		return(15);	// tab key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"enter")) // enter key
	{
		return(28);	// enter key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"shiftl")) // left shift key
	{
		return(42);	// left shift key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"shiftr")) // right shift key
	{
		return(54);	// right shift key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"ctrl")) // ctrl key
	{
		return(29);	// ctrl key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"alt")) // alt key
	{
		return(56);	// alt key scancode
	}

  	if(1 == str_cmpi(miscInput01_temp_str,"prtsc")) // print scn key
	{
		return(55);	// print scn key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"numlock")) // numlock key
	{
		return(69);	// numlock key scancode
	}

	if(1 == str_cmpi(miscInput01_temp_str,"scrlock")) // Scroll Lock key
	{
		return(70);	// scroll lock key scancode
	}

  	if(1 == str_cmpi(miscInput01_temp_str,"ins")) // insert key
	{
		return(82);	// insert key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"del")) // delete key
	{
		return(83);	// delete key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"home")) // home key
	{
		return(71);	// home key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"end")) // end key
	{
		return(79);	// end key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"pgup")) // page up key
	{
		return(73);	// page up key scancode
	}
  	if(1 == str_cmpi(miscInput01_temp_str,"pgdn")) // page down key
	{
		return(81);	// page down key scancode
	}

	// cursor keys
	if(1 == str_cmpi(miscInput01_temp_str,"cuu")) // up cursor key
	{
		return(72);	// up cursor key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"cud")) // down cursor key
	{
		return(80);	// down cursor key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"cul")) // left cursor key
	{
		return(75);	// left cursor key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"cur")) // right cursor key
	{
		return(77);	// right cursor key scancode
	}

	if(1 == str_cmpi(miscInput01_temp_str,"kpminus")) // Keypad Minus
	{
		return(74);	// Keypad Minus scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"kpplus")) // Keypad Plus
	{
		return(78);	// Keypad Plus scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"kpast")) // Keypad Asterix
	{
		return(55);	// Keypad Asterix scancode
	}


	if(1 == str_cmpi(miscInput01_temp_str,"grave")) // grave key "~"
	{
		return(41);	// grave key scancode
	}

	if(1 == str_cmpi(miscInput01_temp_str,"minus")) // minus key
	{
		return(12);	// minus key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"equal")) // equal key
	{
		return(13);	// equal key scancode
	}

	if(1 == str_cmpi(miscInput01_temp_str,"brackl")) // left bracket key
	{
		return(26);	// left bracket key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"brackr")) // right bracket key
	{
		return(27);	// right bracket key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"bksl")) // backslash key
	{
		return(43);	// backslash key scancode
	}

	if(1 == str_cmpi(miscInput01_temp_str,"semic")) // semicolon key
	{
		return(39);	// semicolon key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"apos")) // apos "'" key
	{
		return(40);	// apos "'" key scancode
	}


	if(1 == str_cmpi(miscInput01_temp_str,"comma")) // comma key
	{
		return(51);	// comma key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"period")) // period key
	{
		return(52);	// period key scancode
	}
	if(1 == str_cmpi(miscInput01_temp_str,"slash")) // slash key
	{
		return(53);	// slash key scancode
	}

  	if(1 == str_cmpi(miscInput01_temp_str,"space")) // space bar
	{
		return(57);	// space bar scancode
	}

}

endif;