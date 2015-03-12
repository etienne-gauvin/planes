define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    
    class Background extends Entity
        
        # Constructeur
        constructor: (@scene) ->
            super(@scene)
            
            @t = 0
            
            # Spritesheet de l'avion
            @layers = [
                { speed: 10, image: @scene.game.assets.backgroundMountains },
                { speed: 20, image: @scene.game.assets.backgroundClouds },
            ]
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            for layer in @layers
                @width = layer.image.width
                
                x = -@t * layer.speed % @scene.width
                x -= @width while x + @width > 0

                while x < @scene.width
                    ctx.drawImage(layer.image, x, @y)
                    x += @width
        
        