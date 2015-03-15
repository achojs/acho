'use strict'

DEFAULT = require './default'
chalk   = DEFAULT.chalk()

module.exports = class Acho
  constructor: (options = {}) ->
    @color = if options.color? then options.color else DEFAULT.COLOR
    @level = if options.level? then options.level else DEFAULT.LEVEL
    @types = if options.types? then options.types else DEFAULT.TYPES
    @print = if options.print? then options.print else DEFAULT.PRINT
    @muted = if options.muted? then options.muted else DEFAULT.MUTED
    if options.messages?
      @messages = options.messages
    else
      @messages = {}
      @messages[type] = [] for type of @types
    @outputType = if options.outputType? then options.outputType else DEFAULT.OUTPUT_TYPE
    @outputMessage = if options.outputMessage? then options.outputMessage else DEFAULT.OUTPUT_MESSAGE
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
    stylize = stylize[color] for color in colors when color
    stylize message

  printLine: (type, message) ->
    return unless @isPrintable type
    colorType   = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message     = @outputMessage message
    message     = @colorize @types.line.color, message
    console.log "#{messageType} #{message}"
