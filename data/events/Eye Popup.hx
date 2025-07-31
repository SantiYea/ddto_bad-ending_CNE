graphicCache.cache(Paths.image('doki/MarkovEyes'));

function onPsychEvent(name, v1, v2)
    if (name == 'Eye Popup') {
        var val1:Float = Std.parseFloat(v1);
		var val2:Float = Std.parseFloat(v2);

        var eye:FunkinSprite = new FunkinSprite(val1, val2, Paths.image('doki/MarkovEyes'));
        eye.addAnim('pito', 'MarkovWindow', 24, false);
        eye.playAnim('pito');
        eye.antialiasing = Options.antialiasing;
        eye.scrollFactor.set();
        eye.camera = camHUD;
        insert(members.indexOf(accuracyTxt) + 1, eye);

        new FlxTimer().start(4.61, function(tmr:FlxTimer) {
			remove(eye);
			eye.destroy();
		});
    }