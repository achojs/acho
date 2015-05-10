'use strict'

chalk   = require 'chalk'
DEFAULT = require './Default'

module.exports = class Acho

  constructor: (options = {}) ->
    @color = options.color or DEFAULT.COLOR
    @level = options.level or DEFAULT.LEVEL
    @types = options.types or DEFAULT.TYPES
    @print = options.print or DEFAULT.PRINT
    @muted = options.muted or DEFAULT.MUTED
    @messages = do =>
      messages = {}
      messages[type] = [] for type of @types
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

  error: (message) ->
    @printLine 'error', message
    this

  warn: (message) ->
    @printLine 'warn', message
    this

  success: (message) ->
    @printLine 'success', message
    this

  info: (message) ->
    @printLine 'info', message
    this

  verbose: (message) ->
    @printLine 'verbose', message
    this

  debug: (message) ->
    @printLine 'debug', message
    this

  silly: (message) ->
    @printLine 'silly', message
    this

  isPrintable: (type) ->
    return false if @level is @muted
    @types[type].level <= @types[@level].level

  colorize: (colors, message) ->
    return message unless @color
    colors  = colors.split ' '
    stylize = chalk
    stylize = stylize[color] for color in colors
    stylize message

  printLine: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    console.log messageType + message
