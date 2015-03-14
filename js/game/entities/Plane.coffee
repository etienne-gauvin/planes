define (require) ->
    
    Entity = require 'cs!game/entities/Entity'
    floor = Math.floor
    
    class Plane extends Entity
        
        # Constructeur
        constructor: (@scene) ->
            super @scene
            
            # Spritesheet de l'avion
            @image = null
            
            # Dimensions
            @width =  24 * 3
            @height = 16 * 3
            
            # Limites de vitesse (en pixels/s)
            @minVSpeed = -250
            @maxVSpeed = 300
            @minHSpeed = -300
            @maxHSpeed = 200
            
            # Booléens pour déplacer l'avion verticalement
            @goUp = @goDown = @goForward = @goBackward = no
            
            # Gain de vitesse lors du déplacement (en pixels/s^-1)
            @speedGainUphill = 900
            @speedGainDownhill = 1000
            @speedGainForward = 500
            @speedGainBackward = 1000
            
            # Perte de vitesse lorsque pas de déplacement (en pixels/s^-1)
            @speedLossUphill = 600
            @speedLossDownhill = 500
            @speedLossForward = 600
            @speedLossBackward = 600
            
            # Représentation de la vitesse verticale de l'avion (read only)
            # comprise entre -1 (min) et 1 (max)
            @set 'vSpeedPercentage', ->
            @get 'vSpeedPercentage', =>
                vSpeedPercentage = - @velY / @minVSpeed if @velY < 0
                vSpeedPercentage =   @velY / @maxVSpeed if @velY > 0
                return vSpeedPercentage or 0
            
            # Retourne le numéro de frame actuel selon la vitesse verticale (read only)
            @set 'frame', ->
            @get 'frame', => floor(@vSpeedPercentage * 3 + 0.5)
            
            # Retourne l'angle actuel en degrés selon la vitesse verticale (read only)
            @set 'angle', ->
            @get 'angle', => @vSpeedPercentage * 12
            
            
                
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @updateVelocity(dt)
            @updatePosition(dt)
            
        
        # Affichage
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            
            ctx.save()
            ctx.translate(floor(@x + @width * 0.5), floor(@y + @height * 0.5))
            ctx.rotate(@frame/3*15 * Math.PI / 180)
            ctx.translate(floor(- @width * 0.5), floor(- @height * 0.5))
            
            ctx.drawImage(@image,
                          0, @height * (@frame + 3),
                          @width, @height,
                          0, 0,
                          @width, @height)
            
            ctx.restore()
        
        
        # Appliquer le déplacement vertical
        updateVelocity: (dt) ->
            
            # Gagner de la vitesse si un déplacement horizantal est demandé
            @velY += @speedGainDownhill * dt if @goDown
            @velY -= @speedGainUphill   * dt if @goUp
            @velX += @speedGainForward  * dt if @goForward
            @velX -= @speedGainBackward * dt if @goBackward
            
            # Appliquer une perte de vitesse si aucun sens de déplacement n'est demandé
            if not @goDown and not @goUp
                @velY += (@velY / @minVSpeed) * @speedLossUphill   * dt if @velY < 0
                @velY -= (@velY / @maxVSpeed) * @speedLossDownhill * dt if @velY > 0
            
            if not @goForward and not @goBackward
                @velX += (@velX / @minHSpeed) * @speedLossForward   * dt if @velX < 0
                @velX -= (@velX / @maxHSpeed) * @speedLossBackward  * dt if @velX > 0
            
            # Limiter la vitesse
            @velY = @maxVSpeed if @velY > @maxVSpeed
            @velY = @minVSpeed if @velY < @minVSpeed
            @velX = @maxHSpeed if @velX > @maxHSpeed
            @velX = @minHSpeed if @velX < @minHSpeed
        