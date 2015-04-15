define (require) ->
    'use strict'
    
    Entity = require 'cs!game/core/Entity'
    floor = Math.floor
    
    class HoverPoule extends Entity
        
        # Constructeur
        constructor: (@parent, x, y) ->
            super @parent
            
            # Spritesheet
            @image = @game.assets.images.hoverPoule
            
            # Position
            @x = x
            @y = y
            
            # Dimensions
            @width = @height = 24 * 3
            
            # Vitesse
            @vel =
                x: -50
                y: @vel.y
            
            # Angle (rad)
            @angle = 0
            
            # Mitrailleuse
            @gun =
                cadency: 0.15
                lastShoot: 0
            
            # Santé
            @health = 100
            @destroyed = no
            
            # t
            @t = 0
            
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
            
            @updateVelocity(dt)
            @updatePosition(dt)
            @updateGun(dt)
            @updateHealth(dt)
            @updateChildren(dt)
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: ->
            
            frame = 0
            frame = 1 if @vel.y < 0
            
            @ctx.save()
            @ctx.translate(floor(@x - @width * 0.5), floor(@y - @height * 0.5))
            
            @ctx.drawImage(@image,
                          0, @height * frame,
                          @width, @height,
                          0, 0,
                          @width, @height)
            
            @drawChildren()
            
            if @destroyed
                @ctx.globalCompositeOperation = 'difference'
                @ctx.globalAlpha = 0.6
                @ctx.drawImage(@image,
                              0, @height * (frame + 3),
                              @width, @height,
                              0, 0,
                              @width, @height)
            
            @ctx.restore()
    
            
        
        # Appliquer le déplacement vertical
        updateVelocity: (dt) ->
            
            @vel.y = Math.cos(@t) * 100
            
            # Faire tomber
            if @destroyed
                @vel.y += dt * 700
            
        # Tirer si nécessaire
        updateGun: (dt) ->
            @gun.lastShoot += dt
            if @gun.shoot and @gun.lastShoot >= @gun.cadency
                @gun.lastShoot = 0
        
        # Gérer la santé de l'avion
        updateHealth: (dt) ->
            if @health <= 0 
                if not @destroyed
                    #@explode()
                
                else if @isOffGameScreen()
                    @parent.removeChild @
        