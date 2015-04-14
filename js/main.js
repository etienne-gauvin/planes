requirejs.config({
    baseUrl: 'js/lib',
    paths: {
        game: '../game'
    }
});

/**
 * Démarrage
 */
requirejs(
    [
        'cs!game/config',
        'cs!game/PlaneGame',
        'easeljs',
        'soundjs',
        'preloadjs'
    ],
    
    // Lancement du jeu
    function (config, Game) {
        var game = new Game(config)
        game.start()
        
        // Initialisation du son
        game.muted = game.muted;
        
        // Activer/désactiver le son
        document.querySelector('.sound-mute-toggle').addEventListener('click', function() {
            game.muted = !game.muted;
        })
        
        // Objet global, plus pratique pour le développement
        window.game = game
    }
);