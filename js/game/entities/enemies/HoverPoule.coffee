define (require) ->
    'use strict'
    
    Entity = require 'cs!game/core/Entity'
    RectHitBox = require 'cs!game/core/hitboxes/RectHitBox'
    HoverPouleExplosion = require 'cs!game/entities/effects/HoverPouleExplosion'
    floor = Math.floor
    
    class HoverPoule extends Entity
        
        # Constructeur
        constructor: (@parent, @x, @y) ->
            super @parent
            
            @type = 'hoverpoule'
            
            # Spritesheet
            @image = @game.assets.images.hoverPoule
            
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
            
            # Vitesse et déplacement de l'hoverpoule
            @t = Math.random() * 10
            @waveAmplitude = 10 
            @waveVSpeed = 0.4
            
            # Hitbox
            @hitBox = new RectHitBox @, -5 * 3, -7 * 3, 10 * 3, 12 * 3
            
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @t += dt
            
            @updateVelocity(dt)
            @updatePosition(dt)
            @updateGun(dt)
            @updateChildren(dt)
            
            if not @destroyed and @parent.collections.bullet?
                bullets = @parent.collections.bullet
                
                for bullet in bullets
                    if bullet? and @hitBox.isCollidingWith(bullet.hitBox)
                        @explode()
                        @parent.removeChild bullet
            
            if @health <= 0 
                if not @destroyed
                    @explode()
                
                else if @isOffGameScreen()
                    @parent.removeChild @
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: ->
            
            frame = 0
            frame = 1 if @vel.y < 0
            
            @ctx.save()
            @ctx.translate(floor(@x), floor(@y))
            
            @ctx.drawImage(@image,
                          @width * Math.floor((@t*30)%2), @height * frame,
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
            
            @vel.y = Math.cos(@t * @waveVSpeed) * @waveAmplitude
            #@updateVelocityToKeepOnScreen()
            
            # Faire tomber
            if @destroyed
                @vel.y += dt * 700
            
        # Tirer si nécessaire
        updateGun: (dt) ->
            @gun.lastShoot += dt
            if @gun.shoot and @gun.lastShoot >= @gun.cadency
                @gun.lastShoot = 0
        
        # Explosion
        explode: ->
            @destroyed = yes
            @parent.addChild new HoverPouleExplosion @parent, @centerX, @centerY
            @parent.removeChild @