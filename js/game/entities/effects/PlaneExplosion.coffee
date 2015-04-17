define (require) ->
    
    Entity = require 'cs!game/core/Entity'
    floor = Math.floor
    
    class PlaneExplosion extends Entity
        
        # Constructeur
        constructor: (@parent, centerX, centerY) ->
            super @parent
            
            @width = 32 * 3
            @height = 24 * 3
            
            @centerX = centerX
            @centerY = centerY
            
            @image = @game.assets.images.planeExplosion
            @lumImage = @game.assets.images.explosionLum
            
            @t = 0
            @duration = 0.2
            @imgN = floor(@image.height / @height * Math.random())
            createjs.Sound.play('explosion')
            
            
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: ->
            if @t < @duration
                @ctx.save()
                @ctx.globalAlpha = 1 - @t / @duration
                
                scale = 0.4 * @t / @duration + 0.6
                @ctx.translate( floor(@centerX - @width*0.8 * scale),
                                floor(@centerY - @height*.5 * scale))
                @ctx.scale(scale, scale)
                
                @ctx.drawImage(
                    @image,
                    0, @imgN * @height,
                    @width,
                    @height,
                    0, 0,
                    @width,
                    @height)
                
                @ctx.restore()
                
                if @t < @duration / 2
                    @ctx.save()
                    @ctx.globalAlpha = 1 - @t / (@duration / 2)
                    
                    @ctx.drawImage(
                        @lumImage,
                        @centerX - @lumImage.width / 2,
                        @centerY - @lumImage.height / 2)

                    @ctx.restore()
        
            