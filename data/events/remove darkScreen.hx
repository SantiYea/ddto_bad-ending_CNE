function onPsychEvent(name, value1, value2) {
    if (name == 'remove darkScreen') {
        if (darkScreen != null) {
            var val1:Float = Std.parseFloat(value1);
			var val2:Float = Std.parseFloat(value2);
			
			if (Math.isNaN(val1) || val1 == 0) val1 = 0.0001;
			if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
			if (val1 != 0) FlxTween.tween(darkScreen, {alpha: val2}, val1, {ease: FlxEase.linear});
        }
    }
}