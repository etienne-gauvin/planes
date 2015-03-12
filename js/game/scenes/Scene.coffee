# Classe abstraite représentant une scène
define (require) ->
    
    Object = require 'cs!game/Object'
    
    class Scene extends Object
        
        # Constructeur
        constructor: (@game) ->
            @entities = []
            @listeners = {}
        
        # Démarrage de la scène
        handleStart: ->
        
        # Mise à jour de la scène
        # @param Number dt
        handleUpdate: (dt) ->
            for entity in @entities
                entity.handleUpdate(dt)
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            @drawEntities(ctx)
        
        # Arrêt de la scène
        # @param Function callback est appelée quand la scène est bien arrêtée
        handleStop: (callback) ->
            callback()
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
            @dispatchEvent(event)
        
        # Lors du relâchement d'une touche
        handleKeyUp: (event) ->
            @dispatchEvent(event)
        
        # Implémentation (partielle) de l'interface EventTarget
        
        addEventListener: (type, listener) ->
            @listeners[type] = @listeners[type] or []
            @listeners[type].push(listener)
        
        removeEventListener: (type, listener) ->
            for l of @listeners[type]
                if @listeners[type][l] == listener
                    delete @listeners[type][l]
        
        dispatchEvent: (event) ->
            for l of @listeners[event.type]
                @listeners[event.type][l](event) if @listeners[event.type][l]?
            
            return true
        
        # Ajout d'une entité enfant
        addChild: (entity) ->
            @entities.push entity
        
        # Afficher les entités
        drawEntities: (ctx) ->
            for entity in @entities
                entity.handleDraw(ctx)