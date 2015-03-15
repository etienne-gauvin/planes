# Classe abstraite représentant une scène
define (require) ->
    
    easeout = require('cs!helper').easeout
    
    Scene = require 'cs!game/scenes/Scene'
    Background = require 'cs!game/entities/Background'
    
    HeroPlaneA = require 'cs!game/entities/HeroPlaneA'
    HeroPlaneB = require 'cs!game/entities/HeroPlaneB'
    HeroPlaneC = require 'cs!game/entities/HeroPlaneC'
    
    class PlayScene extends Scene
        
        # Démarrage de la scène
        handleStart: ->
            @width = @game.canvas.width
            @height = @game.canvas.height
            
            # Layer d'affichage du HUD
            # Pour éviter de le recalculer à chaque frame
            @hud = null
            @markHUDForUpdate = yes
            
            # Fond
            @addChild new Background @
            
            # Joueur principal
            @hero = new HeroPlaneA @
            @hero.y = @game.canvas.height*.5 - @hero.height*.5
            @addChild @hero
        
        # Mise à jour de la scène
        # @param Number dt
        handleUpdate: (dt) ->
            super dt
            
            if @game.t < 1
                @hero.x = easeout(@game.t, 1, - @hero.width, @hero.width * 2)
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw: (ctx) ->
            ctx.save()
            ctx.fillStyle = '#bbedf3'
            ctx.fillRect(0, 0, @game.canvas.width, @game.canvas.height)
            ctx.restore()
            
            @drawEntities(ctx)
            
            if @markHUDForUpdate
                @markHUDForUpdate = no
                @game.hudctx.clearRect(0, 0, @width, @height)
                @drawHUD(@game.hudctx)
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
            if event.keyCode is @game.keyboard.C
                @removeChild @hero
                x = @hero.x
                y = @hero.y
                velX = @hero.velX
                velY = @hero.velY
                
                if @hero instanceof HeroPlaneA
                    @hero = new HeroPlaneB @
                else if @hero instanceof HeroPlaneB
                    @hero = new HeroPlaneC @
                else
                    @hero = new HeroPlaneA @
                
                @hero.x = x
                @hero.y = y
                @hero.velX = velX
                @hero.velY = velY
                
                @addChild @hero
        
        # Mettre à jour l'HUD
        drawHUD: (ctx) ->
            ctx.save()
            
            ctx.fillStyle = 'rgba(29, 19, 12, 0.8)'
            for i in [1..@hero.ammo]
                ctx.fillRect(18 + i * 6, @height - 18 - 9, 3, 9)
            
            ctx.restore()
        