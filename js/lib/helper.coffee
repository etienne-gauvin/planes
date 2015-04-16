define (require) ->
    {
        # Ease out
        easeout: (t, duration, startValue, endValue) ->
            t /= duration * 0.5

            if t < 1
                return endValue / 2 * t * t + startValue
            
            t--
            
            return - endValue / 2 * (t * (t - 2) - 1) + startValue
        
        # Collision boîte/point {x,y,height,width} et {x,y}
        testBoxPointCollision: (box, pt) ->
            pt.x >= box.x and pt.x <= box.x+box.width and pt.y >= box.y and pt.y <= box.y+box.height
    }