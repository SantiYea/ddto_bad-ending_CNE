import flixel.addons.display.FlxBackdrop;

defaultCamZoom = 1;
public var defaultStageZoom:Float = defaultCamZoom;
public var abStage:String = 'markov';
FlxTween.tween(FlxG.camera, {zoom: defaultStageZoom}, 0.0001);

public var evilSpace:FlxBackdrop;
public var clouds:FlxBackdrop;
public var fancyclouds:FlxBackdrop;

public var evilClubBG:FlxSprite;
public var clubroomdark:FlxSprite;
public var windowlight:FlxSprite;

public var evilPoem:FlxSprite;
public var bloodyBG:FunkinSprite;

public var closetCloseUp:FlxSprite;
public var funnyEyes:FunkinSprite;
public var evilClubBGScribbly:FunkinSprite;

function create() {
    precacheCharacter(0, 'yuri-crazy');
    precacheCharacter(0, 'yuri-closeup');
    precacheCharacter(0, 'yuri-gore');
    precacheCharacter(2, 'gf-markov');

    if (!Options.lowMemoryMode) {
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
	evilClubBGScribbly.alpha = 0;
	addSpr(evilClubBGScribbly);

    evilPoem = new FlxSprite(-220, -110, Paths.image('doki/markovend'));
	evilPoem.setGraphicSize(Std.int(evilPoem.width * 1.3));
	evilPoem.visible = false;
	addSpr(evilPoem);

    bloodyBG = new FunkinSprite(-220, 0, Paths.image('doki/bgBlood'));
    bloodyBG.addAnim('bgBlood', 'bgBlood', 12, false);
	bloodyBG.setGraphicSize(Std.int(bloodyBG.width * 1.3));
	bloodyBG.alpha = 0.0001;
	addSpr(bloodyBG);

    closetCloseUp = new FlxSprite(-250, 0, Paths.image('doki/ClosetBG'));
	closetCloseUp.setGraphicSize(Std.int(closetCloseUp.width * 0.85));
    closetCloseUp.updateHitbox();
    closetCloseUp.visible = false;
	addSpr(closetCloseUp);

    funnyEyes = new FunkinSprite(-220, 0, Paths.image('doki/EyeMidwayBG'));
    funnyEyes.addAnim('Midway', 'Midway', 12, true);
	funnyEyes.setGraphicSize(Std.int(FlxG.width));
	funnyEyes.updateHitbox();
    funnyEyes.camera = camHUD;
	funnyEyes.screenCenter();
	funnyEyes.alpha = 0.0001;
	addToCam(funnyEyes);
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