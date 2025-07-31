function onPsychEvent(n, v1, v2)
    if (n == 'Show death screen') {
        var val1:Float = Std.parseFloat(v1);
        var val2:Float = Std.parseFloat(v2);

        if (v1 == null || v1 == 'false') val1 = 0.00001;
        if (Math.isNaN(val2) || val2 == 0) val2 = 0.0001;
        camZooming = false;
        camZoomingStrength = 0;
        camZoomingInterval = 0;

        FlxTween.tween(imdead, {alpha: val1}, val2, {ease: FlxEase.linear});
        FlxTween.tween(cambgwindo, {alpha: val1}, val2, {ease: FlxEase.linear});
        FlxTween.tween(cambgwindo2, {alpha: val1}, val2, {ease: FlxEase.linear});
    }