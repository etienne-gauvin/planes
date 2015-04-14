define (require) ->
    
    HeroPlane = require 'cs!game/entities/HeroPlane'
    
    class HeroPlaneB extends HeroPlane
        
        # Constructeur
        constructor: (@parent) ->
            super @parent
            
            @image = @game.assets.images.heroPlaneB
            
            # Tirs
            @gun.cadency = 0.10
            @gun.precision = 1.2
            