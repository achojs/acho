'use strict'

module.exports =
  chalk: ->
    chalk = require 'chalk'
    chalk.rainbow = (text) ->
      text = text.split('')
      rainbowColors = ['red', 'yellow', 'green', 'blue', 'magenta']
      colorize = ''
      for letter, position in text
        color = rainbowColors[position % rainbowColors.length]
        colorize += chalk.styles[color].open + letter + chalk.styles[color].close
      colorize
    chalk
  OUTPUT_TYPE: (type) -> "#{type}\t: "
  OUTPUT_MESSAGE: (message) -> message
  PRINT: ->
    for type of @types
      @printLine(type, message) for message in @messages[type]
  LEVEL: 'info'
  COLOR: false
  MUTED: 'silent'
  TYPES:
    line:
      color: 'gray'
    error:
      level : 0
      color : 'red'
    warning:
      level : 1
      color : 'yellow'
    success:
      level : 2
      color : 'green'
    info:
      level : 3
      color : 'white'
    verbose:
      level : 4
      color : 'cyan'
    debug:
      level : 5
      color : 'blue'
    silly:
      level : 6
      color : 'rainbow'
