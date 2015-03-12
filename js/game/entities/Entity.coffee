# Classe abstraite représentant une entité
define (require) ->
    
    Object = require 'cs!game/Object'
    
    class Entity extends Object
        
        # Constructeur
        constructor: (@scene) ->
            
            # Position
            @x = @y = 0
        
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
                