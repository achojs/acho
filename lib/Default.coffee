'use strict'

chalk      = require 'chalk'
ms         = require 'pretty-ms'
CONST      = require './Constants'
formatUtil = require 'format-util'

module.exports =
  print: ->
    for type of @types
      @transport @generateMessage type, message for message in @messages[type]

  outputMessage: (message) -> message
  outputType: (type, diff = '') ->
    if @align and not @diff then "#{type}#{diff}\t" else "#{type}#{diff} "

  transport: console.log

  generateMessage: (type, message) ->
    return unless @isPrintable type

    colorType   = @types[type].color
    message     = @outputMessage message
    message     = @colorize @types.line.color, message

    keyword     = if @keyword? then @keyword else type
    diff        = null

    if @diff
      if @diff[type]
        diff = new Date() - @diff[type]
        diff = if diff > CONST.MIN_DIFF_MS then ms diff else "#{diff}ms"
        @diff[type] = new Date()
        diff = " +#{diff}"
      else
        @diff[type] = new Date()

    messageType = @outputType keyword, diff
    messageType = @colorize colorType, messageType
    messageType + message

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
