function onPsychEvent(name, value1, value2) {
    if (name == 'Screen in Darkness') {
        if (darkoverlay != null) {
            var val1:Float = Std.parseFloat(value1);
			var val2:Float = Std.parseFloat(value2);
			
			if (Math.isNaN(val1) || val1 == 0) val1 = 0.0001;
			if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
			if (val1 >= 1) val1 = 1;
					
			FlxTween.cancelTweensOf(darkoverlay);
			FlxTween.tween(darkoverlay, {alpha: val1}, val2, {ease: FlxEase.linear});
        }
    }
}