Spine   = require('spine')
$       = Spine.$

Graphic  = require('lib/graphic')
Utils    = require('lib/utils')
Input    = require('lib/input')
Board    = require('lib/board')
Paddle   = require('lib/paddle')
Ball     = require('lib/ball')

class Game extends Spine.Controller
  className: 'game'

  events:
    'click #playBtn'  : 'play'
    'click #pauseBtn' : 'pause'
    'click #resetBtn' : 'reset'
    'click #helpBtn'  : 'help'

  elements:
    '#game'      : 'game'
    '#redScore'  : 'redScoreEl'
    '#blueScore' : 'blueScoreEl'
    '#clock'     : 'clock'
    '#playBtn'   : 'playBtn'
    '#pauseBtn'  : 'pauseBtn'

  constructor: ->
    super
    @timer = 0
    @redScore = 0
    @blueScore = 0
    @gamePaused = true
    @graphic = new Graphic(@width, @height, @animate)
    @graphic.camera.position.y = 20
    @graphic.camera.position.z = 15
    @graphic.camera.lookAt(new THREE.Vector3(0,0,0))
    @entities = []

    @board = new Board()
    @board.id = @graphic.add(@board)
    @entities.push(@board)

    @paddle1 = new Paddle(0xff0000)
    @paddle1.id = @graphic.add(@paddle1)
    @paddle1.x(-18)
    @paddle1.y(0.5)
    @entities.push(@paddle1)

    @paddle2 = new Paddle(0x0000ff)
    @paddle2.id = @graphic.add(@paddle2)
    @paddle2.x(18)
    @paddle2.y(0.5)
    @entities.push(@paddle2)

    @ball = new Ball()
    @ball.id = @graphic.add(@ball)
    @ball.y(0.5)
    @entities.push(@ball)

    @input = new Input()

    @active @change

  render: ->
    @html require('views/game')

  change: (params) =>
    @stack.Cubes.input.off()
    @stack.Cubes.graphic.stopAnimate()
    @input.on()
    @render()
    @pauseBtn.hide()
    @graphic.render(@game)
    @graphic.animate()

  animate: =>
    @movePaddles()
    unless @gamePaused then @ball.move()
    @ballBoardIntersect()
    @paddleBallIntersect()
    for entity, i in @entities
      entity.render()

  pause: (e) =>
    e?.preventDefault()
    clearInterval(@timerId)
    @gamePaused = true
    @pauseBtn.hide()
    @playBtn.show()

  play: (e) =>
    e.preventDefault()
    @startTimer()
    @gamePaused = false
    @playBtn.hide()
    @pauseBtn.show()

  reset: (e) =>
    e.preventDefault()
    @timer = 0
    @clock.html('0:00')
    @redScore = 0
    @blueScore = 0
    @redScoreEl.html(0)
    @blueScoreEl.html(0)
    @ball.x(0, true)
    @ball.z(0, true)
    @pause()

  help: (e) ->
    e.preventDefault()
    swal({
      title: 'Keyboard and Mouse Controls',
      text: "'W' and 'S' to move the red paddle\n" +
        "Arrows to move the blue paddle\n\n" +
        "Left Mouse Button to rotate\n" +
        "Right mouse button to pan\n" +
        "Scroll/wheel to zoom",
      confirmButtonClass: 'btn-info',
      confirmButtonText: 'Sounds good!'
      })

  startTimer: =>
    @timerId = setInterval( =>
      @timer++
      minute = Math.floor(@timer / 600)
      second = Math.floor((@timer / 10) % 60)
      if second < 10 then second = '0' + second
      @clock.html(minute + ':' + second)
    , 100)

  movePaddles: =>
    speed = 0.15
    if @input.keys['w'] and
    not @paddleBoardIntersect(@paddle1, 'back')
      @paddle1.position.z -= speed
    if @input.keys['s'] and
    not @paddleBoardIntersect(@paddle1, 'front')
      @paddle1.position.z += speed
    if @input.keys['ArrowUp'] and
    not @paddleBoardIntersect(@paddle2, 'back')
      @paddle2.position.z -= speed
    if @input.keys['ArrowDown'] and
    not @paddleBoardIntersect(@paddle2, 'front')
      @paddle2.position.z += speed

  paddleBoardIntersect: (paddle, side) ->
    bounds = paddle.getBounds()
    @board[side].intersectsBox(bounds)

  ballBoardIntersect: =>
    bounds = @ball.getBounds()
    if @board.front.intersectsSphere(bounds) then @ball.hitWall('z')
    if @board.back.intersectsSphere(bounds) then @ball.hitWall('z')
    if @board.left.intersectsSphere(bounds) then @score('blue')
    if @board.right.intersectsSphere(bounds) then @score('red')

  paddleBallIntersect: =>
    bounds = @ball.getBounds()
    if @paddle1.getBounds().intersectsSphere(bounds) or
    @paddle2.getBounds().intersectsSphere(bounds) then @ball.hitWall('x')

  score: (team) =>
    @[team + 'ScoreEl'].html(++@[team + 'Score'])
    @pause()
    @ball.x(0, true)
    @ball.z(0, true)

  width: ->
    window.innerWidth

  height: ->
    window.innerHeight - 55

module.exports = Game
