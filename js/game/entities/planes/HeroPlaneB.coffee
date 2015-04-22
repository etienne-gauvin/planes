define (require) ->
    
    HeroPlane = require 'cs!game/entities/planes/HeroPlane'
    
    class HeroPlaneB extends HeroPlane
        
        # Constructeur
        constructor: (@parent) ->
            super @parent
            
            @imageN = 1
            
            # Tirs
            @gun.cadency = 0.10
            @gun.precision = 1.2
            