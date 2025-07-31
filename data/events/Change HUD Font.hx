function onPsychEvent(name, v1, v2) {
    if (name == 'Change HUD Font') {
        var font:String = '';
        var size:Float = 1.25;
        
        switch(StringTools.trim(v1).toLowerCase()) {
            default: font = 'Aller_Rg.ttf';
            case 'fnf': font = 'vcr.ttf';
            case 'poem':
                font = 'VTKS_ANIMAL_2.ttf';
                size = 2;
        }
        
        for (hud in [scoreTxt, accuracyTxt, missesTxt]) {
            hud.font = Paths.font(font);
            hud.borderSize = size;
        }
    }
}