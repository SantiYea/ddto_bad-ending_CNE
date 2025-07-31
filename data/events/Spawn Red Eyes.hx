function onPsychEvent(n, v1, v2)
    if (n == 'Spawn Red Eyes') {
        if (funnyEyes != null) {
			switch (StringTools.trim(v1).toLowerCase()) {
				default:
					funnyEyes.alpha = 1;
                    funnyEyes.animation.play('Midway');
					FlxG.camera.flash(FlxColor.RED, 0.5);
				case 'fadeout':
					var val2:Float = Std.parseFloat(v2);
					if (Math.isNaN(val2)) val2 = 1;
					FlxTween.tween(funnyEyes, {alpha: 0.001}, val2, {ease: FlxEase.circOut});
			}
		}
    }