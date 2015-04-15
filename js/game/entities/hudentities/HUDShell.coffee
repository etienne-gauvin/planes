define (require) ->
    
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
    