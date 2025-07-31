public var bloodDrips:Bool = true;

function onPsychEvent(n, v1, v2)
    if (n == 'Markov note spawns blood') {
        switch (StringTools.trim(v1).toLowerCase()) {
			case 'true': bloodDrips = true;
			default: bloodDrips = false;
	    }
    }