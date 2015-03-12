define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    
    class Plane extends Entity
        
        # Constructeur
        constructor: (@scene) ->
            super(@scene)
            
            # Spritesheet de l'avion
            @image = null
            
            # Dimensions
            @width =  24 * 3
            @height = 16 * 3
            
            # Limites de vitesse (en pixels/s)
            @minVSpeed = -250
            @maxVSpeed = 300
            
            # Booléens pour déplacer l'avion verticalement
            @goUp = no
            @goDown = no
            
            # Gain de vitesse lors du déplacement (en pixels/s^-1)
            @speedGainUphill = 700
            @speedGainDownhill = 800
            
            # Perte de vitesse lorsque pas de déplacement (en pixels/s^-1)
            @speedLossUphill = 600
            @speedLossDownhill = 500
            
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @updateVelocity(dt)
            @updatePosition(dt)
            
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            
            currentFrame = 0
            currentFrame = -Math.floor(@velY / @minVSpeed * 3) if @velY < 0
            currentFrame = Math.floor(@velY / @maxVSpeed * 3) if @velY > 0
            
            ctx.drawImage(@image,
                          0, @height * (currentFrame + 3),
                          @width, @height,
                          @x, @y,
                          @width, @height)
        
        
        # Appliquer le déplacement vertical
        updateVelocity: (dt) ->
            
            # Gagner de la vitesse si un déplacement vertival est demandé
            @velY += @speedGainDownhill * dt if @goDown
            @velY -= @speedGainUphill   * dt if @goUp
            
            # Appliquer une perte de vitesse si aucun sens de déplacement n'est demandé
            if not @goDown and not @goUp
                @velY += (@velY / @minVSpeed) * @speedLossUphill   * dt if @velY < 0
                @velY -= (@velY / @maxVSpeed) * @speedLossDownhill * dt if @velY > 0
            
            # Limiter la vitesse
            @velY = @maxVSpeed if @velY > @maxVSpeed
            @velY = @minVSpeed if @velY < @minVSpeed
            