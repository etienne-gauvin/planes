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
                return thatX >= thisX and thatY >= thisY and thatX <= thisX+@width and thatY <= thisY+@height
            
            else if hitBox instanceof RectHitBox
                a = new PointHitBox @parent, @x, @y
                b = new PointHitBox @parent, @x + @width, @y
                c = new PointHitBox @parent, @x + @width, @y + @height
                d = new PointHitBox @parent, @x, @y + @height
                
                return hitBox.isCollidingWith(a) or hitBox.isCollidingWith(b) or hitBox.isCollidingWith(c) or hitBox.isCollidingWith(d)
                    
            
            else
                throw Error('Unknown hitbox type : ' + hitBox.type)