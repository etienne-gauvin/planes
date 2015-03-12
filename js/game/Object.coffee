# Classe Object
define (require) ->
    class Object
        
        # Intégrer des mixins dans la classe
        @use = (mixins...) ->
            for mixin in mixins
                @::[key] = value for key, value of mixin::
            @
        
        get: (key, f) ->
            @__defineGetter__ key, f
            
        set: (key, f) ->
            @__defineSetter__ key, f