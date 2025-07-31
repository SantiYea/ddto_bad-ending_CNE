function onDadHit(e) {
    if (e.noteType == "Sayo Sing") {
        e.animCancelled = true;
        sayori.playSingAnim(e.direction);
    }
}
