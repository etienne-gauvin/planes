define (require) ->
    
    Scene = require 'cs!game/scenes/Scene'
    
    class HUD extends Scene
        
        # Constructeur
        constructor: (@game) ->
            super @game
            
            @markForUpdate = yes
        
        # Démarrage de la scène
        handleStart: ->
        
        # Mise à jour de la scène
        # @param Number dt
        handleUpdate: (dt) ->
            @update(dt) if @markForUpdate
            super
        
        # Mise à jour de la scène
        # @param Number dt
        update: (dt) ->
            for entity in @entities
                entity.handleUpdate(dt) if entity?
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            @drawEntities(ctx)
        
        # Arrêt de la scène
        # @param Function callback est appelée quand la scène est bien arrêtée
        handleStop: (callback) ->
            callback()
        