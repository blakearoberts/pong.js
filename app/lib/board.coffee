Entity = require('lib/entity')

class Board extends Entity

  constructor: ->
    length = 40
    width = 15
    @obj = new THREE.Object3D()

    bottomPos = new THREE.Vector3(0, 0, 0)
    bottomSide = @getSide(length, width, bottomPos)
    @bottom = new THREE.Box3()
    @bottom.setFromObject(bottomSide)
    @obj.add(bottomSide)

    frontPos = new THREE.Vector3(0, 0.5, (width - 0.5) / 2)
    frontSide = @getSide(length, 0.5, frontPos)
    @front = new THREE.Box3()
    @front.setFromObject(frontSide)
    @obj.add(frontSide)


    backPos = new THREE.Vector3(0, 0.5, (0.5 - width) / 2)
    backSide = @getSide(length, 0.5, backPos)
    @back = new THREE.Box3()
    @back.setFromObject(backSide)
    @obj.add(backSide)

    rightPos = new THREE.Vector3((length - 0.5) / 2, 0.5, 0)
    rightSide = @getSide(0.5, width, rightPos)
    @right = new THREE.Box3()
    @right.setFromObject(rightSide)
    @obj.add(rightSide)

    leftPos = new THREE.Vector3((0.5 - length) / 2, 0.5, 0)
    leftSide = @getSide(0.5, width, leftPos)
    @left = new THREE.Box3()
    @left.setFromObject(leftSide)
    @obj.add(leftSide)

    super

  getSide: (length, width, pos) ->
    geo1 = new THREE.BoxGeometry( length, 0.5, width )
    mat1 = new THREE.MeshPhongMaterial({
      color: 0x000000,
      polygonOffset: true,
      polygonOffsetFactor: 1,
      polygonOffsetUnits: 1
    })
    mesh = new THREE.Mesh( geo1, mat1 )
    geo2 = new THREE.EdgesGeometry( mesh.geometry )
    mat2 = new THREE.LineBasicMaterial({
      color: 0xffffff,
      linewidth: 1
    })
    wireframe = new THREE.LineSegments( geo2, mat2 )
    base = new THREE.Object3D()
    base.add(mesh)
    base.add(wireframe)
    base.position.add(pos)
    base

module.exports = Board
