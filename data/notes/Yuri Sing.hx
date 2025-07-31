function onDadHit(e) {
    if (e.noteType == "Yuri Sing") {
        e.animCancelled = true;
        yuri.playSingAnim(e.direction);
    }
}