import flixel.addons.display.FlxBackdrop;

defaultCamZoom = 0.75;
public var defaultStageZoom:Float = defaultCamZoom;
FlxTween.tween(FlxG.camera, {zoom: defaultStageZoom}, 0.0001);

public var abStage:String = 'home';

public var stageStatic:FunkinSprite;
public var bakaOverlay:FunkinSprite;
public var evilPoem:FunkinSprite;
public var evilClubBGScribbly:FunkinSprite;

public var bgwindo:FlxBackdrop;
public var bgwindo2:FlxBackdrop;
public var evilSpace:FlxBackdrop;
public var clouds:FlxBackdrop;
public var fancyclouds:FlxBackdrop;

public var inthenotepad:FlxSprite;
public var notepadoverlay:FlxSprite;
public var closet:FlxSprite;
public var clubroom:FlxSprite;
public var evilClubBG:FlxSprite;
public var clubroomdark:FlxSprite;
public var windowlight:FlxSprite;
public var glitchback:FlxSprite;
public var ruinedClubBG:FlxSprite;
public var glitchfront:FlxSprite;
public var deskfront:FlxSprite;

public var sayori:Character;
public var yuri:Character;

static function addWTF(spr:Dynamic)
	if (spr != null) {
		spr.antialiasing = Options.antialiasing;
		insert(members.indexOf(gf), spr);
		// for some reason when i was using `addSpr()`, the layering of some sprites it was incorrect
		// so temp. fix maybe
	}

function create() {
	boyfriend.setPosition(770, 100);
	gf.setPosition(320, 130);
	dad.setPosition(100, 100);

	precacheCharacter(2, 'gf-markov');
	for (natPrecache in ['natsuki-sad', 'natsuki-home'])
		precacheCharacter(0, natPrecache);
	for (bfPrecache in ['sadbf', 'bf-home', 'bfpoem'])
		precacheCharacter(1, bfPrecache);

    stageStatic = new FunkinSprite();
    stageStatic.loadSprite(Paths.image('doki/ruinedclub/HomeStatic'));
    stageStatic.addAnim('HomeStatic', 'HomeStatic', 24, true);
    stageStatic.playAnim('HomeStatic');
    stageStatic.scrollFactor.set(0, 0);
    stageStatic.screenCenter();
    stageStatic.y = -140;
    stageStatic.visible = false;
    addWTF(stageStatic);

    if (!Options.lowMemoryMode) {
        bgwindo = new FlxBackdrop(Paths.image('doki/ruinedclub/bgwindows2'));
		bgwindo.velocity.set(-40, 0);
		bgwindo.scrollFactor.set(0.5, 0.5);
		addWTF(bgwindo);

        bgwindo2 = new FlxBackdrop(Paths.image('doki/ruinedclub/bgwindows'));
		bgwindo2.velocity.set(-60, 0);
		bgwindo2.scrollFactor.set(0.8, 0.8);
		addWTF(bgwindo2);

		evilSpace = new FlxBackdrop(Paths.image('doki/bigmonika/Sky'));
		evilSpace.scrollFactor.set(0.1, 0.1);
		evilSpace.velocity.set(-10, 0);
		evilSpace.y -= 300;
		addWTF(evilSpace);

		clouds = new FlxBackdrop(Paths.image('doki/bigmonika/Clouds'));
		clouds.scrollFactor.set(0.1, 0.1);
		clouds.velocity.set(-13, 0);
		clouds.y -= 300;
		clouds.scale.set(0.7, 0.7);
		addWTF(clouds);

		fancyclouds = new FlxBackdrop(Paths.image('doki/bigmonika/mask'));
		fancyclouds.scrollFactor.set(0.1, 0.1);
		fancyclouds.velocity.set(-13, 0);
		fancyclouds.y -= 300;
		fancyclouds.scale.set(0.7, 0.7);
		addWTF(fancyclouds);
    }

    bakaOverlay = new FunkinSprite();
    bakaOverlay.loadSprite(Paths.image('doki/BakaBGDoodles'));
    bakaOverlay.addAnim('idle', 'Normal Overlay', 24, true);
	bakaOverlay.addAnim('hueh', 'HOME Overlay', 24, false);
	bakaOverlay.playAnim('idle');
	bakaOverlay.visible = true;
	bakaOverlay.alpha = 0.0001;
	bakaOverlay.camera = camHUD;
	bakaOverlay.setGraphicSize(Std.int(FlxG.width));
	bakaOverlay.updateHitbox();
	bakaOverlay.screenCenter();
	addToCam(bakaOverlay);

    inthenotepad = new FlxSprite().loadGraphic(Paths.image('doki/notepad'));
    inthenotepad.visible = false;
    addWTF(inthenotepad);

    closet = new FlxSprite(-700, -520, Paths.image('doki/homeCR/DDLCfarbg'));
    closet.scrollFactor.set(0.9, 0.9);
	closet.setGraphicSize(Std.int(closet.width * 1.6));
	closet.updateHitbox();
	addWTF(closet);

    clubroom = new FlxSprite(-700, -520, Paths.image('doki/homeCR/DDLCbg'));
    clubroom.scrollFactor.y = 0.9;
	clubroom.setGraphicSize(Std.int(clubroom.width * 1.6));
	clubroom.updateHitbox();
	addWTF(clubroom);

	evilClubBG = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/BG'));
	evilClubBG.setGraphicSize(Std.int(evilClubBG.width * 1.3));
	evilClubBG.visible = false;
	addWTF(evilClubBG);

	if (!Options.lowMemoryMode) {
		windowlight = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/WindowLight'));
		windowlight.setGraphicSize(Std.int(windowlight.width * 1.3));
		windowlight.visible = false;
		addWTF(windowlight);
	}

	evilPoem = new FunkinSprite(-220, -110, Paths.image('doki/PaperBG'));
	evilPoem.addAnim('idle', 'PaperBG', 24, true);
	evilPoem.playAnim('idle');
	evilPoem.setGraphicSize(Std.int(evilPoem.width * 1.3));
	evilPoem.visible = false;
	addWTF(evilPoem);

	glitchback = new FlxSprite(-220, -110, Paths.image('doki/ruinedclub/glitchback1'));
	glitchback.setGraphicSize(Std.int(glitchback.width * 1.3));
	glitchback.scrollFactor.x = 0.6;
	glitchback.visible = false;
	addWTF(glitchback);

	ruinedClubBG = new FlxSprite(-220, -110, Paths.image('doki/ruinedclub/BG'));
	ruinedClubBG.setGraphicSize(Std.int(ruinedClubBG.width * 1.3));
	ruinedClubBG.visible = false;
	addWTF(ruinedClubBG);

	evilClubBGScribbly = new FunkinSprite(-220, -110, Paths.image('doki/BGsketch'));
    evilClubBGScribbly.addAnim('idle', 'BGSketch', 24, true);
    evilClubBGScribbly.playAnim('idle');
	evilClubBGScribbly.setGraphicSize(Std.int(evilClubBGScribbly.width * 1.3));
	evilClubBGScribbly.visible = false;
	evilClubBGScribbly.alpha = 0;
	addWTF(evilClubBGScribbly);
}

