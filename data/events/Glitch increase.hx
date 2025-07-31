function onPsychEvent(n, v1, v2)
    if (n == 'Glitch increase') {
        switch (Std.parseFloat(v1)) {
			case 1: FlxTween.tween(daStatic, {alpha: 0.65}, 3.5, {ease: FlxEase.circOut});
			case 2:
				FlxTween.cancelTweensOf(daStatic);
				daStatic.visible = false;
			case 3:
				FlxTween.cancelTweensOf(daStatic);
				daStatic.visible = true;
			case 4:
				FlxTween.cancelTweensOf(daStatic);
				remove(daStatic);
		}
    }