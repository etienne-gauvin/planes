define (require) ->
    
    Plane = require 'cs!game/entities/Plane'
    
    class HeroPlane extends Plane
        
        # Constructeur
        # @param Scene @scene
        # @param String @version a|b|c
        constructor: (@scene) ->
            super @scene
            
            @x = @y = 0
            
            @image = @scene.game.assets.heroPlaneA
            
        
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