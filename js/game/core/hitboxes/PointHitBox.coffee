define (require) ->
    'use strict'

    HitBox = require 'cs!game/core/HitBox'
    
    # Classe PointHitBox
    class PointHitBox extends HitBox
        
        # Constructeur
        constructor: (@parent, @x = 0, @y = 0) ->
            super @parent, @x, @y
        
        ## Méthodes effectuant une vérification
        ## (retournent un booléen)
        
        # Détermine si l'entité est hors du parent
        isCollidingWith: (hitBox) ->
            [thisX, thisY] = @abs()
            [thatX, thatY] = hitBox.abs()
            
            RectHitBox = require 'cs!game/core/hitboxes/RectHitBox'
            
            if hitBox instanceof RectHitBox
                return hitBox.isCollidingWith(@)
            
            else if hitBox instanceof PointHitBox
                return thatX is thisX and thatY is thisY
            
            else
                throw Error('Unknown hitbox type : ' + hitBox.type)
            