function onPsychEvent(n, v1, v2)
    if (n == 'Summon Sayori or Yuri') {
        var char:Character = sayori;
		var val2:Float = Std.parseFloat(v2);

		switch (v1) {
			case 'sayori' | 'sayo' | 'Sayori': char = sayori;
			case 'yuri' | 'Yuri': char = yuri;
		}

		if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
		FlxTween.tween(char, {alpha: 1}, val2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){}});
    }