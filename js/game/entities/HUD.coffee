define (require) ->
    
    Layer = require 'cs!game/core/entities/Layer'
    Entity = require 'cs!game/core/Entity'
    
    # Classe locale
    class Shell extends Entity
        constructor: (@parent, x, y) ->
            super @parent
            @x = x
            @y = y
            
            @width = 3
            @height = 15
            
            @weight = 250
            
            @vel =
                x: Math.random() * 100 - 50
                y: -400,
                ang: Math.random() * Math.PI * 4 - Math.PI * 2
        
        handleUpdate: (dt) ->
            @vel.y += @weight * dt * 9.81
            @angle += @vel.ang * dt
            @updatePosition(dt)          
            @parent.removeChild(@) if @isOffGameScreen()
            
        handleDraw: ->
            @ctx.save()
            @ctx.translate(@x + @width / 2, @y + @height / 2)
            @ctx.rotate(@angle)
            @ctx.fillRect(-@width / 2, -@height / 2, 3, 15)
            @ctx.restore()
    
    # HUD
    class HUD extends Layer
        
        # Constructeur
        constructor: (@parent) ->
            super @parent
            
            @gun = 
                ammo: null
        
        # Mise à jour
        # @param Number dt
        handleUpdate: (dt) ->
            @updateChildren(dt)
            
            if @parent.hero?
                ammo = @parent.hero.gun.ammo
                
                if ammo isnt @gun.ammo and @gun.ammo isnt null
                    for i in [ammo+1 .. @gun.ammo]
                        @addChild new Shell(@, 18 + i * 6, @parent.height - 18 - 15)
                
                @gun.ammo = ammo
                
        
        # Affichage de la scène
        handleDraw: ->
            @ctx.save()
            @ctx.fillStyle = 'rgba(47, 26, 10, 0.2)'
            
            @drawChildren()
            
            if @parent.hero? and @parent.hero.gun.ammo > 0
                ammo = @parent.hero.gun.ammo
                
                for i in [1 .. ammo]
                    @ctx.fillRect(18 + i * 6, @parent.height - 18 - 15, 3, 15)
                
                
            @ctx.restore()
        