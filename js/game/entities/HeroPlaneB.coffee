define (require) ->
    
    HeroPlane = require 'cs!game/entities/HeroPlane'
    
    class HeroPlaneB extends HeroPlane
        
        # Constructeur
        # @param Scene @scene
        # @param String @version a|b|c
        constructor: (@scene) ->
            super @scene
            
            @image = @scene.game.assets.heroPlaneB
            
            # Limites de vitesse (en pixels/s)
            @minVSpeed = -300
            @maxVSpeed = 350
            @minHSpeed = -250
            @maxHSpeed = 250
            
            # Gain de vitesse lors du déplacement (en pixels/s^-1)
            @speedGainUphill = 500
            @speedGainDownhill = 500
            @speedGainForward = 700
            @speedGainBackward = 1000
            