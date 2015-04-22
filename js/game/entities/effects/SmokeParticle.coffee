define (require) ->
    'use strict'
    
    easeout = require('cs!helper').easeout
    
    Entity = require 'cs!game/core/Entity'
    
    class SmokeParticle extends Entity
        
        # Constructeur
        constructor: (@parent, x = 0, y = 0, @darkness = 0) ->
            super @parent
            
            @image = @game.assets.images.planes.effects.smoke_spritesheet
            
            @x = x
            @y = y
            @width = @height = 16 * 3
            
            @t = 0
            @duration = 0.5 + Math.random() * 0.2
            
            # Image aléatoire
            @m = Math.floor(Math.random() * @image.height / @height)
            
            # Vitesse
            @vel.x = -300 + Math.random() * 50
            @vel.y = Math.random() * 20 - 10
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
            
            @updatePosition(dt)
            @parent.removeChild(@) if @t > @duration
        
        # Affichage
        handleDraw: ->
            if @t < @duration
                @n = easeout(@t, @duration, 0.5, 0.5)
            
                @ctx.save()
                
                if @t < 0.1
                    @ctx.globalAlpha = @t / 0.1
                else
                    @ctx.globalAlpha = 1 - @n
                
                @ctx.translate(- @n * @width*.5 + @x, - @n * @height*.5 + @y)
                @ctx.scale(@n, @n)
                @ctx.drawImage(
                    @image,
                    0, @m * @height,
                    @width,
                    @height,
                    0,
                    0,
                    @width,
                    @height)
                
                @ctx.globalAlpha = @ctx.globalAlpha * @darkness * 0.5
                @ctx.globalCompositeOperation = 'difference'
                @ctx.drawImage(
                    @image,
                    0, @m * @height,
                    @width,
                    @height,
                    0,
                    0,
                    @width,
                    @height)
                
                @ctx.restore()
