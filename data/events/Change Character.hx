function onPsychEvent(name, v1, v2)
    if (name == 'Change Character') {
        var strum:Int = switch(StringTools.trim(v1).toLowerCase()) {
            default: 0;
            case '1' | 'player' | 'bf' | 'boyfriend': 1;
            case '2' | 'speaker' | 'gf' | 'girlfriend': 2;
        }
        
        changeCharacter(strum, v2, 0, true);
    }