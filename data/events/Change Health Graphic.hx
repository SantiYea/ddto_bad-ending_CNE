var poemHealthBar:FunkinSprite;

function postCreate() {
    poemHealthBar = new FunkinSprite(healthBarBG.x - 11, healthBarBG.y - 20, Paths.image('poemUI/healthBar-poem'));
    poemHealthBar.addAnim('idle', 'healthBar', 24, true);
    poemHealthBar.playAnim('idle');
    poemHealthBar.camera = camHUD;
    poemHealthBar.alpha = 0.0001;
    poemHealthBar.scale.x = 1.02;
    poemHealthBar.updateHitbox();
    insert(members.indexOf(healthBarBG), poemHealthBar);
}

function onPsychEvent(n, v1, v2)
    if (n == 'Change Health Graphic') {
        poemHealthBar.alpha = v1 == 'poemUI/,-poem' ? FlxG.save.data.SANTIYEA_ddto_healthbar : 0;
        healthBarBG.alpha = v1 == '' ? FlxG.save.data.SANTIYEA_ddto_healthbar : 0;
    }