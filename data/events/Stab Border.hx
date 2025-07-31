function onPsychEvent(n, v1, v2)
    if (n == 'Stab Border') {
        var val1:Float = Std.parseFloat(v1);
		if (Math.isNaN(val1)) val1 = 0.5;
        
		FlxTween.cancelTweensOf(screenPulse);
		screenPulse.alpha = 1;
		FlxTween.tween(screenPulse, {alpha: 0.001}, val1, {ease: FlxEase.circOut});
    }