var shader:CustomShader = new CustomShader('static');

function create() {
    if (Options.gameplayShaders) {
        shader.alphaStat = 0.0;
        camGame.addShader(shader);
        camGame.filtersEnabled = false;
    }
}

var iTime:Float = 0;

function update(dt) {
    if (shader != null && Options.gameplayShaders && camGame.filtersEnabled)
        iTime += dt;
        shader.iTime = iTime;
}

function funnyGlitch(duration:Float, sound:String) {
	if (sound.length > 0)
		FlxG.sound.play(Paths.sound(sound));
	if (!Options.gameplayShaders || duration <= 0)
		return;
	camGame.filtersEnabled = true;
	new FlxTimer().start(duration, () -> camGame.filtersEnabled = false);
}

function onPsychEvent(name, v1, v2)
    if (name == 'Glitch Effect') {
        var val1:Float = Std.parseFloat(v1);
		if (Math.isNaN(val1)) val1 = 0.5;

		funnyGlitch(val1, v2);
    }