define (require) ->
    
    HeroPlane = require 'cs!game/entities/planes/HeroPlane'
    
    class HeroPlaneA extends HeroPlane
        
        # Constructeur
        constructor: (@parent) ->
            super @parent
            
            @image = @game.assets.images.heroPlaneA
            
            # Tirs
            @gun.cadency = 0.15
            @gun.precision = 0.5