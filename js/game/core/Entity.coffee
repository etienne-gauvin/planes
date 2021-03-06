# Classe Entity
define (require) ->
    'use strict'

    Object = require 'cs!game/core/Object'
    
    # Entité (objet ayant une présence dans le jeu)
    class Entity extends Object
        
        # Constructeur
        constructor: (@parent) ->
            
            @game = @parent.game
            @ctx = @parent.ctx
            
            # Position
            @x = 0 if not @x?
            @y = 0 if not @y?
            
            # Dimensions
            @width = 0 if not @width?
            @height = 0 if not @height?
            
            # Centre absolu de l'objet, en fonction de sa taille (read only)
            @get 'centerX', => @x + @width / 2
            @get 'centerY', => @y + @height / 2
            @set 'centerX', (val) => @x = val - @width / 2
            @set 'centerY', (val) => @y = val - @height / 2
            
            # Angle (en radians)
            @angle = 0
            
            # Angle (en degrés, lié à l'angle en radians)
            @get 'degAngle', => @angle / Math.PI/2 * 360
            @set 'degAngle', (val) =>
                @angle = val / 360 * Math.PI * 2
            
            # Vélocité (en pixel/s)
            @vel =
                x: 0
                y: 0
            
            # Entités enfants
            @children = []
            
            # Collections d'enfant par type
            @collections = {}
            
            # Pour être catégorisé en tant qu'enfant
            @type = null
            
            # Écouteurs
            @listeners = {}
            
            # Pour masquer ou empêcher la mise de l'entité
            @visible = yes
            @updatable = yes
        
        ## Méthodes de gestion des évènements
        
        # Gérer une mise à jour
        # @param Number dt Temps en secondes depuis la dernière mise à jour
        handleUpdate: (dt) ->
            @updateChildren(dt)
        
        # Gérer un nouvel affichage
        handleDraw: ->
            @drawChildren()
        
        # Destruction de l'entité
        # @param Function callback est appelée quand l'entité est bien détruite
        handleDestruction: (callback) ->
            callback()
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
            @dispatchEvent(event)
        
        # Lors du relâchement d'une touche
        handleKeyUp: (event) ->
            @dispatchEvent(event)
        
        ## Routines
        ## (permettent de clarifier le code)
        
        # Mise à jour des enfants
        updateChildren: (dt) ->
            for child in @children
                child.handleUpdate(dt) if child? and child.updatable
        
        # Affichage des enfants
        drawChildren: ->
            for child in @children
                child.handleDraw() if child? and child.visible
        
        # Mise à jour de la position de l'entité en fonction de sa vitesse
        updatePosition: (dt) ->
            @x += @vel.x * dt
            @y += @vel.y * dt
        
        # Appliquer les écouteurs sur les évènements clavier
        listenToKeyboardEvents: ->
            @game.addEventListener('keydown', (event) => @handleKeyDown(event))
            @game.addEventListener('keyup', (event) => @handleKeyUp(event))
        
        # Ajout d'un enfant
        addChild: (child) ->
            @children.push(child)
            
            if child.type?
                @collections[child.type] = [] if not @collections[child.type]?
                @collections[child.type].push(child)
                
        
        # Retirer une entité enfant
        removeChild: (theChild) ->
            for c, child of @children
                delete @children[c] if child is theChild
            
            if theChild.type?
                @collection = @collections[theChild.type] or []
                
                for c, child of @collection
                    delete @collection[c] if child is theChild
        
        ## Méthodes effectuant une vérification
        ## (retournent un booléen)
        
        # Détermine si l'entité est hors du parent
        isOffParent: ->
            @x + @width < 0 or @y + @height < 0 or
            @x > @parent.width or @y > @parent.height
        
        # Détermine si l'entité est hors de la zone visible du jeu
        isOffGameScreen: ->
            @x + @width < 0 or @y + @height < 0 or
            @x > @game.width or @y > @game.height
        
        ## Implémentation (partielle) de l'interface EventTarget
        
        # Ajouter un écouteur
        # @param String type
        # @param Function listener
        addEventListener: (type, listener) ->
            @listeners[type] = @listeners[type] or []
            @listeners[type].push(listener)
        
        # Enlever un écouteur
        # @param String type
        # @param Function listener
        removeEventListener: (type, theListener) ->
            for l, listener of @listeners[type]
                delete @listeners[type][l] if listener is theListener
        
        # Propager un évènement au écouteurs
        # @param Event event
        dispatchEvent: (event) ->
            for l, listener of @listeners[event.type]
                listener(event) if typeof listener is 'function'
            
            return true
        
        # Garder l'avion dans les limites de l'écran
        updateVelocityToKeepOnScreen: ->
            
            # Limiter la vitesse sur les bords de l'écran
            padding = 100
            
            # Limitation en haut
            if @vel.y < 0 and @y < padding
                @vel.y *= Math.pow((@y / padding), 0.1) or 0
            
            # Limitation en bas
            if @vel.y > 0 and @parent.height - @y - @height < padding
                @vel.y *= Math.pow(((@parent.height - @y - @height) / padding), 0.1) or 0
                
            # Limitation à droite
            if @vel.x < 0 and @x < padding
                @vel.x *= Math.pow((@x / padding), 0.1) or 0
                
            # Limitation à gauche
            if @vel.x > 0 and @parent.width - @x - @width < padding
                @vel.x *= Math.pow(((@parent.width - @x - @width) / padding), 0.1) or 0
        
        