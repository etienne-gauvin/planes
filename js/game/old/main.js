(function(window) {
	var game = {

		// Objets globaux
		canvas: null,
		stage: null,
		loadQueue: null,

		// Entités
		hero: null,
		key: null,
		door: null,
		background: null,

		// Plateformes et caisses
		platforms: [],
		crate: [],

	};

	window.game = game;


	/**
	 * Initialisation (après le chargement)
	 */
	function init() {

		game.loadQueue = new createjs.LoadQueue();
		game.loadQueue.loadManifest(game.manifest, false, game.basePath);
		
		game.loadQueue.on("complete", function() {
			start();
			createjs.Ticker.addEventListener("tick", update);
		});

		game.loadQueue.load();
	}

	/**
	 * Démarrage du jeu
	 */
	function start() {
		game.stage = new createjs.Stage("canvas");

		game.background = new createjs.Bitmap(game.loadQueue.getResult('scene'));
		game.background.x = 0;
		game.background.y = 0;
		game.stage.addChild(game.background);
		
		game.key = new createjs.Bitmap(game.loadQueue.getResult('key'));
		game.key.x = 840;
		game.key.y = 490;
		game.stage.addChild(game.key);
		
		var door = new createjs.Bitmap(game.loadQueue.getResult('door'));
		door.x = 130;
		door.y = 385;
		game.stage.addChild(door);
		
		var hero = new Hero(game.loadQueue.getResult('hero'));
		hero.x=40;
		hero.y=380;
		game.stage.addChild(hero);

		// Écouteurs sur les touches
		window.addEventListener('keydown', handleKeyDown);
		window.addEventListener('keyup', handleKeyUp);
	}

	/**
	 * Gestion d'une touche appuyée sur le clavier
	 */
	function handleKeyDown(evt) {
		var key = evt.keyCode;
		console.log(key);
		hero.handleKeyDown(key);
	}

	function handleKeyUp(evt){
		var key = evt.keyCode;
		hero.handleKeyDown(key);
	}

	/**
	 * Mise à jour des objets et du jeu
	 */
	function update(evt) {
		hero.update();
		stage.update();
	}

	// Lancement du script
	window.addEventListener('load', init);

})(window);