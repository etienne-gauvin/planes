define (require) ->
    'use strict'
    
    Entity = require 'cs!game/core/Entity'
    testBoxPointCollision = require('cs!helper').testBoxPointCollision
    floor = Math.floor
    
    class HoverPoule extends Entity
        
        # Constructeur
        constructor: (@parent, x, y) ->
            super @parent
            
            # Spritesheet
            @image = @game.assets.images.hoverPoule
            
            # Explosion
            @explosionImage = @game.assets.images.hoverPouleExplosion
            @explosionDuration = 0.4
            
            # Position
            @x = x
            @y = y
            
            # Dimensions
            @width = @height = 24 * 3
            
            # Dimensions de la hitBox
            @hitBoxWidth = @hitBoxHeight = 10 * 3
            
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
            
            if not @destroyed
                frame = 0
                frame = 1 if @vel.y < 0
                
                image = @image
            else
                frame = Math.floor(@explosionImage.height / @height * @t / @explosionDuration)
                image = @explosionImage
                
            @ctx.save()
            @ctx.translate(floor(@centerX - @width * 0.5), floor(@centerY - @height * 0.5))
            
            @ctx.drawImage(image,
                          0, @height * frame,
                          @width, @height,
                          0, 0,
                          @width, @height)
            
            @drawChildren()
            
            @ctx.restore()
            
            ###@ctx.fillStyle = "rgba(255, 0, 255, 0.5)"
            @ctx.fillRect(
                @centerX - @hitBoxWidth*.5,
                @centerY - @hitBoxHeight*.5,
                @hitBoxWidth,
                @hitBoxHeight
            )###
            
    
            
        
        # Appliquer le déplacement vertical
        updateVelocity: (dt) ->
            if not @destroyed
                @vel.y = Math.cos(@t) * 100
            else
                @vel.y = 0
            
        # Tirer si nécessaire
        updateGun: (dt) ->
            @gun.lastShoot += dt
            if @gun.shoot and @gun.lastShoot >= @gun.cadency
                @gun.lastShoot = 0
        
        # Gérer la santé
        updateHealth: (dt) ->
            
            if not @destroyed and @parent.collections.bullet
                bullets = @parent.collections.bullet
                
                for bullet in bullets
                    if bullet?
                        @explode() if testBoxPointCollision(
                            #{ x: @x, y: @y, width: 24, height: 24 },
                            {
                                x: @centerX - @hitBoxWidth*.5,
                                y: @centerY - @hitBoxHeight*.5,
                                width: @hitBoxWidth,
                                height: @hitBoxHeight
                            },
                            { x: bullet.x, y: bullet.y }
                        )
            
            if @health <= 0 
                if not @destroyed
                    #@explode()
                
                else if @isOffGameScreen() or @destroyed and @t > @explosionDuration
                    @parent.removeChild @
        
        # Faire exploser
        explode: ->
            @health = 0
            @destroyed = yes
            
            @vel.x = @vel.y = 0
            @t = 0