define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    floor = Math.floor
    
    class Plane extends Entity
        
        # Constructeur
        constructor: (@scene, @plane, @angle) ->
            super @scene
            
            @x = @plane.x + @plane.width + 3
            @y = @plane.y + @plane.height / 2 + (@plane.vSpeedPercentage + 0.1) *   16
            
            # Vitesse (en pixels/s)
            @speed = 800
            
            # Longueur visible
            @length = 15
            
            # Vélocité
            @velX = Math.cos(@angle/3*15 * Math.PI/180) * @speed
            @velY = Math.sin(@angle/3*15 * Math.PI/180) * @speed
        
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @updatePosition(dt)
            
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            
            ctx.save()
            ctx.translate(@x + @length*.5, @y)
            ctx.rotate(@angle/3*15 * Math.PI/180)
            ctx.translate(floor(-@length*.5), 0)
            ctx.fillStyle = 'rgba(255, 108, 0, 0.8)'
            ctx.fillRect(0, 0, @length, 3)
            ctx.restore()
        
        