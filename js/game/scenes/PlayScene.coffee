# Classe abstraite représentant une scène
define (require) ->
    
    Scene = require 'cs!game/scenes/Scene'
    HeroPlane = require 'cs!game/entities/HeroPlane'
    Background = require 'cs!game/entities/Background'
    easeout = require('cs!helper').easeout
    
    class PlayScene extends Scene
        
        # Démarrage de la scène
        handleStart: ->
            @width = @game.canvas.width
            @height = @game.canvas.height
            
            @addChild new Background @
            
            @hero = new HeroPlane @
            @hero.y = @game.canvas.height*.5 - @hero.height*.5
            @addChild @hero
        
        # Mise à jour de la scène
        # @param Number dt
        handleUpdate: (dt) ->
            super dt
            
            if @game.t < 1
                @hero.x = easeout(@game.t, 1, - @hero.width, @hero.width * 2)
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            ctx.save()
            ctx.fillStyle = '#bbedf3'
            ctx.fillRect(0, 0, @game.canvas.width, @game.canvas.height)
            ctx.restore()
            
            @drawEntities(ctx)
        