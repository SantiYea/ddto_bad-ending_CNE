function onPsychEvent(n, v1, v2)
    if (n == 'Tween in the holy light') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);
		if (Math.isNaN(val1)) val1 = 1;
		if (Math.isNaN(val2)) val1 = 0.1;

		FlxTween.cancelTweensOf(holylight);
		FlxTween.tween(holylight, {alpha: val1}, val2, {ease: FlxEase.linear});
    }