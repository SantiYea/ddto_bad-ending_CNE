import flixel.addons.display.FlxBackdrop;

defaultCamZoom = 0.75;
public var defaultStageZoom:Float = defaultCamZoom;
public var abStage:String = 'stagnant';
FlxTween.tween(FlxG.camera, {zoom: defaultStageZoom}, 0.0001);

public var closet:FlxSprite;
public var clubroom:FlxSprite;
public var deskfront:FlxSprite;

public var evilSpace:FlxBackdrop;
public var clouds:FlxBackdrop;
public var fancyclouds:FlxBackdrop;

public var evilClubBG:FlxSprite;
public var clubroomdark:FlxSprite;
public var windowlight:FlxSprite;

public var evilClubBGScribbly:FunkinSprite;
public var evilPoem:FunkinSprite;
public var poemTransition:FunkinSprite;

function create() {
    precacheCharacter(0, 'sadsayo');
    precacheCharacter(0, 'sayopoem');
    precacheCharacter(1, 'sadbf');
    precacheCharacter(1, 'bfpoem');

    closet = new FlxSprite(-700, -520, Paths.image('doki/clubroom/DDLCfarbg'));
    closet.setGraphicSize(Std.int(closet.width * 1.6));
	closet.updateHitbox();
    closet.scrollFactor.set(0.9, 0.9);
    addSpr(closet);

    clubroom = new FlxSprite(-700, -520, Paths.image('doki/clubroom/DDLCbg'));
    clubroom.setGraphicSize(Std.int(clubroom.width * 1.6));
    clubroom.updateHitbox();
    clubroom.scrollFactor.y = 0.9;
    addSpr(clubroom);

    if (!Options.lowMemoryMode) {
        deskfront = new FlxSprite(-700, -520, Paths.image('doki/clubroom/DesksFront'));
        deskfront.setGraphicSize(Std.int(deskfront.width * 1.6));
        deskfront.updateHitbox();
        deskfront.scrollFactor.set(1.3, 0.9);

        evilSpace = new FlxBackdrop(Paths.image('doki/bigmonika/Sky'));
		evilSpace.scrollFactor.set(0.1, 0.1);
		evilSpace.velocity.set(-10, 0);
		evilSpace.y -= 300;
		evilSpace.visible = false;
		addSpr(evilSpace);

        clouds = new FlxBackdrop(Paths.image('doki/bigmonika/Clouds'));
		clouds.scrollFactor.set(0.1, 0.1);
		clouds.velocity.set(-13, 0);
		clouds.y -= 300;
		clouds.scale.set(0.7, 0.7);
		clouds.visible = false;
		addSpr(clouds);

		fancyclouds = new FlxBackdrop(Paths.image('doki/bigmonika/mask'));
		fancyclouds.scrollFactor.set(0.1, 0.1);
		fancyclouds.velocity.set(-13, 0);
		fancyclouds.y -= 300;
		fancyclouds.scale.set(0.7, 0.7);
		fancyclouds.alpha = 1;
		fancyclouds.visible = false;
		addSpr(fancyclouds);
    }

    evilClubBG = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/BG'));
	evilClubBG.setGraphicSize(Std.int(evilClubBG.width * 1.3));
	evilClubBG.visible = false;
	addSpr(evilClubBG);

    if (!Options.lowMemoryMode) {
        clubroomdark = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/shadow'));
		clubroomdark.visible = false;
		clubroomdark.setGraphicSize(Std.int(clubroomdark.width * 1.3));

		windowlight = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/WindowLight'));
		windowlight.visible = false;
		windowlight.setGraphicSize(Std.int(windowlight.width * 1.3));
		addSpr(windowlight);
    }

    evilClubBGScribbly = new FunkinSprite(-220, -110, Paths.image('doki/BGsketch'));
    evilClubBGScribbly.addAnim('idle', 'BGSketch', 24, true);
    evilClubBGScribbly.playAnim('idle');
	evilClubBGScribbly.setGraphicSize(Std.int(evilClubBGScribbly.width * 1.3));
	evilClubBGScribbly.visible = false;
	evilClubBGScribbly.alpha = 0.0001;
	addSpr(evilClubBGScribbly);

    evilPoem = new FunkinSprite(-220, -110, Paths.image('doki/PaperBG'));
    evilPoem.addAnim('idle', 'PaperBG', 24, true);
    evilPoem.playAnim('idle');
	evilPoem.setGraphicSize(Std.int(evilPoem.width * 1.3));
	evilPoem.visible = false;
	addSpr(evilPoem);

    poemTransition = new FunkinSprite(-220, -110, Paths.image('doki/PoemTransition'));
    poemTransition.addAnim('idle', 'poemtransition', 24, true);
    poemTransition.screenCenter();
	poemTransition.visible = false;
    poemTransition.camera = camHUD;
	addToCam(poemTransition);
}

function postCreate() {
    add(deskfront);
    add(clubroomdark);
}

function onNoteCreation(e){
    var step = Conductor.getStepForTime(e.note.strumTime);
    var def = e.noteSprite;

    if(step >= 1312) e.noteSprite = 'poemUI/NOTE_assets';
    if(step >= 1824) e.noteSprite = def;
    if(step >= 2336) e.noteSprite = 'poemUI/NOTE_assets';
}

function onPostNoteCreation(e){
    var step = Conductor.getStepForTime(e.note.strumTime);
    var splashes = e.note;

    if(step >= 1312) splashes.splash = "poem";
    if(step >= 1824) splashes.splash = "default";
    if(step >= 2336) splashes.splash = "poem";
}

var floatshit:Float = 0;
function Frame():Float
{
	return  (1 / 60) / FlxG.elapsed;
}

function update(dt)
	if (!Options.lowMemoryMode && fancyclouds != null && fancyclouds.visible) {
		floatshit += 0.007 / Frame();
		fancyclouds.alpha += Math.sin(floatshit) / Frame() / 5;
		clubroomdark.alpha -= Math.sin(floatshit) / Frame() / 5;
		windowlight.alpha += Math.sin(floatshit) / Frame() / 5;
	}