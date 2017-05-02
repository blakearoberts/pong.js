Spine   = require('spine')
$       = Spine.$

Graphic  = require('lib/graphic')
Cube     = require('lib/cube')
Utils    = require('lib/utils')
Input    = require('lib/input')

class Cubes extends Spine.Controller
  className: 'cubes'

  events:
    'click #addCube'     : 'addCube'
    'click #removeCube'  : 'removeCube'
    'click #removeAll'   : 'removeAll'
    'click #resetCamera' : 'resetCamera'

  elements:
    '#cubes'       : 'cubes'
    '#settings'    : 'settings'

  constructor: ->
    super
    @graphic = new Graphic(@width, @height, @animate)
    @graphic.camera.position.z = 10
    @graphic.camera.lookAt(new THREE.Vector3(0,0,0))
    @entities = []
    @centers = []
    for i in [1 .. 100]
      @addCube()
    @input = new Input()
    @active @change

  render: ->
    @html require('views/cubes')

  change: (params) =>
    @stack.Game.input.off()
    @stack.Game.graphic.stopAnimate()
    @input.on()
    @render()
    @graphic.render(@cubes)
    @graphic.animate()

  animate: =>
    for entity, i in @entities
      entity.orbit(
        entity.orbitCenter,
        new THREE.Vector3(-1, 0, 0),
        entity.orbitSpeed
      )
      entity.render()

  addCube: (e) =>
    e?.preventDefault()
    cube = new Cube()
    cube.color(Utils.randColorHex())
    cube.rotation.add(new THREE.Vector3(
      Utils.randInt(0, 3) / 100,
      Utils.randInt(0, 3) / 100,
      Utils.randInt(0, 3) / 100
    ))
    cube.position.add(new THREE.Vector3(
      Utils.randInt(-6, 6),
      Utils.randInt(-5, 5),
      Utils.randInt(-6, 6)
    ))
    cube.orbitCenter = new THREE.Vector3(
      Utils.randInt(-5, 5),
      Utils.randInt(-4, 4),
      Utils.randInt(-5, 5)
    )
    cube.orbitSpeed = Utils.randInt(0,3) / 100
    cube.id = @graphic.add(cube)
    @entities.push(cube)
    console.log('cube(' + cube.id + ') added...')

  removeCube: (e) =>
    console.log('cube(' + @entities[0].id + ') removed...')
    @graphic.remove(@entities[0])
    @entities.splice(0,1)
    e.preventDefault()

  removeAll: (e) =>
    e.preventDefault()
    @graphic.clear()
    @entities = []

  resetCamera: (e) =>
    e.preventDefault()
    @graphic.resetCamera()
    @graphic.camera.position.z = 10

  width: ->
    window.innerWidth

  height: ->
    window.innerHeight - 55

module.exports = Cubes
