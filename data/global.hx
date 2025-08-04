import funkin.backend.system.framerate.Framerate;
import lime.graphics.Image;

public static var MENU_firstStart:Bool = true;
public static var MENU_curItem:Int = 0;

static var colorFps = 0xFFFF0000;
static var changed:Bool = false;
static var defTitle:String = 'Doki Doki Takeover! - BAD ENDING';
static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "menu", FreeplayState => "freeplay", StoryMenuState => "menu", TitleState => "title"
];

function new()
{
    FlxG.save.data.SANTIYEA_finished_storyMode ??= false;
    FlxG.save.data.SANTIYEA_ddto_middlescroll ??= false;
    FlxG.save.data.SANTIYEA_ddto_healthbar ??= 1;
}

function preStateSwitch() {
    if (!changed) {
        window.setIcon(Image.fromBytes(Assets.getBytes(Paths.getPath('icon.png'))));
        window.title = defTitle;
        
        Framerate.codenameBuildField.visible = false;

        Framerate.fpsCounter.fpsNum.textColor = colorFps;
        Framerate.fpsCounter.fpsLabel.textColor = colorFps;

        Framerate.memoryCounter.memoryText.textColor = colorFps;
        Framerate.memoryCounter.memoryPeakText.textColor = colorFps;

        changed = !changed;
    }

    for (state => modState in redirectStates) 
        if (Std.isOfType(FlxG.game._requestedState, state)) 
            FlxG.game._requestedState = new ModState(modState);
}
