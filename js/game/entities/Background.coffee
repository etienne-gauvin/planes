define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    
    class Background extends Entity
        
        # Constructeur
        constructor: (@scene) ->
            super(@scene)
            
            @t = 0
            
            # Spritesheet de l'avion
            @layers = [
                { speed: 10, alpha: 0.6, shift: 0, image: @scene.game.assets.backgroundMountainsB },
                { speed: 20, alpha: 1,   shift: 0, image: @scene.game.assets.backgroundMountainsA },
                { speed: 40, alpha: 0.6, shift: 0, image: @scene.game.assets.backgroundClouds },
            ]
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            ctx.save()
            
            for layer in @layers
                @width = layer.image.width
                
                x = -@t * layer.speed + layer.shift % @scene.width
                x -= @width while x + @width > 0
                
                ctx.globalAlpha = layer.alpha or 1
                
                while x < @scene.width
                    ctx.drawImage(layer.image, x, @y)
                    x += @width
            
            ctx.restore()
        