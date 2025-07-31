function onPsychEvent(n, v1, v2, v3)
    if (n == 'Move Boyfriend Tween') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);
		var val3:Float = Std.parseFloat(v3);

		if (Math.isNaN(val3) || val3 == 0) val3 = 0.0001;
		if (Math.isNaN(val1)) val1 = defXY.bf[0];
		if (Math.isNaN(val2)) val2 = defXY.bf[1];

		FlxTween.cancelTweensOf(boyfriend);
		FlxTween.tween(boyfriend, {x: val1, y: val2}, val3, {ease: FlxEase.circOut});
    }