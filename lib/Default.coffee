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

    "#{type}#{align}"

  transport: console.log

  generateMessage: (type, message) ->
    return unless @isPrintable type

    colorType   = @types[type].color
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
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

    output = messageType + message
    output += @colorize colorType, diff if diff
    output

  generateTypeMessage: (type) ->
    (message...) ->
      color = @types[type].color
      message = @format message, color
      message = @generateMessage type, message
      @transport message if message
      this

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
  align: "\t"
  color: true

  level: CONST.UNMUTED

  types:
    line:
      color : 'gray'

    error:
      level : 0
      color : 'red'
      symbol: figure.error

    warn:
      level : 1
      color : 'yellow'
      symbol: figure.warning

    success:
      level : 2
      color : 'green'
      symbol: figure.success

    info:
      level : 3
      color : 'white'
      symbol: figure.info

    verbose:
      level : 4
      color : 'cyan'
      symbol: figure.info

    debug:
      level : 5
      color : 'blue'
      symbol: figure.info

    silly:
      level : 6
      color : 'magenta'
      symbol: figure.info
