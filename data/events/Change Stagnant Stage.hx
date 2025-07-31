function onPsychEvent(name, v1, v2)
    if (name == 'Change Stagnant Stage') {
        var val2:Float = Std.parseFloat(v2);
		if (Math.isNaN(val2)) val2 = 0;
		
		defaultCamZoom = defaultStageZoom;
		FlxG.camera.zoom = defaultStageZoom;
		isCameraOnForcedPos = false;
		ChangeGameover = 'default';
		
		for (i in [evilClubBG, evilClubBGScribbly, evilPoem])
		    i.visible = false;
		    
		switch(abStage) {
		    case 'home':
		        if (!Options.lowMemoryMode) {
		            for (i in [deskfront, evilSpace, clouds, fancyclouds, windowlight,
		                clubroomdark, bgwindo, bgwindo2])
		                    i.visible = false;
		        }
		        
		        for (i in [stageStatic, ruinedClubBG, glitchfront, glitchback, closet,
		            clubroom, inthenotepad, notepadoverlay])
		                i.visible = false;
		        boyfriend.setPosition(defXY.bf[0], defXY.bf[1]);
		  case 'markov': closetCloseUp.visible = false;
		  case 'stagnant':
		        if (!Options.lowMemoryMode) {
		            for (i in [deskfront, evilSpace, clouds, fancyclouds, windowlight,
		                clubroomdark])
		                    i.visible = false;
		        }
		        closet.visible = clubroom.visible = false;
		}
		
		evilClubBGScribbly.alpha = 0.0001;
		
		switch(v1) {
		    default:
		        closet.visible = clubroom.visible = true;
				if (!Options.lowMemoryMode) deskfront.visible = true;
			case 'evil':
				defaultCamZoom = 0.8;
				FlxG.camera.zoom = 0.8;

				if (!Options.lowMemoryMode) {
					for (i in [evilSpace, clouds, fancyclouds, windowlight, clubroomdark])
						i.visible = true;
				}
				evilClubBGScribbly.visible = evilClubBG.visible = true;
			case 'poem':
				defaultCamZoom = 0.9;
				FlxG.camera.zoom = 0.9;
				evilPoem.visible = true;
				ChangeGameover = 'poem';
			case 'markovpoem':
				defaultCamZoom = 0.9;
				FlxG.camera.zoom = 0.9;
				evilPoem.visible = true;
				bloodyBG.alpha = 1;
				bloodyBG.animation.play('bgBlood');
				screenPulse.alpha = 1;

				remove(funnyEyes);
				funnyEyes.camera = camGame;
				insert(members.indexOf(bloodyBG) + 1, funnyEyes);
				funnyEyes.setGraphicSize(Std.int(bloodyBG.width * 1.3));
				funnyEyes.alpha = 1;
				ChangeGameover = 'markov';
			case 'closet':
				defaultCamZoom = 1.0;
				FlxG.camera.zoom = 1.0;
				closetCloseUp.visible = true;
				ChangeGameover = 'markov';
			case 'ruined' | 'ruinedclub':
				defaultCamZoom = 0.8;
				FlxG.camera.zoom = 0.8;

				for (i in [stageStatic, ruinedClubBG, glitchfront, glitchback]) i.visible = true;
				if (!Options.lowMemoryMode) bgwindo.visible = bgwindo2.visible = true;
			case 'notepad':
				defaultCamZoom = 1.0;
				FlxG.camera.zoom = 1.0;
				isCameraOnForcedPos = true;
				camFollow.setPosition(650, 360);
				boyfriend.setPosition(430, -140);
				ChangeGameover = 'poem';

				for (i in [stageStatic, inthenotepad, notepadoverlay])
					i.visible = true;
			case 'void':
				defaultCamZoom = 0.9;
				FlxG.camera.zoom = 0.9;

				for (i in [boyfriend, gf, dad]) i.color = -1;
			case 'redstatic':
				defaultCamZoom = 0.9;
				FlxG.camera.zoom = 0.9;
				stageStatic.visible = true;
		}

		if (val2 > 0)
			FlxTween.tween(evilClubBGScribbly, {alpha: 1}, val2, {ease: FlxEase.sineIn, onComplete: (_) -> evilClubBGScribbly.alpha = 1});
    }