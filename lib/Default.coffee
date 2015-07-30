'use strict'

module.exports =

  PRINT: ->
    for type of @types
      console.log @generateMessage type, message for message in @messages[type]

  OUTPUT_MESSAGE: (message) -> message
  OUTPUT_TYPE: (type) -> "#{type}\t: "

  GENERATE_MESSAGE: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    messageType + message

  COLOR: true
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
