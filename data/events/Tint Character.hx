function onPsychEvent(n, v1, v2, v3)
    if (n == 'Tint Character') {
        var char:Character = boyfriend;
		var val3:Int = FlxColor.fromString('#' + v3);

		switch (StringTools.trim(v2).toLowerCase()) {
			default: char = boyfriend;
			case 'gf' | 'girlfriend': char = gf;
			case 'dad': char = dad;
			case 'yuri': char = yuri;
			case 'sayori': char = sayori;
		}

		if (Math.isNaN(val3))
			val3 = 0xFFFFFFFF;
		
		switch (v1.toLowerCase()) {
			case 'red': char.color = FlxColor.RED;
			case 'black': char.color = FlxColor.BLACK;
			case 'gray' | 'grey': char.color = FlxColor.GRAY;
			case 'white' | 'default': char.color = FlxColor.WHITE;
			default: char.color = val3;
		}
    }