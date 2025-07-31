import flixel.addons.display.FlxBackdrop;

public var darkoverlay:FlxSprite;
public var darkScreen:FlxSprite;
public var vignette:FlxSprite;

public var titleCard:FunkinSprite;
public var stagstatic:FunkinSprite;
public var daStatic:FunkinSprite;
public var redStatic:FunkinSprite;

public var screenPulse:FlxSprite;
public var holylight:FlxSprite;
public var imdead:FlxSprite;

public var cambgwindo:FlxBackdrop;
public var cambgwindo2:FlxBackdrop;

public var ChangeGameover:String = 'default';

public var defXY = {
	bf: [],
	gf: [],
	dad: []
};

var id:Int = 0;
public function addSpr(spr:Dynamic)
    if (spr != null) {
        spr.antialiasing = Options.antialiasing;
        insert(id++, spr);
    }

var idHud:Int = 0;
public function addToCam(spr:Dynamic)
    if (spr != null) {
        spr.antialiasing = Options.antialiasing;
        insert(idHud++, spr);
    }

function postCreate() {
    defXY.bf = [boyfriend.x, boyfriend.y];
	defXY.gf = [gf.x, gf.y];
	defXY.dad = [dad.x, dad.y];

    for (i in [scoreTxt, accuracyTxt, missesTxt]) {
        i.font = Paths.font('Aller_Rg.ttf');
        i.antialiasing = true;
        i.size = 20;
        i.borderSize = 1.25;
    }
    accuracyTxt.x -= 40;

    vignette = new FlxSprite(0, 0).loadGraphic(Paths.image('doki/vignette'));
	vignette.scrollFactor.set();
	vignette.camera = camHUD;
	vignette.alpha = 0.00001;
	addToCam(vignette);

    if (curSong == 'markov') {
        screenPulse = new FlxSprite().loadGraphic(Paths.image('doki/vignetteend'));
        screenPulse.camera = camHUD;
        screenPulse.setGraphicSize(FlxG.width, FlxG.height);
		screenPulse.screenCenter();
		screenPulse.alpha = 0.0001;
        addToCam(screenPulse);
    }

    if (curSong == 'stagnant') {
        daStatic = new FunkinSprite();
        daStatic.loadSprite(Paths.image('daSTAT'));
        daStatic.addAnim('idle', 'staticFLASH', 24, true);
        daStatic.playAnim('idle');
        daStatic.camera = camHUD;	
		daStatic.setGraphicSize(FlxG.width, FlxG.height);
		daStatic.screenCenter();
		daStatic.alpha = 0.0001;
		addToCam(daStatic);

        stagstatic = new FunkinSprite();
        stagstatic.loadSprite(Paths.image('doki/stagnant_glitch'));
        stagstatic.addAnim('idle', 'sadface 2', 24, false);
        stagstatic.setGraphicSize(FlxG.width, FlxG.height);
        stagstatic.screenCenter();
        stagstatic.alpha = 0.0001;
        stagstatic.camera = camHUD;
        addToCam(stagstatic);
    }

    if (curSong == 'home') {
        redStatic = new FunkinSprite();
        redStatic.loadSprite(Paths.image('doki/ruinedclub/HomeStatic'));
        redStatic.addAnim('idle', 'HomeStatic', 24, true);
        redStatic.playAnim('idle');
        redStatic.setGraphicSize(FlxG.width, FlxG.height);
        redStatic.screenCenter();
        redStatic.alpha = 0.0001;
        redStatic.camera = camHUD;
        addToCam(redStatic);

        cambgwindo = new FlxBackdrop(Paths.image('doki/ruinedclub/bgwindows2'));
		cambgwindo.velocity.set(-40, 0);
		cambgwindo.antialiasing = Options.antialiasing;
		cambgwindo.alpha = 0.0001;
		add(cambgwindo);

		cambgwindo2 = new FlxBackdrop(Paths.image('doki/ruinedclub/bgwindows'));
		cambgwindo2.velocity.set(-60, 0);
		cambgwindo2.antialiasing = Options.antialiasing;
		cambgwindo2.alpha = 0.0001;
		add(cambgwindo2);

        holylight = new FlxSprite().loadGraphic(Paths.image('doki/deadlight'));
        holylight.camera = camHUD;
        holylight.setGraphicSize(FlxG.width, FlxG.height);
		holylight.screenCenter();
		holylight.alpha = 0.0001;
        addToCam(holylight);

        imdead = new FlxSprite().loadGraphic(Paths.image('doki/everyoneisdead'));
		imdead.scrollFactor.set();
		imdead.camera = camHUD;
		imdead.alpha = 0.00001;
		addToCam(imdead);
    }

    darkoverlay = new FlxSprite(-FlxG.width * FlxG.camera.zoom, -FlxG.height * FlxG.camera.zoom).makeSolid(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	darkoverlay.alpha = 0.0001;
	darkoverlay.scrollFactor.set(0, 0);
	add(darkoverlay);

    darkScreen = new FlxSprite(0, 0).makeSolid(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
    darkScreen.camera = camHUD;
	add(darkScreen);

    titleCard = new FunkinSprite();
    titleCard.loadSprite(Paths.image('doki/titlecards/' + curSong));
	titleCard.addAnim('idle', 'card', 24, true);
	titleCard.playAnim('idle');
	titleCard.antialiasing = Options.antialiasing;
	titleCard.camera = camHUD;
	titleCard.screenCenter();
	titleCard.alpha = 0.001;
	titleCard.scale.set(0.8,0.8);
	add(titleCard);

    if (FlxG.save.data.SANTIYEA_ddto_middlescroll) {
        for (i in 0...player.members.length) player.members[i].x = 412 + 110 * i;
        cpu.members[0].x = 82; cpu.members[1].x = 194;
        cpu.members[2].x = 971; cpu.members[3].x = 1083;
    }

    if (FlxG.save.data.SANTIYEA_ddto_healthbar < 1)
        for (i in [iconP1, iconP2, healthBar, healthBarBG])
            i.alpha = FlxG.save.data.SANTIYEA_ddto_healthbar;

    GameOverSubstate.script = 'data/scripts/GameoverStuff';
}

function onStrumCreation(_)
    if (FlxG.save.data.SANTIYEA_ddto_middlescroll && _.player == 0) {
        _.cancelAnimation();
        _.strum.y -= 10;
        _.strum.alpha = 0;
        FlxTween.tween(_.strum, {y: _.strum.y + 10, alpha: 1 * 0.5}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * _.strumID)});
    }

