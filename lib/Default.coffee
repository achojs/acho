'use strict'

module.exports =
  OUTPUT_TYPE: (type) -> "#{type}\t: "
  OUTPUT_MESSAGE: (message) -> message
  PRINT: ->
    for type of @types
      @printLine(type, message) for message in @messages[type]
  COLOR: false
  UNMUTED: 'all'
  MUTED: 'silent'
  TYPES:
    line:
      color: 'gray'
    error:
      level : 0
      color : 'red'
    warn:
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
      color : 'magenta'
