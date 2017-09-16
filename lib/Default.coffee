'use strict'

ms = require 'pretty-ms'

{getColor, colorize} = require './Util'
CONST = require './Constants'
format = require './Format'

module.exports = () ->
  print: ->
    for type of @types
      @transport @generateMessage type, message for message in @messages[type]

  decorateCounter: (counter) ->
    str = '' + counter
    n = CONST.DECORATE_COUNTER_ZERO_N - str.length
    return '0'.repeat(n) + str if n > 0
    str

  outputMessage: (message) -> message

  outputType: (type) ->
    if @keyword
      if @keyword is CONST.SYMBOL_KEYWORD
        type = then @types[type].symbol
      else
        type = @keyword
    type = type.toUpperCase() if @upper
    type

  outputAlign: ->
    return ' ' unless @align
    @align

  outputCounter: ->
    return '' unless @trace

    @_countertrace ||= 0
    @_lasttrace ||= null

    diff = Date.now() - @_lasttrace

    if diff >= @trace
      ++@_countertrace
      @_lasttrace = Date.now()

    " [#{@decorateCounter(@_countertrace)}]"

  outputSeparator: (type) ->
    return '' if @keyword
    @types[type].separator or ''

  outputContext: ->
    unless @context then '' else " #{@context}"

  transport: console.log

  generateMessage: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    message     = @outputMessage message
    message     = @colorizeMessage type, message
    diff        = null

    if @diff
      if @diff[type]
        diff = ms(Date.now() - @diff[type])
        diff = " +#{diff}"
        @diff[type] = Date.now()
      else
        @diff[type] = Date.now()
        diff = " +0ms"

    messageType = @outputType type
    messageType = colorize colorType, messageType

    separator = @outputSeparator(type)

    messageCounter = @outputCounter()
    messageCounter = colorize CONST.LINE_COLOR, messageCounter

    messageContext = @outputContext()
    messageContext = colorize CONST.LINE_COLOR, messageContext

    align = @outputAlign()

    output = "#{separator}#{messageType}#{messageCounter}#{messageContext}#{align}#{message}"
    output += colorize colorType, diff if diff
    output

  generateTypeMessage: (type) ->
    (message...) ->
      color = @types[type].color
      message = @format message, color
      message = @generateMessage type, message
      @transport message if message
      this

  colorizeMessage: (type, message) ->
    return message unless @color
    lineColor = CONST.LINE_COLOR
    return colorize lineColor, message if message.indexOf '=' is -1
    typeColor = @types[type].color

    message.toString().split(' ').map(msg ->
      msg = msg.split '='
      if msg.length > 1
        msg[0] = colorize typeColor, msg[0]
        msg[1] = colorize lineColor, msg[1]
        msg.join colorize lineColor, '='
      else
        colorize lineColor, msg
    ).join(' ')

  isPrintable: (type) ->
    return true if @level is CONST.UNMUTED
    return false if @level is CONST.MUTED
    @types[type].level <= @types[@level].level

  format: (messages, color) ->
    opts = {@offset, @depth}
    applyFormatter = format opts

    messages.push color
    applyFormatter messages...

  align: " "
  color: true
  trace: 0
  offset: 2
  depth: Infinity

  level: CONST.UNMUTED

  types:
    debug:
      level : 4
      color : ['white']
      symbol: CONST.FIGURE.info

    info:
      level     : 3
      color     : ['#33ccff']
      separator : ' '
      symbol    : CONST.FIGURE.info

    warn:
      level     : 2
      color     : ['#ffcc33']
      separator : ' '
      symbol    : CONST.FIGURE.warning

    error:
      level  : 1
      color  : ['#FF3333']
      symbol : CONST.FIGURE.error

    fatal:
      level  : 0
      color  : ['#ff3366']
      symbol : CONST.FIGURE.error
