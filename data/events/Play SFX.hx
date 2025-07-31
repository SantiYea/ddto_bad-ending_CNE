function onPsychEvent(name, v1, v2)
    if (name == 'Play SFX') {
        var val2:Float = Std.parseFloat(v2);
		if (Math.isNaN(val2)) val2 = 1;
		FlxG.sound.play(Paths.sound(v1), val2);
    }