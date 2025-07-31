import StringTools;

function onPsychEvent(name, v1, v2)
    if (name == 'Force Dance') {
        var char:Character = dad;
        
        switch(StringTools.trim(v1).toLowerCase()) {
            case 'bf' | 'boyfriend': char = boyfriend;
            case 'gf' | 'girlfriend': char = gf;
            default:
                var val2:Int = Std.parseInt(v2);
				if (Math.isNaN(val2)) val2 = 0;

				switch(val2) {
					case 1: char = boyfriend;
					case 2: char = gf;
				}
        };
        char.dance();
    }