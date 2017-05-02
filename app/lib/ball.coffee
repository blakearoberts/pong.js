Entity = require('lib/entity')
Utils  = require('lib/utils')

class Ball extends Entity

  constructor: () ->
    geometry = new THREE.SphereGeometry( 0.25, 32, 32 )
    material = new THREE.MeshBasicMaterial( {color: 0xffffff} )
    @obj = new THREE.Mesh( geometry, material )
    super
    speed = 0.4
    direction = Utils.randNum(0, Math.PI)
    @velocity.set(speed * Math.cos(direction), 0, speed * Math.sin(direction))

  hitWall: (dir) ->
    @velocity[dir] = - @velocity[dir]

  getBounds: =>
    new THREE.Sphere(new THREE.Vector3(@x(), @y(), @z()), 0.25)

module.exports = Ball
