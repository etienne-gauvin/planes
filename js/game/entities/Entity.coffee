# Classe abstraite représentant une entité
define (require) ->
    
    Object = require 'cs!game/Object'
    
    class Entity extends Object
        
        # Constructeur
        constructor: (@scene) ->
            
            # Position
            @x = @y = 0
            
            # Dimensions
            @width = @height = 0
        
            # Vélocité (en pixel/s)
            @velX = @velY = 0
            
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
        
        # Destruction de l'entité
        # @param Function callback est appelée quand l'entité est bien détruite
        handleDestruction: (callback) ->
            callback()
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
        
        # Lors du relâchement d'une touche
        handleKeyUp: (event) ->
        
        # Appliquer les écouteurs sur les évènements clavier
        listenToKeyboardEvents: ->
            @scene.addEventListener('keydown', (event) => @handleKeyDown(event))
            @scene.addEventListener('keyup', (event) => @handleKeyUp(event))
        
        # Mise à jour de la position de l'entité en fonction de sa vitesse
        updatePosition: (dt) ->
            @x += @velX * dt
            @y += @velY * dt
        
        # Garder l'avion dans les limites de l'écran
        updateVelocityToKeepOnScreen: ->
            # Limiter la vitesse sur les bords de l'écran
            padding = 100
            
            # Limitation en haut
            if @velY < 0 and @y < padding
                @velY *= Math.pow((@y / padding), 0.1) or 0
            
            # Limitation en bas
            if @velY > 0 and @scene.height - @y - @height < padding
                @velY *= Math.pow(((@scene.height - @y - @height) / padding), 0.1) or 0
                
            # Limitation à droite
            if @velX < 0 and @x < padding
                @velX *= Math.pow((@x / padding), 0.1) or 0
                
            # Limitation à gauche
            if @velX > 0 and @scene.width - @x - @width < padding
                @velX *= Math.pow(((@scene.width - @x - @width) / padding), 0.1) or 0
                