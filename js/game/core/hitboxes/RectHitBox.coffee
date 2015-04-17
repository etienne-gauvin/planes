define (require) ->
    'use strict'

    HitBox = require 'cs!game/core/HitBox'
    
    # Classe RectHitBox
    class RectHitBox extends HitBox
        
        # Constructeur
        constructor: (@parent, @x = 0, @y = 0, @width = 0, @height = 0) ->
            super @parent, @x, @y
        
        ## Méthodes effectuant une vérification
        ## (retournent un booléen)
        
        # Détermine si l'entité est hors du parent
        isCollidingWith: (hitBox) ->
            [thisX, thisY] = @abs()
            [thatX, thatY] = hitBox.abs()
            
            PointHitBox = require 'cs!game/core/hitboxes/PointHitBox'
            
            if hitBox instanceof PointHitBox
                return  thatX >= thisX and
                        thatY >= thisY and
                        thatX <= thisX+@width and
                        thatY <= thisY+@height
            
            else if hitBox instanceof RectHitBox
                r1 =
                    left: thisX
                    right: thisX + @width
                    top: thisY
                    bottom: thisY + @height
                r2 =
                    left: thatX
                    right: thatX + hitBox.width
                    top: thatY
                    bottom: thatY + hitBox.height
                
                return not (r2.left > r1.right or
                            r2.right < r1.left or
                            r2.top > r1.bottom or
                            r2.bottom < r1.top)
            
            else
                throw Error('Unknown hitbox type : ' + hitBox.type)