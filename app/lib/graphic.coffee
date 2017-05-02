require('lib/OrbitControls')

class Graphic

  constructor: (@width, @height, @animationCallback) ->
    @scene = new THREE.Scene()
    @light = new THREE.AmbientLight( 0x909090 )
    @scene.add( @light )
    @camera = new THREE.PerspectiveCamera( 75, @aspect(), 0.1, 100 )
    @camera.lookAt(new THREE.Vector3(0,0,0))
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize( @width(), @height() )
    @renderer.setClearColor( 0x909090 )
    @renderer.setPixelRatio( window.devicePixelRatio )
    @controls = new THREE.OrbitControls(
      @camera, @renderer.domElement)
    $(window).on 'resize', @windowSizeHandler

  resetCamera: =>
    @camera.position = new THREE.Vector3(0,0,0)
    @camera.rotation = new THREE.Vector3(0,0,0)
    @camera.lookAt(new THREE.Vector3(0,0,0))
    @controls.reset()

  render: (container) =>
    container.html(@renderer.domElement)

  add: (entity) =>
    @scene.add(entity.obj)
    @scene.children.length - 1

  remove: (entity) =>
    @scene.remove(entity.obj)

  clear: =>
    while @scene.children.length > 1
      @scene.remove(@scene.children[1])

  aspect: =>
    @width() / @height()

  animate: =>
    @id = requestAnimationFrame(@animate)
    @animationCallback()
    @renderer.render(@scene, @camera)

  stopAnimate: =>
    if @id then cancelAnimationFrame(@id)

  windowSizeHandler: =>
    @camera.aspect = @aspect()
    @camera.updateProjectionMatrix()
    @renderer.setSize(@width(), @height())

module.exports = Graphic
