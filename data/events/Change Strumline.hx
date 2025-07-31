function onPsychEvent(name, v1, v2)
    if (name == 'Change Strumline') {
        var sprite:String = '';
        
        if (v1 == 'poem') sprite = 'poemUI/NOTE_assets';
        else sprite = 'game/notes/default';

        // hey, dont look at me, blame the looper, it dont let me iterate it with player
        for (strum in cpu) {
            strum.frames = Paths.getSparrowAtlas(sprite);
            strum.animation.addByPrefix('green', 'arrowUP');
            strum.animation.addByPrefix('blue', 'arrowDOWN');
            strum.animation.addByPrefix('purple', 'arrowLEFT');
            strum.animation.addByPrefix('red', 'arrowRIGHT');

            strum.animation.addByPrefix('static', 'arrow' + ["left", "down", "up", "right"][strum.ID].toUpperCase());
            strum.animation.addByPrefix('pressed', ["left", "down", "up", "right"][strum.ID] + ' press', 24, false);
            strum.animation.addByPrefix('confirm', ["left", "down", "up", "right"][strum.ID] + ' confirm', 24, false);

            strum.animation.play('static');
            strum.updateHitbox();
        }

        for (strum in player) {
            strum.frames = Paths.getSparrowAtlas(sprite);
            strum.animation.addByPrefix('green', 'arrowUP');
            strum.animation.addByPrefix('blue', 'arrowDOWN');
            strum.animation.addByPrefix('purple', 'arrowLEFT');
            strum.animation.addByPrefix('red', 'arrowRIGHT');

            strum.animation.addByPrefix('static', 'arrow' + ["left", "down", "up", "right"][strum.ID].toUpperCase());
            strum.animation.addByPrefix('pressed', ["left", "down", "up", "right"][strum.ID] + ' press', 24, false);
            strum.animation.addByPrefix('confirm', ["left", "down", "up", "right"][strum.ID] + ' confirm', 24, false);

            strum.animation.play('static');
            strum.updateHitbox();
        }
    }