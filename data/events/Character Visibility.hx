function onPsychEvent(name, v1, v2, v3)
    if (name == 'Character Visibility') {
        var charType:Int = 0;
		var val2:Float = Std.parseFloat(v2);
		var val3:Float = Std.parseFloat(v3);

		if (Math.isNaN(val2)) val2 = 1;
		else if (val2 == 0) val2 = 0.0001;

		if (Math.isNaN(val3) || val3 == 0 || val3 == null) val3 = 0.0001;

		if (v2 == 'true') val2 = 1;
		else if (v2 == 'false') val2 = 0.0001;
		
		trace(v1 + ' & ' + v2 + ' & ' + v3);
		switch(v1) {
			case 'gf' | 'girlfriend': charType = 2;
			case 'dad' | 'opponent': charType = 1;
			case 'bf' | 'boyfriend' | 'player': charType = 0;
			default:
				charType = Std.parseInt(v1);
				if (Math.isNaN(charType)) charType = 0;
		}

		switch (charType) {
			case 0:
				FlxTween.cancelTweensOf(boyfriend);
				FlxTween.tween(boyfriend, {alpha: val2}, val3, {ease: FlxEase.circOut});
			case 1:
				FlxTween.cancelTweensOf(dad);
				FlxTween.tween(dad, {alpha: val2}, val3, {ease: FlxEase.circOut});
			case 2:
				FlxTween.cancelTweensOf(gf);
				FlxTween.tween(gf, {alpha: val2}, val3, {ease: FlxEase.circOut});
		}
    }