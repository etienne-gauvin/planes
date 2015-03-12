# Classe abstraite représentant une scène
define ['cs!game/scenes/Scene'], (Scene) ->
    class LoadingScene extends Scene
        
        # Progression du chargement
        handleProgress: ->
        
        # Progression du chargement
        handleFileLoad: ->
        
        # Chargement terminé
        handleComplete: ->
            console.log 'Chargement terminé'
            @game.switchToScene(@game.scenes.play)
        