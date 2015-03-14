define (require) ->
    
    HeroPlane = require 'cs!game/entities/HeroPlane'
    
    class HeroPlaneC extends HeroPlane
        
        # Constructeur
        # @param Scene @scene
        # @param String @version a|b|c
        constructor: (@scene) ->
            super @scene
            
            @image = @scene.game.assets.heroPlaneC
            