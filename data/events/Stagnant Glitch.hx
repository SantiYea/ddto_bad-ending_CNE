function onPsychEvent(name, v1, v2)
    if (name == 'Stagnant Glitch') {
        stagstatic.playAnim('idle');
		stagstatic.alpha = 1;
        stagstatic.animation.finishCallback = function(name:String) {
            if (name == 'idle')
                stagstatic.alpha = 0;
        }
    }