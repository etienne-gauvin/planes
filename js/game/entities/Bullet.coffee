define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    floor = Math.floor
    
    class Plane extends Entity
        
        # Constructeur
        constructor: (@scene, @plane) ->
            super @scene
            
            @x = @plane.x + @plane.width + 3
            @y = @plane.y + @plane.height / 2 + (@plane.vSpeedPercentage + 0.1) *   16
            
            # Vitesse (en pixels/s)
            @speed = 1000
            
            # Angle
            @angle = @plane.angle
            
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
            ctx.translate(@x + 4.5, @y)
            ctx.rotate(@angle/3*15 * Math.PI/180)
            ctx.translate(floor(-4.5), 0)
            ctx.fillRect(0, 0, 9, 3)
            ctx.restore()
        
        