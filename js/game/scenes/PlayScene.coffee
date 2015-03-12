# Classe abstraite représentant une scène
define (require) ->
    
    Scene = require 'cs!game/scenes/Scene'
    HeroPlane = require 'cs!game/entities/HeroPlane'
    
    class PlayScene extends Scene
        
        # Démarrage de la scène
        handleStart: ->
            @addChild new HeroPlane @
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            ctx.save()
            ctx.fillStyle = '#bbedf3'
            ctx.fillRect(0, 0, @game.canvas.width, @game.canvas.height)
            ctx.restore()
            
            @drawEntities(ctx)
        