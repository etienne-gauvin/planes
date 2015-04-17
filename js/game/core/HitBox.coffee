define (require) ->
    'use strict'

    Object = require 'cs!game/core/Object'
    
    # Classe HitBox abstraite
    class HitBox extends Object
        
        # Constructeur
        constructor: (@parent, @x = 0, @y = 0) ->
            @type = ''
        
        # Retourne la position absolue de l'entité sous la forme
        abs: -> [ @parent.centerX + @x, @parent.centerY + @y ]