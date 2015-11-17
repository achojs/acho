'use strict'

ms = require 'pretty-ms'

CONST =
  MIN_DIFF_MS: 10000

module.exports =
  PRINT: ->
    for type of @types
      @transport @generateMessage type, message for message in @messages[type]

  OUTPUT_MESSAGE: (message) -> message
  OUTPUT_TYPE: (type, diff = '') ->
    if @align and not @timestamp then "#{type}#{diff}\t" else "#{type}#{diff} "

  TRANSPORT: console.log

  GENERATE_MESSAGE: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    message     = @outputMessage message
    message     = @colorize @types.line.color, message

    if @timestamp
      if @timestamp[type]
        diff = new Date() - @timestamp[type]
        diff = if diff > CONST.MIN_DIFF_MS then ms diff else "#{diff}ms"
        @timestamp[type] = new Date()
        messageType = @outputType @keyword or type, " +#{diff}"
      else
        @timestamp[type] = new Date()
        messageType = @outputType @keyword or type
    else
      messageType = @outputType @keyword or type

    messageType = @colorize colorType, messageType
    messageType + message

  GENERATE_TYPE_MESSAGE: (type) ->
    (message) =>
      @transport @generateMessage type, message
      this

  DIFF: false
  ALIGN: true
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
