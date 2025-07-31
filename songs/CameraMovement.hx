/*
this is a (kinda) port of the script by SenTCM, credits to him
(this looks nothing like their code)
made by silly borja please credit if used
*/

public var noteCam:Bool = false;
public var camNoteExtend:Float = 15;
public var tilt_followMult:Float = 12;

function update()
    if (noteCam)
        switch (strumLines.members[curCameraTarget].characters[0].animation.curAnim.name){
            case "singLEFT", "singLEFT-alt": doCameraStuffEhehehe([-camNoteExtend, 0]);
            case "singDOWN", "singDOWN-alt": doCameraStuffEhehehe([0, camNoteExtend]);
            case "singUP", "singUP-alt": doCameraStuffEhehehe([0, -camNoteExtend]);
            case "singRIGHT", "singRIGHT-alt": doCameraStuffEhehehe([camNoteExtend, 0]);
            default: doCameraStuffEhehehe([0, 0]);
        }

function doCameraStuffEhehehe(offsets:Array<Float>){
    camGame.targetOffset.x = FlxMath.lerp(camGame.targetOffset.x, offsets[0], camGame.followLerp * tilt_followMult);
    camGame.targetOffset.y = FlxMath.lerp(camGame.targetOffset.y, offsets[1], camGame.followLerp * tilt_followMult);
}