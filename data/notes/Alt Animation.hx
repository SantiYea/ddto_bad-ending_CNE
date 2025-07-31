function onNoteHit(event) if (event.noteType == "Alt Animation") event.animSuffix = "-alt";
function onPlayerMiss(event) if (event.noteType == "Alt Animation") event.animSuffix = "miss-alt";