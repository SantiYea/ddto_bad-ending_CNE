public var events = {
    time: [],
    event: [],
    value1: [],
    value2: [],
    value3: []
};
var file:Dynamic;
public var allowTracing:Bool = false; // ofc for checking purposes and not using resources.
public var isCameraOnForcedPos:Bool = false;

var songName:String = PlayState.instance.SONG.meta.name;
var diff:String = PlayState.instance.difficulty.toLowerCase();

function create() {
    if (Paths.getPath('songs/' + songName + '/events.json') != null)
        file = CoolUtil.parseJson(Paths.getPath('songs/' + songName + '/events.json')).song;
    else
        file = CoolUtil.parseJson(Paths.getPath('songs/' + songName + '/charts/' + diff + 'events.json')).song;

    for (event in file.events) {
		for (i in 0...event[1].length) {
            events.time.push(event[0]);
            events.event.push(event[1][i][0]);
            events.value1.push(event[1][i][1]);
            events.value2.push(event[1][i][2]);
            events.value3.push(event[1][i][3]); // failed to add a checker.
        }
    }

    loadEventScripts();
}

function checkEventNotes() {
    if (events.event.length > 0) {
        var strumTime:Float = events?.time[0];
        var eventName:String = events?.event[0];
        var values:Array<String> = [events?.value1[0], events?.value2[0], events?.value3[0]];

        if (strumTime <= Conductor.songPosition) {
            PsychEvent(eventName, values[0], values[1], values[2]);

            events.time.shift();
            events.event.shift();
            events.value1.shift();
            events.value2.shift();
            events.value3.shift();
        }
    }
}

var scriptsEvents:Array<String>;
var defaultEvents:Array<String> = [ // add ur default events here so the function below doesnt search it as a script.
    'Hey', 'Set GF Speed', 'Add Camera Zoom', 'Screen Shake',
    'Play Animation', 'Change Scroll Speed', 'Camera Follow Pos'
];

function loadEventScripts() {
    var scriptsForLoad:Array<String> = [];
    var beforeAdd:Array<String> = [];
    var currentEvents:Array<String> = events?.event;

    var scriptsForLogs = [];
    var scriptsNotFound = [];

    for (i in currentEvents) 
        if (!defaultEvents.contains(i))
            beforeAdd.push(i);

    for (i in beforeAdd)
        if (!scriptsForLoad.contains(i))
            scriptsForLoad.push(i);
    
    scriptsEvents = scriptsForLoad;

    for (load in scriptsEvents)
        if (Assets.exists(Paths.getPath('data/events/' + load + '.hx'))) {
            importScript('data/events/' + load);
            scriptsForLogs.push(load);
        }
        else
            scriptsNotFound.push(load);

    if (allowTracing) {
        trace('- Scripts Events Loaded: ' + scriptsForLogs);
        trace('- Scripts Not Loaded/Found: ' + scriptsNotFound);
    }
}

function postUpdate(dt) checkEventNotes();

var songSpeedTween:FlxTween;

public function PsychEvent(name:String, v1:String, v2:String, ?v3:String) {
    var flv1:Null<Float> = Std.parseFloat(v1);
    var flv2:Null<Float> = Std.parseFloat(v2);
    if(Math.isNaN(flv1)) flv1 = null;
	if(Math.isNaN(flv2)) flv2 = null;
    if (allowTracing) trace('calling: ' + name);

    switch(name) {
        case 'Hey':
            var value:Int = 2;
            if(flv2 == null || flv2 <= 0) flv2 = 0.6;

            switch(v1) {
                case 'bf' | 'boyfriend' | 'player' | '0': value = 0;
                case 'gf' | 'girlfriend' | 'speaker' | '1': value = 1;
            }

            if(value != 0) {
				if(dad.curCharacter.startsWith('gf')) {
					dad.playAnim('cheer', true);
					dad.lastHit = flv2;
				}
                else if (gf != null) {
					gf.playAnim('cheer', true);
					gf.specialAnim = true;
					gf.lastHit = flv2;
				}
			}

			if(value != 1) {
				boyfriend.playAnim('hey', true);
				boyfriend.lastHit = flv2;
            }

        case 'Set GF Speed':
            if(flv1 == null || flv1 < 1) flv1 = 1;
            gfSpeed = Math.round(flv1);

        case 'Add Camera Zoom':
            if (Options.camZoomOnBeat && FlxG.camera.zoom < 1.35) {
                if(flv1 == null) flv1 = 0.015;
				if(flv2 == null) flv2 = 0.03;

                FlxG.camera.zoom += flv1;
				camHUD.zoom += flv2;
            }
        case 'Screen Shake':
			var valuesArray = [v1, v2];
			var targetsArray = [camGame, camHUD];

			for (i in 0...targetsArray.length) {
				var split:Array<String> = valuesArray[i].split(',');
				var duration:Float = 0;
				var intensity:Float = 0;

				if(split[0] != null) duration = Std.parseFloat(StringTools.trim(duration));
				if(split[1] != null) intensity = Std.parseFloat(StringTools.trim(intensity));
				if(Math.isNaN(duration)) duration = 0;
				if(Math.isNaN(intensity)) intensity = 0;

				if(duration > 0 && intensity != 0) 
					targetsArray[i].shake(intensity, duration);
			}
        case 'Play Animation':
			var char:Character = dad;

			switch(v2.toLowerCase()) {
				case 'bf' | 'boyfriend': char = boyfriend;
				case 'gf' | 'girlfriend': char = gf;
				default:
					if(flv2 == null) flv2 = 0;
					switch(Math.round(flv2)) {
						case 1: char = boyfriend;
						case 2: char = gf;
					}
			}

			if (char != null)
				char.playAnim(v1, true);
        
        case 'Change Scroll Speed':
            if (Math.isNaN(flv1)) flv1 = 1;
            if (Math.isNaN(flv2)) flv2 = 0;

            var newValue:Float = PlayState.instance.SONG.scrollSpeed * flv1;
            if (flv2 <= 0)
                scrollSpeed = newValue;
            else
                songSpeedTween = FlxTween.tween(this, {scrollSpeed: newValue}, flv2, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						songSpeedTween = null;
					}
				});
        case 'Camera Follow Pos':
            if(camFollow != null) {
				isCameraOnForcedPos = false;

				if(flv1 != null || flv2 != null)
				{
					isCameraOnForcedPos = true;
					if(flv1 == null) flv1 = 0;
					if(flv2 == null) flv2 = 0;
					camFollow.x = flv1;
					camFollow.y = flv2;
				}
			}

        default:
            // if no event exist from the defaults one, calls from scripts
            if (scriptsEvents.contains(name))
                scripts.call('onPsychEvent', [name, v1, v2, v3]);
    }
}

function onCameraMove(_) if (isCameraOnForcedPos && !_.cancelled) _.position.set(camFollow.x, camFollow.y);