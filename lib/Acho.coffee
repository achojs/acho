'use strict'

chalk   = require 'chalk'
DEFAULT = require './Default'

module.exports = class Acho

  constructor: (options = {}) ->
    @color = options.color or DEFAULT.COLOR
    @level = options.level or DEFAULT.UNMUTED
    @types = options.types or DEFAULT.TYPES
    @print = options.print or DEFAULT.PRINT
    @messages = do =>
      messages = {}
      for type of @types
        messages[type] = options.messages?[type] or []
        @[type] = @_printLevelMessage type if type isnt 'line'
      messages
    @outputType = options.outputType or DEFAULT.OUTPUT_TYPE
    @outputMessage = options.outputMessage or DEFAULT.OUTPUT_MESSAGE
    this

  @DEFAULT: DEFAULT

  push: (type, message) ->
    @messages[type].push message
    this

  add: (type, message) ->
    @[type] message
    @push type, message
    this

  colorize: (colors, message) ->
    return message unless @color
    colors  = colors.split ' '
    stylize = chalk
    stylize = stylize[color] for color in colors
    stylize message

  isPrintable: (type) ->
    return true if @level is DEFAULT.UNMUTED
    return false if @level is DEFAULT.MUTED
    @types[type].level <= @types[@level].level

  printLine: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    console.log messageType + message

  _printLevelMessage: (type, message) =>
    (message) =>
      @printLine type, message
      this