function onNoteCreation(_)
    if (FlxG.save.data.SANTIYEA_ddto_middlescroll && _.strumLineID == 0)
        _.note.alpha = 0.5;

function onGameOver(_) {
    switch(ChangeGameover) {
        case 'default':
            _.deathCharID = 'gameover-sadbf';
            _.lossSFX = 'sad_death';
        case 'markov':
            _.deathCharID = 'gameover-markov';
            _.lossSFX = 'YuriWatchesYouDie';
        case 'poem':
            _.deathCharID = 'gameover-poem';
            _.lossSFX = 'stagnantdeath';
    }

    FlxTween.tween(FlxG.camera, {zoom: ChangeGameover == 'markov' ? 0.8 : 1}, 0.00001);
}

function onCountdown(_) {
    _.volume = 0;

    if (_.swagCounter == 0) {
        FlxTween.tween(titleCard, {alpha: 1, 'scale.x': 1, 'scale.y': 1}, 3, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween) {
				FlxTween.tween(titleCard, {alpha: 0}, 2, {ease: FlxEase.cubeOut, startDelay: 1, onComplete: function(twn:FlxTween) {
						remove(titleCard);
						titleCard.destroy();
					}
				});
			}
		});
    }
}

public var isUnfairDiff:Bool = PlayState.instance.difficulty.toLowerCase() == 'unfair';

function onDadHit(_)
    if (isUnfairDiff)
        if (!_.note.isSustainNote && health >= 0.3)
            health -= 0.03;