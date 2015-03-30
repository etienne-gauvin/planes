# Classe représentant le clavier (destinée à n'être instanciée qu'une seule fois)
define ->
    class Keyboard
        constructor: ->
            # Constantes
            @UP     = 38
            @DOWN   = 40
            @RIGHT  = 39
            @LEFT   = 37
            
            @Z      = 90
            @Q      = 81
            @S      = 83
            @D      = 68
            
            @SPACE  = 32
            @C      = 67
            
            # Témoins de pression
            @keys = []
            
        # Vérifier si une touche est enfoncée
        isDown: (keyCode) -> @keys[keyCode]
        