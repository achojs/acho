'use strict'

humanizeMs = require 'ms'
chalk      = require 'chalk'
figures    = require 'figures'
CONST      = require './Constants'
formatUtil = require 'format-util'

module.exports =
  print: ->
    for type of @types
      @transport @generateMessage type, message for message in @messages[type]

  outputMessage: (message) -> message
  outputType: (type) ->
    align = if @align then "\t" else " "
    if @keyword
      type = if @keyword is CONST.SYMBOL_KEYWORD then @types[type].symbol else type
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
      message = @format message
      @transport @generateMessage type, message
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

  format: (messages) -> formatUtil.apply null, messages

  keyword: null
  diff: false
  align: true
  color: true

  level: CONST.UNMUTED

  types:
    line:
      color : 'gray'
      symbol: ''

    error:
      level : 0
      color : 'red'
      symbol: figures.cross

    warn:
      level : 1
      color : 'yellow'
      symbol: figures.warning

    success:
      level : 2
      color : 'green'
      symbol: figures.tick

    info:
      level : 3
      color : 'white'
      symbol: figures.info

    verbose:
      level : 4
      color : 'cyan'
      symbol: figures.info

    debug:
      level : 5
      color : 'blue'
      symbol: figures.info

    silly:
      level : 6
      color : 'magenta'
      symbol: figures.info
