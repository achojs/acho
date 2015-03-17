'use strict'

chalk   = require 'chalk'
DEFAULT = require './Default'
exists  = require 'existential-default'

module.exports = class Acho
  constructor: (options = {}) ->
    @color = exists options.color, DEFAULT.COLOR
    @level = exists options.level, DEFAULT.LEVEL
    @types = exists options.types, DEFAULT.TYPES
    @print = exists options.print, DEFAULT.PRINT
    @muted = exists options.muted, DEFAULT.MUTED
    @messages = exists options.messages, do =>
      messages = {}
      messages[type] = [] for type of @types
      messages
    @outputType = exists options.outputType, DEFAULT.OUTPUT_TYPE
    @outputMessage = exists options.outputMessage, DEFAULT.OUTPUT_MESSAGE
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

  warning: (message) ->
    @printLine 'warning', message
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
    console.log "#{messageType} #{message}"
