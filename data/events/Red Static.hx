function onPsychEvent(n, v1, v2)
    if (n == 'Red Static') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);

		FlxTween.cancelTweensOf(redStatic);
		if (Math.isNaN(val1)) val1 = 0;
		if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
		
		trace(val1 + ' & ' + val2);

		if (val2 != 0)
			FlxTween.tween(redStatic, {alpha: val1}, val2, {ease: FlxEase.linear});
    }