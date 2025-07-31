function onPsychEvent(name, v1, v2) {
    if (name == 'Change Camera Zoom') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);

        if (Math.isNaN(val1))
	        val1 = defaultStageZoom;

        if (Math.isNaN(val2)) {
            var forceBool:Bool = false;
            if (v2 == 'true')
                forceBool = true;
    
            defaultCamZoom = val1;
            if (forceBool)
                FlxG.camera.zoom = val1;
        }
        else {
            FlxTween.tween(FlxG.camera, {zoom: val1}, val2, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween)
                {
                    defaultCamZoom = val1;
                }
            });
        }
    }
}