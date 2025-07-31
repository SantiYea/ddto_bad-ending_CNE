function onPsychEvent(name, v1, v2, v3)
    if (name == 'Strumline Visibility') {
        var val2:Float = Std.parseFloat(v2);
		var val3:Float = Std.parseFloat(v3);
        var includedBlood:Bool = false;
        var strum = switch(v1) {
            case 'dad' | 'opponent': cpu;
            default: player;
        }

        if (v1 == 'dad' || v1 == 'opponent') {
            if (curSong == 'markov') if (bloodDrips) includedBlood = true;
            if (FlxG.save.data.SANTIYEA_ddto_middlescroll) val2 *= 0.35;
        }

        if (Math.isNaN(val2)) val2 = 1;
		else if (val2 == 0) val2 = 0.0001;
		if (Math.isNaN(val3) || val3 <= 0) val3 = 0.01;
		trace(v1 + ' & ' + v2 + ' & ' + v3);

        // how the notes are something separated to the strum, this
        for (setStrum in strum) {
            FlxTween.cancelTweensOf(setStrum);
            FlxTween.tween(setStrum, {alpha: val2}, val3, {ease: FlxEase.circOut});
        }
        for (setNotes in strum.notes) {
            FlxTween.cancelTweensOf(setNotes);
            FlxTween.tween(setNotes, {alpha: val2}, val3, {ease: FlxEase.circOut});
        }

        if (includedBlood)
            for (blood in bloodStrums) {
                FlxTween.cancelTweensOf(blood);
				FlxTween.tween(blood, {alpha: val2}, val3, {ease: FlxEase.circOut});
            }
    }