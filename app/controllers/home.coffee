Spine   = require('spine')
$       = Spine.$

Input  = require('lib/input')

class Home extends Spine.Controller
  className: 'home'

  constructor: ->
    super
    @active @change

  render: =>
    @html require('views/home')

  change: (params) =>
    @stopControllers()
    @render()

  stopControllers: =>
    @stack.Game.input.off()
    @stack.Game.graphic.stopAnimate()
    @stack.Cubes.input.off()
    @stack.Cubes.graphic.stopAnimate()

module.exports = Home
