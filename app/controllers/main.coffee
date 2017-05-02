Spine   = require('spine')
$       = Spine.$

class Main extends Spine.Stack
  className: 'main'

  controllers:
    Home  : require('controllers/home')
    Game  : require('controllers/game')
    Cubes : require('controllers/cubes')

  default: 'Home'

module.exports = Main
