'use strict'

ms = require 'pretty-ms'

module.exports =

  PRINT: ->
    for type of @types
      @transport @generateMessage type, message for message in @messages[type]

  OUTPUT_MESSAGE: (message) -> message
  OUTPUT_TYPE: (type) ->
    type = @keyword or type
    if @align and not @timestamp then "#{type}\t " else "#{type} "

  TRANSPORT: console.log

  GENERATE_MESSAGE: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType(unless @keyword then type)
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    timestamp   = ''

    if @timestamp
      if @timestamp[type]
        diff = new Date() - @timestamp[type]
        diff = if diff > 10000 then ms diff else "#{diff}ms"
        timestamp = @colorize colorType, "+#{diff} "
        @timestamp[type] = new Date()
      else
        @timestamp[type] = new Date()

    messageType + timestamp + message

  GENERATE_TYPE_MESSAGE: (type) ->
    (message) ->
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
