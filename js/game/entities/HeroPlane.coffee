define (require) ->
    
    Plane = require 'cs!game/entities/Plane'
    
    class HeroPlane extends Plane
        
        # Constructeur
        constructor: (@scene) ->
            super(@scene)
            
            @image = @scene.game.assets.plane
            @x = 100
            @y = 100
            
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            kb = @scene.game.keyboard
            
            @goUp = kb.isDown(kb.UP)
            @goDown = kb.isDown(kb.DOWN)
            @goForward = kb.isDown(kb.RIGHT)
            @goBackward = kb.isDown(kb.LEFT)
            
            @updateVelocity(dt)
            @updateVelocityToKeepOnScreen(dt)
            @updatePosition(dt)