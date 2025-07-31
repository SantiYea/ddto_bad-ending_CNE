import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.DiscordUtil;

var pressEnter:FunkinSprite;
var screen:FlxSprite = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
var enter:Bool = false;

function create() {
    CoolUtil.playMenuSong();
    DiscordUtil.changePresence('Entering To My Destiny', "DDTO Bad Ending - [Title Screen]");

    var backdrop:FlxBackdrop = new FlxBackdrop(Paths.image('scrolling_BG'));
	backdrop.velocity.set(-40, -40);
	backdrop.antialiasing = Options.antialiasing;
	add(backdrop);

    var creditsBG:FlxBackdrop = new FlxBackdrop(Paths.image('pocBackground'));
	creditsBG.velocity.set(-50, 0);
	creditsBG.antialiasing = Options.antialiasing;
	add(creditsBG);

    var scanline:FlxBackdrop = new FlxBackdrop(Paths.image('scanlines'));
	scanline.velocity.set(0, 20);
	scanline.antialiasing = Options.antialiasing;
	add(scanline);

    var gradient:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gradent'));
    gradient.antialiasing = Options.antialiasing;
    gradient.scrollFactor.set(0.1, 0.1);
    gradient.screenCenter();
    gradient.setGraphicSize(Std.int(gradient.width * 1.4));
    add(gradient);

    var logoBl:FunkinSprite = new FunkinSprite(320, 0, Paths.image('logo'));
    logoBl.addAnim('idle', 'logo bumpin', 24, true);
    logoBl.playAnim('idle');
    logoBl.scale.set(0.8, 0.8);
    logoBl.updateHitbox();
    logoBl.antialiasing = Options.antialiasing;
    add(logoBl);

    pressEnter = new FunkinSprite(200, 576, Paths.image('titleEnter'));
    pressEnter.addAnim('idle', 'Press Enter to Begin', 24, true);
    pressEnter.addAnim('enter', 'ENTER PRESSED', 24, true);
    pressEnter.playAnim('idle');
    pressEnter.antialiasing = Options.antialiasing;
    add(pressEnter);

    var vignette:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuvignette'));
	vignette.alpha = 0.8;
	add(vignette);

    add(screen);
    FlxTween.tween(screen, {alpha: 0}, 1);
}

function update(dt) {
    if (FlxG.sound.music.volume < 0.8)
		FlxG.sound.music.volume += 0.5 * dt;
    
    if (screen.alpha < 0.3 && !enter) {
        if (controls.ACCEPT #if mobile || FlxG.mouse.justPressed #end) {
            enter = !enter;
            CoolUtil.playMenuSFX(1);
            pressEnter.playAnim('enter');
            FlxG.camera.flash(FlxColor.WHITE, 1);
            new FlxTimer().start(1.2, () -> FlxG.switchState(new ModState('menu')));
        }
    }
}