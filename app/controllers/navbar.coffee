Spine   = require('spine')
$       = Spine.$

class Navbar extends Spine.Controller
  className: 'navbar navbar-toggleable-sm navbar-inverse bg-inverse'

  elements:
    '.newGame'  : 'gameLink'
    '.newCubes' : 'cubesLink'

  events:
    'click a.navbar-brand' : 'goHome'
    'click .newGame'       : 'newGame'
    'click .newCubes'      : 'newCubes'

  constructor: () ->
    super
    @change()

  change: =>
    @render()
    ref = window.location.href.split('/')
    if ref[ref.length - 1] is 'cubes'
      @cubesLink.addClass('active')
    if ref[ref.length - 1] is 'game'
      @gameLink.addClass('active')

  render: ->
    @html require('views/navbar')

  goHome: (e) =>
    e.preventDefault()
    @gameLink.removeClass('active')
    @cubesLink.removeClass('active')
    @navigate('/')

  newGame: (e) =>
    e.preventDefault()
    @cubesLink.removeClass('active')
    @gameLink.addClass('active')
    @navigate('/game')

  newCubes: (e) =>
    e.preventDefault()
    @gameLink.removeClass('active')
    @cubesLink.addClass('active')
    @navigate('/cubes')


module.exports = Navbar
