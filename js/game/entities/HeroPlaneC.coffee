define (require) ->
    
    HeroPlane = require 'cs!game/entities/HeroPlane'
    
    class HeroPlaneC extends HeroPlane
        
        # Constructeur
        # @param Scene @scene
        # @param String @version a|b|c
        constructor: (@scene) ->
            super @scene
            
            @image = @scene.game.assets.heroPlaneC
            
            # Limites de vitesse (en pixels/s)
            @minVSpeed = -250
            @maxVSpeed = 300
            @minHSpeed = -300
            @maxHSpeed = 200
            
            # Gain de vitesse lors du déplacement (en pixels/s^-1)
            @speedGainUphill = 900
            @speedGainDownhill = 1000
            @speedGainForward = 500
            @speedGainBackward = 1000
            
            # Cadence de tir
            @gunShootCadency = 0.18
            @gunPrecision = 0.2
