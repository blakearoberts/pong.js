Spine   = require('spine')
$       = Spine.$

class Scoreboard extends Spine.Controller

  events:
    'click #pause' : 'togglePause'
    'click #play'  : 'togglePause'

  elements:
    '#clock'     : 'clock'
    '#score1'    : 'score1'
    '#score2'    : 'score2'
    '#pause'     : 'pause'
    '#play'      : 'play'

  constructor: ->
    super
    @resetStats()
    @active @change

  render: ->
    @html require('views/scoreboard')({stats:@stats})

  change: =>
    @el = $('#scoreboard')
    @render()

  resetStats: ->
    @stats = {
      score: [0,0],
      time: 0,
      pause: true
    }
    @timer = setInterval( =>
      unless @stats.pause
        @clock.html(++@stats.time)
    , 1000)

  score: (player) =>
    @stats.score[player]++
    if player is 0 then @score1.html(@stats.score[player])
    else @score2.html(@stats.score[player])
    @togglePause()

  togglePause: (e) =>
    e?.preventDefault()
    @stats.pause = not @stats.pause
    if @stats.pause
      @play.removeClass('d-none')
      @pause.addClass('d-none')
    else
      @pause.removeClass('d-none')
      @play.addClass('d-none')

  play: =>
    @stats.pause = false
    @render()

module.exports = Scoreboard
