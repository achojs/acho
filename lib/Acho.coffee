'use strict'

chalk = require 'chalk'

# 'error'  : Display calls to `.error()`
# 'warn'   : Display calls from `.error()` to `.warn()`
# 'debug'  : Display calls from `.error()`, `.warn()` to `.debug()`
# 'info'   : Display calls from `.error()`, `.warn()`, `.debug()` to `.info()`
# 'verbose': Display calls from `.error()`, `.warn()`, `.debug()`, `.info()` to `.verbose()`

module.exports = class Acho

  constructor: (options) ->
    @color = if options.color? then options.color else false
    @level = if options.level? then options.level else 'info'
    @messages = {}
    @messages[type] = [] for type of Acho.types
    @outputType = options.outputType if options.outputType?
    @outputMessage = options.outputMessage if options.outputMessage?
    this

  outputType: (type) -> "#{type}: "

  outputMessage: (message) -> message

  push: (type, message) ->
    @messages[type].push message
    this

  track: (type, message) ->
    @[type] message
    @push type, message
    this

  error: (message) ->
    @_messageBuilder 'error', message
    this

  warning: (message) ->
    @_messageBuilder 'warning', message
    this

  success: (message) ->
    @_messageBuilder 'success', message
    this

  info: (message) ->
    @_messageBuilder 'info', message
    this

  verbose: (message) ->
    @_messageBuilder 'verbose', message
    this

  debug: (message) ->
    @_messageBuilder 'debug', message
    this

  silly: (message) ->
    @_messageBuilder 'silly', message
    this

  @types:
    error:
      level : 0
      color : 'red'
    warning:
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
      color : 'rainbow'

  print: ->
    for type of Acho.types
      @_messageBuilder(type, message) for message in @messages[type]

  _isInLevel: (type) ->
    return false if @level is 'silent'
    Acho.types[type].level <= Acho.types[@level].level

  _colorizeMessage: (color, message) ->
    return message unless @color
    return chalk[color](message) unless color is 'rainbow'
    # rainbow is the core of this library
    rainbowColors = ['red', 'yellow', 'green', 'blue', 'magenta']
    message = message.split('')
    for char, position in message
      color = rainbowColors[position % rainbowColors.length]
      message[position] = chalk[color](char)
    message.join('')

  _messageBuilder: (type, message) ->
    return unless @_isInLevel type
    colorType = Acho.types[type].color
    messageType = @outputType(type)
    messageType = @_colorizeMessage(colorType, messageType)
    message = @outputMessage(message)
    message = @_colorizeMessage('gray', message)
    console.log messageType + message
