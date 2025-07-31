import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.utils.DiscordUtil;

#if mobile
import funkin.mobile.controls.FlxDPadMode;
import funkin.mobile.controls.FlxActionMode;
#end

var curSelected:Int = 1; //default selected stagnant
var curDifficulty:Int = 0;
var selected:Bool = false;
var allowUser:Bool = true;

var difficultys:Array<String> = ['hard', 'unfair'];
var songs:Array<String> = ['markov', 'stagnant', 'home'];

var bg:FlxSprite;
var unfairBg:FunkinSprite;
var redoverlay:FunkinSprite;
var dokis:FlxTypedGroup<FunkinSprite> = new FlxTypedGroup();

var displaySong:FlxText;
var diffTxt:FlxText;

function create() {
    var AnimalFont = Paths.font('VTKS_ANIMAL_2.ttf');
    CoolUtil.playMenuSong();
    DiscordUtil.changePresence('Selecting My Destiny', "DDTO Bad Ending - [Freeplay]");

    var evilSpace:FlxBackdrop = new FlxBackdrop(Paths.image('doki/bigmonika/Sky'));
	evilSpace.velocity.set(-10, 0);
	evilSpace.antialiasing = Options.antialiasing;
	add(evilSpace);

    bg = new FlxSprite(-239, -3, Paths.image('doki/bigmonika/BG'));
	bg.antialiasing = Options.antialiasing;
	add(bg);

    unfairBg = new FunkinSprite();
    unfairBg.loadSprite(Paths.image('doki/ruinedclub/HomeStatic'));
    unfairBg.addAnim('idle', 'HomeStatic', 24, true);
    unfairBg.playAnim('idle');
    unfairBg.alpha = 0.0001;
    add(unfairBg);

    var chars = ['nat', 'yuri', 'sayo'];
    add(dokis);
    for (i in 0...3) {
        var doki:FunkinSprite = new FunkinSprite([37, 177, 107][i], 0, Paths.image('freeplay/' + chars[i] + '_sheet'));
        doki.addAnim('hard', 'normal', 0, false);
        doki.addAnim('unfair', 'unfair', 0, false);
        doki.playAnim(difficultys[curDifficulty]);
        doki.antialiasing = Options.antialiasing;
        dokis.add(doki);
    }

    var vignette:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuvignette'));
	vignette.alpha = 0.6;
	add(vignette);

    redoverlay = new FunkinSprite();
    redoverlay.loadSprite(Paths.image('doki/ruinedclub/HomeStatic'));
    redoverlay.addAnim('idle', 'HomeStatic', 24, true);
    redoverlay.playAnim('idle');
    redoverlay.alpha = 0.0001;
    add(redoverlay);

    displaySong = new FlxText(0, 550, 0, '', 50);
	displaySong.screenCenter(FlxAxes.X);
	displaySong.font = AnimalFont;
	displaySong.color = 0xFFFFFFFF;
	displaySong.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3, 1);
	displaySong.antialiasing = true;
	add(displaySong);

    diffTxt = new FlxText(0, 600, 1280, '', 72);
	diffTxt.font = AnimalFont;
	diffTxt.color = 0xFFFFFFFF;
	diffTxt.alignment = 'center';
	diffTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3, 1);
	diffTxt.antialiasing = true;
	diffTxt.visible = false;
	diffTxt.screenCenter(FlxAxes.X);
	add(diffTxt);

    change(0, true);
    
    #if mobile
	addVPad(FlxDPadMode.LEFT_RIGHT, FlxActionMode.A_B);
	addVPadCamera();
	vPad.visible = true;
	#end
}

function update(dt) {
    if (allowUser) {
        if (!selected) change((controls.LEFT_P ? -1 : 0) + (controls.RIGHT_P ? 1 : 0));
        else SWAP((controls.LEFT_P ? -1 : 0) + (controls.RIGHT_P ? 1 : 0));

        if (controls.ACCEPT) {
            if (selected) startSong();
            else prepareSong();
        }

        if (controls.BACK) {
            if (selected) {
                CoolUtil.playMenuSFX(2);
                selected = diffTxt.visible = false;
            }
            else {
                allowUser = !allowUser;
                FlxG.switchState(new ModState('menu'));
            }
        }
    }
}

function SWAP(i:Int, f:Bool = false) {
    if (i == 0 && !f) return;
    CoolUtil.playMenuSFX(0);
    curDifficulty = FlxMath.wrap(curDifficulty + i, 0, difficultys.length - 1);
    diffTxt.text = '< ' + difficultys[curDifficulty] + ' >';

    redoverlay.alpha = 0.7;
	FlxTween.cancelTweensOf(redoverlay);
	FlxTween.tween(redoverlay, {alpha: 0.0001}, 0.25);
    unfairBg.alpha = difficultys[curDifficulty] == 'unfair' ? 1 : 0.001;
    for (transform in dokis)
        transform.playAnim(difficultys[curDifficulty], true);
}

function prepareSong() {
    CoolUtil.playMenuSFX(1);
    redoverlay.alpha = 0.7;
	FlxTween.cancelTweensOf(redoverlay);
	FlxTween.tween(redoverlay, {alpha: 0.0001}, 0.25);
    diffTxt.visible = true;
    diffTxt.text = '< ' + difficultys[curDifficulty] + ' >';
    selected = true;
}

function startSong() {
    allowUser = !allowUser;
    FlxG.camera.fade(FlxColor.BLACK, 0.7, false, function() {
        PlayState.loadSong(songs[curSelected], difficultys[curDifficulty]);
        FlxG.switchState(new PlayState());
    });
}

function change(i:Int, f:Bool = false) {
    if (i == 0 && !f) return;
    CoolUtil.playMenuSFX(0);
    curSelected = FlxMath.wrap(curSelected + i, 0, songs.length - 1);

    displaySong.text = songs[curSelected].toLowerCase();
	displaySong.screenCenter(FlxAxes.X);

    var sayori = dokis.members[2];
    var yuri = dokis.members[1];
    var natsuki = dokis.members[0];

    if (sayori != null) FlxTween.cancelTweensOf(sayori);
    if (yuri != null) FlxTween.cancelTweensOf(yuri);
    if (natsuki != null) FlxTween.cancelTweensOf(natsuki);

    switch(songs[curSelected]) {
        case 'markov':
            FlxTween.tween(yuri, {x: 107}, 0.25);
            FlxTween.color(yuri, 0.25, yuri.color, 0xFFffffff);

            FlxTween.tween(natsuki, {x: 37}, 0.25);
            FlxTween.color(natsuki, 0.25, natsuki.color, 0xFF444444);
            FlxTween.color(sayori, 0.25, sayori.color, 0xFF444444);

        case 'stagnant':
            FlxTween.color(sayori, 0.25, sayori.color, 0xFFffffff);

            FlxTween.tween(yuri, {x: 177}, 0.25);
            FlxTween.color(yuri, 0.25, yuri.color, 0xFF444444);
            FlxTween.tween(natsuki, {x: 37}, 0.25);
            FlxTween.color(natsuki, 0.25, natsuki.color, 0xFF444444);

        case 'home':
            FlxTween.tween(natsuki, {x: 107}, 0.25);
            FlxTween.color(natsuki, 0.25, natsuki.color, 0xFFffffff);

            FlxTween.tween(yuri, {x: 177}, 0.25);
            FlxTween.color(yuri, 0.25, yuri.color, 0xFF444444);
            FlxTween.color(sayori, 0.25, sayori.color, 0xFF444444);
    }
}