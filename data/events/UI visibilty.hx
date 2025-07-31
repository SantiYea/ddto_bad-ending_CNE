function onPsychEvent(name, v1, v2)
    if (name == 'UI visibilty') {
        var finalBoolean:Bool;

        if (v1 == null || v1 == 'false')
            finalBoolean = false;
        else if (v1 == 'true')
            finalBoolean = true;

        for (i in [scoreTxt, accuracyTxt, missesTxt, iconP1, iconP2, healthBar, healthBarBG])
            i.visible = finalBoolean;
    }