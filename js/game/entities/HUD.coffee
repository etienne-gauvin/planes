define (require) ->
    
    Layer = require 'cs!game/core/entities/Layer'
    Shell = require 'cs!game/entities/hudentities/HUDShell'
    
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
        