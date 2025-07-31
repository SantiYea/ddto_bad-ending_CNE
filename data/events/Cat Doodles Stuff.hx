function onPsychEvent(n, v1, v2, v3)
    if (n == 'Cat Doodles Stuff') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);

		if (Math.isNaN(val1) || val1 == 0) val1 = 0.00001;
		if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
		if (v3 == null || v3 == '') FlxTween.tween(bakaOverlay, {alpha: val1}, val2, {ease: FlxEase.linear});

		if (v3 != null && v3 != '') {
			bakaOverlay.animation.play('hueh');
            new FlxTimer().start(4, (_) -> bakaOverlay.alpha = 0);
		}
    }