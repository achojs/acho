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
        @[type] = @generateTypeMessage type if type isnt 'line'
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

  generateTypeMessage: (type, message) =>
    (message) =>
      console.log @generateMessage type, message
      this

  generateMessage: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    messageType + message
