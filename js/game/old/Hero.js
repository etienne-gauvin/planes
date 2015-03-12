((function(window){
	function Hero(imgHero) {
 		this.initialize(imgHero);
	}
	
	Hero.prototype = new createjs.Sprite();
	Hero.prototype.Sprite_initialize = Hero.prototype.initialize;

	// Propriétés
	Hero.prototype.inAir = true;
	Hero.prototype.direction = 'right';
	Hero.prototype.movingForward = false;
	Hero.prototype.jumping = true;

	Hero.prototype.x = 0;
	Hero.prototype.y = 0;

	/**
	 * Constructeur
	 */
	Hero.prototype.initialize = function(imgHero) {
		var data = {
			images: [imgHero],
			frames: {width: 60, height:85},
			animations: {
				walk: [0,  19, "walk"],
				idle: [20, 20, "idle"],
				jump: [21, 21, "jump"],
			}
		};

		var spriteSheet = new createjs.SpriteSheet(data);	
		this.constructor(spriteSheet);
		this.gotoAndPlay("idle");
	}

	// Fonctions évènementielles

	/**
	 * Gestion d'une touche appuyée sur le clavier
	 */
	Hero.prototype.onKeyDown = function(key) {
		switch (key) {
			// left
			case 37:
				this.startMovingToLeft();
			break;

			// right
			case 39:
				this.startMovingToRight();
			break;

			// jump
			case 32:
				this.startJumping();
		}
	}

	/**
	 * Gestion d'une touche relâchée sur le clavier
	 */
	Hero.prototype.onKeyUp = function(key) {
		switch (key) {
			// right/left
			case 37:
			case 39:
				this.stopMovingForward();
			break;

			// jump
			case 32:
				this.stopJumping();
		}
	}

	/**
	 * Mise à jour du personnage (position, etc)
	 * @param Number dt
	 */
	Hero.prototype.update = function(dt) {
		if (this.movingForward){
			switch (direction) {
				case 'right':
					vx = 5;
				break;

				case 'left':
					vx = -5;
				break;
			}
		}

		this.x += this.vx;
		this.y += this.vy;
	}

	// Actions

	/**
	 * Commencer à se diriger vers la gauche
	 */
	Hero.prototype.startMovingToLeft = function() {
		this.direction = 'left';
		this.movingForward = true;
	}
	
	/**
	 * Commencer à se diriger vers la droite
	 */
	Hero.prototype.startMovingToRight = function() {
		this.direction = 'right';
		this.movingForward = true;
	}

	/**
	 * Arrêter de se déplacer
	 */
	Hero.prototype.stopMovingForward = function() {
		this.movingForward = false;
	}
	
	/**
	 * Sauter (si possible)
	 */
	Hero.prototype.startJumping = function() {
		if (!this.inAir) {
			this.inAir = true;
			hero.gotoAndPlay('jump');
		}
	}

	/**
	 * Arrêter de sauter (si ce n'est déjà fait)
	 */
	Hero.prototype.stopJumping = function() {
		this.jumping = false;
	}

	window.Hero = Hero;
})(window));	
