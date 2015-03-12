# Classe Object
define (require) ->
    class Object
        
        # Intégrer des mixins dans la classe
        @use = (mixins...) ->
            for mixin in mixins
                @::[key] = value for key, value of mixin::
            @
        