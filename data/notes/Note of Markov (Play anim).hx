public var bloodStrums:FlxTypedGroup<FunkinSprite> = new FlxTypedGroup();

function postCreate() {
    bloodStrums.camera = camHUD;
    insert(1, bloodStrums);

    for (i in 0...cpu.members.length) {
        var _spr:FunkinSprite = new FunkinSprite(cpu.members[i].x - 260, cpu.members[i].y + 150, Paths.image('blooddrip'));
        _spr.addAnim('idle', 'gone', 24, false);
        _spr.addAnim('drip', 'blood', 24, false);
        _spr.scale.set(1.3, 1.3);
        _spr.playAnim('idle');
        bloodStrums.add(_spr);
    }
}

function onNoteCreation(_)
    if (_.noteType == 'Note of Markov (Play anim)') {
        _.noteSprite = 'game/notes/markov';
    }

function onPostNoteCreation(_)
	if (_.noteType == 'Note of Markov (Play anim)') {
		_.note.offset.x += 50;
		_.note.offset.y += 65;
	}

function onDadHit(_)
    if (_.noteType == 'Note of Markov (Play anim)') {
        PsychEvent('Play SFX', 'stab', '');

        if (bloodDrips) {
            var blood:FunkinSprite = bloodStrums.members[_.direction];

            if (StringTools.startsWith(blood.animation.name, 'idle'))
                blood.playAnim('drip');
        }
    }