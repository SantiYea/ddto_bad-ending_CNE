function onPsychEvent(name, v1, v2)
    if (name == 'Poem Transition') {
        var tweenBool:Bool = true;
		if (v1 == 'false')
			tweenBool = false;

		if (tweenBool)
		{
			poemTransition.visible = true;
			poemTransition.alpha = 1;
			poemTransition.animation.play('idle', true);
		}
		else
		{
			FlxTween.tween(poemTransition, {alpha: 0}, 0.25, {
				ease: FlxEase.sineOut,
				onComplete: function(twn:FlxTween)
				{
					poemTransition.alpha = 0;
					poemTransition.visible = false;
				}
			});
		}
    }