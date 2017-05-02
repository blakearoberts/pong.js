class Utils

  @randInt: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @randNum: (min, max) ->
    (Math.random() * (max - min + 1)) + min

  @randBool: ->
    if Math.floor(Math.random() * 10) % 2 is 0 then false else true

  @randColorHex: =>
    color = '0x'
    rgb = @randInt(0,2) * 2 + 1
    rgb2 = @randInt(0,2) * 2 + 1
    for i in [0 .. 5]
      if rgb is i or rgb is i + 1
        color += 'f'
      else if rgb2 is i or rgb2 is i + 1
        color += @randInt(10,15).toString(16)
      else
        color += '0'
    parseInt(color)

module.exports = Utils
