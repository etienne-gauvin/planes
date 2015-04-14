define (require) ->
    'use strict'
    
    easeout = require('cs!helper').easeout
    
    Scene = require 'cs!game/core/entities/Scene'
    HUD = require 'cs!game/entities/HUD'
    Background = require 'cs!game/entities/Background'
    
    HeroPlaneA = require 'cs!game/entities/HeroPlaneA'
    HeroPlaneB = require 'cs!game/entities/HeroPlaneB'
    HeroPlaneC = require 'cs!game/entities/HeroPlaneC'
    
    class PlayScene extends Scene
        
        # Démarrage de la scène
        handleStart: ->
            @width = @game.width
            @height = @game.height
            
            # Layer d'affichage du HUD
            # Pour éviter de le recalculer à chaque frame
            @hud = new HUD @
            
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
            
            if @hero and @game.t < 1
                @hero.x = easeout(@game.t, 1, - @hero.width, @hero.width * 2)
            
            @hud.handleUpdate(dt)
        
        # Affichage de la scène
        # @param CanvasRenderingContext2D
        handleDraw:  ->
            @ctx.save()
            @ctx.fillStyle = '#bbedf3'
            @ctx.fillRect(0, 0, @game.canvas.width, @game.canvas.height)
            @ctx.restore()
            
            super
            
            @hud.handleDraw()
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
            if event.keyCode is @game.keyboard.C
                @removeChild @hero
                x = @hero.x
                y = @hero.y
                
                vel =
                    x: @hero.vel.x
                    y: @hero.vel.y
                
                if @hero instanceof HeroPlaneA
                    @hero = new HeroPlaneB @
                else if @hero instanceof HeroPlaneB
                    @hero = new HeroPlaneC @
                else
                    @hero = new HeroPlaneA @
                
                @hero.x = x
                @hero.y = y
                @hero.vel.x = vel.x
                @hero.vel.y = vel.y
                
                @addChild @hero