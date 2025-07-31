var comboPath:String = 'game/score/';

function onPsychEvent(name, v1, v2)
    if (name == 'Change Combo UI') {
        if (v1 == '' || v1 == 'normalUI/') comboPath = 'game/score/';
        else if (v1 == 'poemUI/') comboPath = 'poemUI/';
    }

function onNoteHit(event) event.ratingPrefix = comboPath;