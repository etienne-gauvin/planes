define (require) ->
    
    Entity = require 'cs!game/core/Entity'
    Feather = require 'cs!game/entities/effects/Feather.coffee'
    floor = Math.floor
    
    class HoverPouleExplosion extends Entity
        
        # Constructeur
        constructor: (@parent, centerX, centerY) ->
            super @parent
            
            @width = 24 * 3
            @height = 24 * 3
            
            @centerX = centerX
            @centerY = centerY
            
            @image = @game.assets.images.enemies.hoverpoule.effects.explosion.spritesheet
            @lumImage = @game.assets.images.enemies.hoverpoule.effects.explosion.flash
            
            @t = 0
            @duration = 0.10
            @imgN = floor(@image.height / @height * Math.random())
            createjs.Sound.play('sounds/enemies/hoverpoule/explosion.ogg')
            
            for i in [1 .. floor(Math.random()*4)]
                x = @centerX + Math.random() * @width*.5 - @width*.25
                y = @centerY + Math.random() * @height*.5 - @height*.25
                @parent.addChild new Feather @parent, x, y
            
            
        
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
                @ctx.translate(floor(@x), floor(@centerY - @height/2 * scale))
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
        
            