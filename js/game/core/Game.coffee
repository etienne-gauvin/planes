define (require) ->

    Entity = require 'cs!game/core/Entity'
    Keyboard = require 'cs!game/core/Keyboard'
    
    class Game extends Entity
        # Constructeur
        constructor: (@config) ->
            
            @game = @
            @canvas = document.getElementById('canvas')
            @ctx = @canvas.getContext('2d')
            
            super @
            
            # Dimensions
            @width = @canvas.width
            @height = @canvas.height
            
            # Temps écoulé depuis le démarrage du jeu
            @t = 0
            
            # Vitesse du jeu (<1=ralenti, 1=normal, >1=rapide)
            @speed = 1
            
            # Images, sons, etc.
            @assets = @config.assets.tree
            
            # Représentation du clavier
            @keyboard = new Keyboard @
            
            # Scenes
            @scenes = {}
            
            # Scene actuelle
            @scene = null
            
            # Pause
            @pause = no
            
            # Activation du son
            @get 'muted', => !!(localStorage.getItem("muted") is 'muted')
            @set 'muted', (muted) =>
                if muted
                    document.querySelector('.sound-mute-toggle .mute').classList.add('hidden');
                    document.querySelector('.sound-mute-toggle .unmute').classList.remove('hidden');
                    localStorage.setItem('muted', 'muted');
                    createjs.Sound.setMute(true);

                # Activer le son
                else
                    document.querySelector('.sound-mute-toggle .mute').classList.remove('hidden');
                    document.querySelector('.sound-mute-toggle .unmute').classList.add('hidden');
                    localStorage.setItem('muted', '');
                    createjs.Sound.setMute(false);
            
        
        # Démarrer le jeu
        start: ->
            # Application des écouteurs clavier
            window.addEventListener 'keydown', (e) => @handleKeyDown(e)
            window.addEventListener 'keyup', (e) => @handleKeyUp(e)
            
            # Changement de la visibilité de la fenêtre
            document.addEventListener "visibilitychange", => @handleVisibilityChange(not document.hidden)
            
            # File de chargement des assets
            loadQueue = new createjs.LoadQueue()
            loadQueue.installPlugin(createjs.Sound);
            manifest = @populateManifest([], @config.assets.tree)
            loadQueue.loadManifest(manifest, false, @config.assets.basepath)
            
            # A la fin du chargement, lancer le jeu
            loadQueue.on "complete", (e) => @handleLoadComplete(e)
            loadQueue.on "progress", (e) => @handleLoadProgress(e)
            loadQueue.on "fileload", (e) => @handleFileLoad(e)

            # Lancement du chargement
            @scenes.loading.handleStart()
            loadQueue.load()
            
            # Création du ticker
            dt = 0
            lastTime = (new Date).getTime()
            anim = =>
                now = (new Date).getTime()
                dt = now - lastTime
                lastTime = now
                @handleUpdate(dt / 1000 * @speed)
                window.requestAnimationFrame anim
            
            window.requestAnimationFrame anim
            
        
        # Mise à jour du jeu puis de l'affichage
        handleUpdate: (dt) ->
            if not @pause
                @t += dt
                @scene.handleUpdate(dt) if @scene
            
            @scene.handleDraw(@ctx) if @scene
        
        # Lors de l'appui sur une touche
        handleKeyDown: (event) ->
            event.preventDefault() if event.keyCode < 100
            @keyboard.keys[event.keyCode] = true
            @scene.handleKeyDown(event) if @scene

        # Lors du relâchement d'une touche
        handleKeyUp: (event) ->
            @keyboard.keys[event.keyCode] = false
            @scene.handleKeyUp(event) if @scene
        
        # Lors changement de visibilité de la fenêtre
        handleVisibilityChange: (visible) ->
            @pause = not visible
        
        # Progression du chargement
        handleLoadProgress: (e) ->
        
        # Progression du chargement
        handleFileLoad: (e) ->
            @placeAsset(@assets, e.item.id, e.result)
        
        # Chargement terminé
        handleLoadComplete: (e) ->
        
        # Changer de scène
        switchToScene: (scene) ->
            if @scene
                @scene.handleStop =>
                    @scene = scene
                    @scene.handleStart()
            else
                @scene = scene
                @scene.handleStart()
        
        # Couper le son
        mute: ->
            document.querySelector('.sound-mute-toggle .mute').classList.remove('hidden');
            document.querySelector('.sound-mute-toggle .unmute').classList.add('hidden');
            muted = yes
            localStorage.setItem('muted', 'muted');
            createjs.Sound.setMute(true);
        
        # Activer le son
        unmute: ->
            document.querySelector('.sound-mute-toggle .mute').classList.add('hidden');
            document.querySelector('.sound-mute-toggle .unmute').classList.remove('hidden');
            muted = no
            localStorage.setItem('muted', '');
            createjs.Sound.setMute(false);
        
        # Créer le manifest d'après la configuration
        populateManifest: (manifest, tree, path = '') ->
            for filename, value of tree
                if typeof value is 'object'
                    manifest = @populateManifest(manifest, value, path + filename + '/')
                else if typeof value is 'string'
                    f = path + filename + value
                    tree[filename] = f
                    manifest.push { id: f, src: f }
        
            return manifest
        
        # Placer une ressource à sa place dans le tableau des assets
        placeAsset: (assets, id, asset) ->
            for filename, value of assets
                if value == id
                    assets[filename] = asset
                    return true
                else if value.constructor is Object
                    return true if @placeAsset(value, id, asset)
            
            return false