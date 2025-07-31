function onNoteCreation(_)
	if (_.noteType == 'Note of Markov') {
		_.noteSprite = 'game/notes/markov';
		_.note.earlyPressWindow = 0.1;
		_.note.latePressWindow = 0.2;
		if (_.strumLineID <= 0) _.note.wasGoodHit = true;

		if (curSong == 'stagnant') {
			var step = Conductor.getStepForTime(_.note.strumTime);

			if(step >= 1312) _.noteSprite = 'game/notes/markov-poem';
			if(step >= 1824) _.noteSprite = 'game/notes/markov';
			if(step >= 2336) _.noteSprite = 'game/notes/markov-poem';
		}
	}

function onPostNoteCreation(_)
	if (_.noteType == 'Note of Markov') {
		_.note.offset.x += 50;
		_.note.offset.y += 65;
	}

function onPlayerHit(e) {
	if (e.noteType == "Note of Markov") { health -= 100; }
}

function onPlayerMiss(e) {
	if (e.noteType == "Note of Markov") { e.cancel(); deleteNote(e.note); }
}