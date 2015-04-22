define (require) ->
    'use strict'
    
    Entity = require 'cs!game/core/Entity'
    
    class Feather extends Entity
        
        # Constructeur
        constructor: (@parent, @x, @y) ->
            super @parent
            
            @image = @game.assets.images.enemies.hoverpoule.effects.feather_spritesheet
            
            @width = 5 * 3
            @height = 3 * 3
            
            @t = Math.random() * 10
            @maxSpeed = 3
            @speed = @maxSpeed*.5*Math.random() + @maxSpeed*.5
            
            
            # Image aléatoire
            @imageN = Math.floor(Math.random() * @image.height / @height)
            
            # Vitesse
            @vel.x = 0
            @vel.y = - Math.random() * 30 + 60
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
            
            @angle = Math.PI/3 * Math.cos(@t*3) * @speed
            @speed -= dt * @speed
            
            @updatePosition(dt)
            @parent.removeChild(@) if @isOffGameScreen()
        
        # Affichage
        handleDraw: ->
            @ctx.save()
            @ctx.globalAlpha = 0.7
            
            dist = (10 + Math.cos(@t*0.25) * 3 + @vel.y) * (1 - (1-@speed)/(1-@maxSpeed))
            
            @ctx.translate(@x + @width*.5, @y + @height*.5 - dist)
            @ctx.rotate(@angle)
            @ctx.drawImage(
                @image,
                0, @imageN * @height,
                @width,
                @height,
                0, dist,
                @width,
                @height)

            @ctx.restore()
