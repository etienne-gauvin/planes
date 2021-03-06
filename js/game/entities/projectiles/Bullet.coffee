define (require) ->
    
    Entity = require 'cs!game/core/Entity'
    PointHitBox = require 'cs!game/core/hitboxes/PointHitBox'
    floor = Math.floor
    
    class Bullet extends Entity
        
        # Constructeur
        constructor: (@parent, @plane, angle) ->
            super @parent
            
            @type = 'bullet'
            
            @angle = angle
            
            @x = @plane.x + @plane.width + 3
            @y = @plane.y + @plane.height / 2 + (@plane.getYSpeedPercentage() + 0.1) * 16
            
            # Vitesse (en pixels/s)
            @speed = 800
            
            # Longueur visible
            @length = 21
            
            # Vélocité
            @vel.x = Math.cos(@angle/3*15 * Math.PI/180) * @speed
            @vel.y = Math.sin(@angle/3*15 * Math.PI/180) * @speed
            
            # Hitbox
            @hitBox = new PointHitBox @
        
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @updatePosition(dt)
            
            # Destrcution si sortie de l'écran
            if @isOffGameScreen()
                @parent.removeChild @
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: ->
            @ctx.save()
            @ctx.translate(@x + @length*.5, @y)
            @ctx.rotate(@angle/3*15 * Math.PI/180)
            @ctx.translate(floor(-@length*.5), 0)
            @ctx.fillStyle = 'rgb(255, 255, 0)'
            @ctx.fillRect(0, 0, @length, 3)
            @ctx.restore()
        
        