function onPsychEvent(n, v1, v2)
    if (n == 'Toggle Note Camera Movement') {
        var val2:Float = Std.parseFloat(v2);

        switch (StringTools.trim(v1).toLowerCase()) {
			case 'true' | '1': noteCam = true;
			default: noteCam = false;
		}

        if (Math.isNaN(val2)) camNoteExtend = 15;
		else camNoteExtend = val2;
    }