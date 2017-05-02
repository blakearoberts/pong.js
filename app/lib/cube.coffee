Entity = require('lib/entity')

class Cube extends Entity

  constructor: ->
    geometry = new THREE.BoxGeometry( 1, 1, 1 )
    @material = new THREE.MeshPhongMaterial({
      color: 0xffffff,
      polygonOffset: true,
      polygonOffsetFactor: 1,
      polygonOffsetUnits: 1
    })
    mesh = new THREE.Mesh( geometry, @material )
    geo = new THREE.EdgesGeometry( mesh.geometry )
    mat = new THREE.LineBasicMaterial({
      color: 0xffffff,
      linewidth: 2
    })
    wireframe = new THREE.LineSegments( geo, mat )
    @obj = new THREE.Object3D()
    @obj.add(mesh)
    @obj.add(wireframe)
    super

  color: (color) =>
    @obj.children[0].material.color.setHex(color)

module.exports = Cube
