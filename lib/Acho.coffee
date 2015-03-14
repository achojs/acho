'use strict'

chalk = require 'chalk'
DEFAULT = require './default'

module.exports = class Acho
  constructor: (options = {}) ->
    @color = if options.color? then options.color else DEFAULT.COLOR
    @level = if options.level? then options.level else DEFAULT.LEVEL
    @types = if options.types? then options.types else DEFAULT.TYPES
    @print = if options.print? then options.print else DEFAULT.PRINT
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
    return false if @level is 'silent'
    @types[type].level <= @types[@level].level

  colorize: (color, message) ->
    return message unless @color
    return chalk[color](message) unless color is 'rainbow'
    # rainbow is the core of this library
    rainbowColors = ['red', 'yellow', 'green', 'blue', 'magenta']
    message = message.split('')
    for char, position in message
      color = rainbowColors[position % rainbowColors.length]
      message[position] = chalk[color](char)
    message.join('')

  printLine: (type, message) ->
    return unless @isPrintable type
    colorType = @types[type].color
    messageType = @outputType type
    messageType = @colorize colorType, messageType
    message = @outputMessage message
    message = @colorize 'gray', message
    console.log messageType + message
