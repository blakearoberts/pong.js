require('lib/setup')

Spine = require('spine')

Main   = require('controllers/main')
Navbar = require('controllers/navbar')
Input  = require('lib/input')

class App extends Spine.Controller
  constructor: ->
    super

    @main   = new Main()
    @navbar = new Navbar({el:'nav'})

    @routes
      '/': (params) ->
        @main.Home.active()
      '/game': (params) ->
        @main.Game.active()
      '/cubes': (params) ->
        @main.Cubes.active()

    @append @navbar, @main

    Spine.Route.setup()

module.exports = App