function postCreate() {
    notepadoverlay = new FlxSprite().loadGraphic(Paths.image('doki/notepad_overlay'));
    notepadoverlay.visible = false;
    add(notepadoverlay);

	clubroomdark = new FlxSprite(-220, -110, Paths.image('doki/bigmonika/shadow'));
	clubroomdark.setGraphicSize(Std.int(clubroomdark.width * 1.3));
	clubroomdark.visible = false;
	add(clubroomdark);

	glitchfront = new FlxSprite(-220, -110, Paths.image('doki/ruinedclub/glitchfront1'));
	glitchfront.setGraphicSize(Std.int(glitchfront.width * 1.3));
	glitchfront.scrollFactor.x = 1.2;
	glitchfront.visible = false;
	add(glitchfront);

	deskfront = new FlxSprite(-700, -520, Paths.image('doki/homeCR/DesksFront'));
    deskfront.setGraphicSize(Std.int(deskfront.width * 1.6));
    deskfront.updateHitbox();
    deskfront.scrollFactor.set(1.3, 0.9);
	add(deskfront);

	sayori = new Character(-150, 70, 'sil_sayori');
	yuri = new Character(1050, 10, 'sil_yuri');
	insert(members.indexOf(gf) - 1, sayori);
	insert(members.indexOf(gf) - 1, yuri);

	sayori.alpha = yuri.alpha = 0.0001;
	sayori.color = yuri.color = FlxColor.GRAY;
    for (i in [boyfriend, gf, dad]) i.color = FlxColor.BLACK;
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

function onSongEnd()
	if (PlayState.instance.isStoryMode && !FlxG.save.data.SANTIYEA_finished_storyMode) {
		FlxG.save.data.SANTIYEA_finished_storyMode = true;
		trace('The Story Mode Was Completed?: ' + FlxG.save.data.SANTIYEA_finished_storyMode);
		if (FlxG.save.data.SANTIYEA_finished_storyMode) trace('Unlocked Freelay! + Unfair Mode');
	}