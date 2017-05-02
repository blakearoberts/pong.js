class Input

  constructor: ->
    @keys = []

  on: =>
    $(document).on 'keyup', @keyUpHandler
    $(document).on 'keydown', @keyDownHandler

  off: =>
    $(document).off 'keydown', @keyDownHandler
    $(document).off 'keyup', @keyUpHandler

  keyDownHandler: (e) =>
    if e.key is 'Control' or @ctr then @ctr = true
    else e.preventDefault()
    @keys[e.key] = true

  keyUpHandler: (e) =>
    if e.key is 'Control' or @ctr then @ctr = false
    else e.preventDefault()
    @keys[e.key] = false

module.exports = Input
