define (require) ->
    
    HeroPlane = require 'cs!game/entities/planes/HeroPlane'
    
    class HeroPlaneC extends HeroPlane
        
        # Constructeur
        constructor: (@parent) ->
            super @parent
            
            @image = @game.assets.images.heroPlaneC
            
            # Tirs
            @gun.cadency = 0.25
            @gun.precision = 0.2
