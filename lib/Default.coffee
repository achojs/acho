'use strict'

humanizeMs = require 'ms'
chalk      = require 'chalk'
formatUtil = require './Format'
CONST      = require './Constants'

figure = do ->
  main =
    info    : 'ℹ'
    success : '✔'
    warning : '⚠'
    error   : '✖'

  win =
    info    : 'i'
    success : '√'
    warning : '‼'
    error   : '×'

  if process.platform is 'win32' then win else main

module.exports =
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

    if @align
      if CONST.ENV is 'production'
        align = ' '
      else if @keyword
        align = ' '
      else
        align = @align
    else
      align = ' '

    type = type.toUpperCase() if @upperCase
    type

  outputCounter: ->
    now = new Date
    diff = now - @timestamp
    ++@counter if (diff > 1000)
    @timestamp = new Date()
    "[#{@decorateCounter(@counter)}]"

  outputContext: ->
    @context

  transport: console.log

  generateMessage: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    message     = @outputMessage message
    message     = @colorizeMessage type, message
    diff        = null

    if @diff
      if @diff[type]
        diff = humanizeMs(new Date() - @diff[type])
        diff = " +#{diff}"
        @diff[type] = new Date()
      else
        @diff[type] = new Date()
        diff = " +0ms"

    messageType = @outputType type
    messageType = @colorize colorType, messageType
    messageType = (@types[type].align or '') + messageType

    messageCounter = @outputCounter()
    messageCounter = @colorize CONST.LINE_COLOR, messageCounter

    messageContext = @outputContext()
    messageContext = @colorize CONST.LINE_COLOR, messageContext

    output = "#{messageType} #{messageCounter} #{messageContext} #{@align}#{message}"
    output += @colorize colorType, diff if diff
    output

  generateTypeMessage: (type) ->
    (message...) ->
      color = @types[type].color
      message = @format message, color
      message = @generateMessage type, message
      @transport message if message
      this

  colorizeMessage: (type, message) ->
    return message if not @color or CONST.ENV is 'production'

    lineColor = CONST.LINE_COLOR
    typeColor = @types[type].color

    message.split(' ').map((msg) =>
      msg = msg.split '='
      if msg.length > 1
        msg[0] = @colorize typeColor, msg[0]
        msg[1] = @colorize lineColor, msg[1]
        msg.join @colorize lineColor, '='
      else
        @colorize lineColor, msg
    ).join(' ')

  colorize: (colors, message) ->
    return message if not @color or CONST.ENV is 'production'
    colors  = colors.split ' '
    stylize = chalk
    stylize = stylize[color] for color in colors
    stylize message

  isPrintable: (type) ->
    return true if @level is CONST.UNMUTED
    return false if @level is CONST.MUTED
    @types[type].level <= @types[@level].level

  format: (messages, color) ->
    messages.push color
    formatUtil.apply null, messages

  keyword: null
  diff: false
  align: "\t\t"
  color: true
  counter: 0
  cli: false
  context: 'test'

  timestamp: new Date()

  level: CONST.UNMUTED

  types:

    logging:

      debug:
        level : 4
        color : 'white'
        symbol: figure.info

      info:
        level : 3
        color : 'blue'
        align : ' '
        symbol: figure.info

      warn:
        level : 2
        color : 'yellow'
        align : ' '
        symbol: figure.warning

      error:
        level : 1
        color : 'red'
        symbol: figure.error

      fatal:
        level : 0
        color : 'red'
        symbol: figure.error

    cli:

      debug:
        level : 4
        color : 'blue'
        symbol: figure.info

      info:
        level : 3
        color : 'white'
        symbol: figure.info

      success:
        level : 2
        color : 'green'
        symbol: figure.success

      warn:
        level : 1
        color : 'yellow'
        symbol: figure.warning

      error:
        level : 0
        color : 'red'
        symbol: figure.error
