Entity = require('lib/entity')

class Paddle extends Entity

  constructor: (color, @bounds) ->
    @length = 3
    @width = 0.5
    @geometry = new THREE.BoxGeometry( @width, 0.5, @length )
    mat1 = new THREE.MeshPhongMaterial({
      color: color,
      polygonOffset: true,
      polygonOffsetFactor: 1,
      polygonOffsetUnits: 1
    })
    mesh = new THREE.Mesh( @geometry, mat1 )
    geo2 = new THREE.EdgesGeometry( mesh.geometry )
    mat2 = new THREE.LineBasicMaterial({
      color: 0xffffff,
      linewidth: 1.5
    })
    wireframe = new THREE.LineSegments( geo2, mat2 )
    @obj = new THREE.Object3D()
    @obj.add(mesh)
    @obj.add(wireframe)
    super

  getBounds: =>
    bounds = new THREE.Box3()
    bounds.setFromObject(@obj)
    bounds

module.exports = Paddle
