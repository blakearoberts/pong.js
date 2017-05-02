class Entity

  constructor: () ->
    @position = new THREE.Vector3()
    @velocity = new THREE.Vector3()
    @acceleration = new THREE.Vector3()
    @rotation = new THREE.Vector3()

  x: (x, clear) ->
    if clear
      unless x then @position.x = 0
      else @position = x
    else if x then @position.x += x
    else @position.x

  y: (y, clear) ->
    if clear
      unless y then @position.y = 0
      else @position = y
    else if y then @position.y += y
    else @position.y

  z: (z, clear) ->
    if clear
      unless z then @position.z = 0
      else @position = z
    else if z then @position.z += z
    else @position.z

  move: =>
    @velocity.add( @acceleration )
    @position.add( @velocity )

  pos: =>
    [@position.x, @position.y, @position.z]

  vel: =>
    [@velocity.x, @velocity.y, @velocity.z]

  acc: =>
    [@acceleration.x, @acceleration.y, @acceleration.z]

  rotate: (x, y, z) =>
    @rotation = new THREE.Vector3(x, y, z)

  orbit: (center, pos, speed) =>
    axis = center.clone().sub(pos).normalize()
    @position.applyAxisAngle(axis, speed)

  render: =>
    @obj.position.copy(@position)
    @obj.rotation.x += @rotation.x
    @obj.rotation.y += @rotation.y
    @obj.rotation.z += @rotation.z

module.exports = Entity
