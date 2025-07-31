import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.macros.GitCommitMacro;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import flixel.effects.FlxFlicker;
import funkin.backend.utils.DiscordUtil;

import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

#if mobile
import funkin.mobile.controls.FlxDPadMode;
import funkin.mobile.controls.FlxActionMode;
#end

var firstStart:Bool = MENU_firstStart;
var allowUser:Bool = true;
var curItem:Int = MENU_curItem;
var random:Int = FlxG.random.int(1, 100);
var isFocused:Bool = true;
var funnyTimer:FlxTimer;

var items:FlxTypedGroup<FlxText> = new FlxTypedGroup();
var items_Str:Array<String> = [
	'Story Mode',
	'Freeplay',
	'Credits',
	'Options',
	'Exit Game'
];

var dontTab:FlxSprite;

function create() {
    CoolUtil.playMenuSong();
    DiscordUtil.changePresence('Thinking In My Destiny', "DDTO Bad Ending - [Main Menu]");

    if (!FlxG.save.data.SANTIYEA_finished_storyMode) {
        items_Str.remove('Freeplay');
        trace('Story Mode Not Completed Yet.');
    }

    var backdrop:FlxBackdrop = new FlxBackdrop(Paths.image('scrolling_BG'));
	backdrop.velocity.set(-40, -40);
	backdrop.antialiasing = Options.antialiasing;
	add(backdrop);

    if (random == 64) {
		var fumo:FlxSprite = new FlxSprite(-100, -250, Paths.image('Fumo'));
        fumo.antialiasing = Options.antialiasing;
		fumo.screenCenter();
		fumo.x += 100;
		add(fumo);
	}
	else {
		var ghostdoki:FlxSprite = new FlxSprite(460, 0, Paths.image('GhostDokis'));
		ghostdoki.antialiasing = Options.antialiasing;
		add(ghostdoki);
	}

    var sideMenu:FlxSprite = new FlxSprite(firstStart ? -260 : -60, 0, Paths.image('Credits_LeftSide'));
	sideMenu.antialiasing = Options.antialiasing;
	add(sideMenu);

    var logoBl:FunkinSprite = new FunkinSprite(firstStart ? -160 : 40, -40, Paths.image('logo'));
    logoBl.addAnim('idle', 'logo bumpin', 24, true);
    logoBl.playAnim('idle');
    logoBl.scale.set(0.5, 0.5);
    logoBl.updateHitbox();
    logoBl.antialiasing = Options.antialiasing;
    add(logoBl);

    add(items);
    for (i in 0...items_Str.length) {
        var option:FlxText = new FlxText(firstStart ? -350 : 50, 370 + (i * 50), 0, items_Str[i]);
		option.setFormat(Paths.font('riffic.ttf'), 27, FlxColor.WHITE, 'left');
		option.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF444444, 2);
        option.antialiasing = true;
		option.ID = i;
		items.add(option);
    }
    
    var Device:String = #if mobile 'X'; #else controls.getDialogueNameFromToken('switchmod'); #end
    var str:String = '- Codename Engine v' + Main.releaseVersion + '\n- Commits: ' + GitCommitMacro.commitNumber + ' | (' + GitCommitMacro.commitHash + ')' + '\n- [' + Device + '] Open Mods menu\n';
    var info:FunkinText = new FunkinText(12, FlxG.height - 50, 0, str, 16);
	add(info);

    dontTab = new FlxSprite().loadGraphic(Paths.image('DonTabOut'));
    dontTab.antialiasing = true;
    dontTab.alpha = 0.0001;
    add(dontTab);

    var vignette:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuvignette'));
	vignette.alpha = 0.6;
	add(vignette);

    if (firstStart) {
        MENU_firstStart = !MENU_firstStart;

        FlxTween.tween(sideMenu, {x: -60}, 1.2, {ease: FlxEase.elasticOut});
        FlxTween.tween(logoBl, {x: 40}, 1.2, {ease: FlxEase.elasticOut});
        for (i in 0...items.members.length) FlxTween.tween(items.members[i], {x: 50}, 1.2 + (i * 0.2), {ease: FlxEase.elasticOut});
    }
    changeSelected(0, true);
    
	#if mobile
	addVPad(FlxDPadMode.UP_DOWN, FlxActionMode.A_B_X_Y);
	addVPadCamera();
	vPad.visible = true;
	#end
}

function update(dt) {
    if (FlxG.sound.music.volume < 0.8)
		FlxG.sound.music.volume += 0.5 * dt;

    if (allowUser) {
        changeSelected((controls.UP_P ? -1 : 0) + (controls.DOWN_P ? 1 : 0));
        if (controls.ACCEPT) enter();

        if (FlxG.keys.justPressed.SEVEN #if mobile || vPad.buttonY.justPressed #end) {
            persistentUpdate = false;
            persistentDraw = true;
            openSubState(new EditorPicker());
        }
        if (controls.SWITCHMOD #if mobile || vPad.buttonX.justPressed #end) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }
    }
}

function changeSelected(i:Int, f:Bool = false) {
    if (i == 0 && !f) return;
    CoolUtil.playMenuSFX(0);
    MENU_curItem = curItem = FlxMath.wrap(curItem + i, 0, items_Str.length - 1);
    items.forEach(function(txt:FlxText) {
		txt.borderColor = txt.ID == curItem ? 0xFFFF0513 : 0xFF444444;
	});
}

function enter() {
    allowUser = !allowUser;
    CoolUtil.playMenuSFX(1);

    items.forEach(function(txt:FlxText) {
        if (curItem != txt.ID)
            FlxTween.tween(txt, {alpha: 0}, 1.3, {ease: FlxEase.quadOut, onComplete: (_) -> txt.kill()});
        else
            FlxFlicker.flicker(txt, 1, 0.06, false, false, (_) -> switch(items_Str[curItem]) {
                case 'Story Mode': 
                    PlayState.loadWeek({songs: [for (song in ['Stagnant', 'Markov', 'Home']) {name: song}]}, 'hard');
                    FlxG.camera.fade(FlxColor.BLACK, 0.7, false, () -> FlxG.switchState(new PlayState()));
                case 'Freeplay': FlxG.switchState(new ModState('freeplay'));
                case 'Credits': FlxG.switchState(new CreditsMain());
                case 'Options': FlxG.switchState(new OptionsMenu());
                case 'Exit Game':
                    trace('CHAU');
                    Sys.exit(0);
        });
    });
}

function onFocus() {
    isFocused = true;

    if (isFocused && dontTab.alpha != 0.0001) {
		funnyTimer.cancel();
		FlxTween.cancelTweensOf(dontTab);
		FlxTween.tween(dontTab, {alpha: 0.0001}, 0.1, {ease: FlxEase.circOut});
	}
}

function onFocusLost() {
    isFocused = false;

    if (!isFocused && dontTab.alpha != 1) {
        funnyTimer = new FlxTimer().start(5, function(tmr:FlxTimer) {
			FlxTween.tween(dontTab, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		});
	}
}