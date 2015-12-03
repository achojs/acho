'use strict'

chalk    = require 'chalk'
DEFAULT  = require './Default'
format   = require 'format-util'

module.exports = class Acho

  constructor: (options = {}) ->
    @keyword = options.keyword
    @align = if options.align? then options.align else DEFAULT.ALIGN
    @timestamp = [] if options.diff or DEFAULT.DIFF
    @outputType = options.outputType or DEFAULT.OUTPUT_TYPE
    @color = if options.color? then options.color else DEFAULT.COLOR
    @level = options.level or DEFAULT.UNMUTED
    @types = options.types or DEFAULT.TYPES
    @transport = options.transport or DEFAULT.TRANSPORT
    @outputMessage = options.outputMessage or DEFAULT.OUTPUT_MESSAGE
    @generateMessage = options.generateMessage or DEFAULT.GENERATE_MESSAGE
    @generateTypeMessage = options.generateTypeMessage or DEFAULT.GENERATE_TYPE_MESSAGE
    @print = options.print or DEFAULT.PRINT
    @messages = do =>
      messages = {}
      for type of @types
        messages[type] = options.messages?[type] or []
        @[type] = @generateTypeMessage type if type isnt 'line'
      messages
    this

  push: (type, messages...) ->
    message = @_format messages
    @messages[type].push message
    this

  add: (type, messages...) ->
    message = @_format messages
    @[type] message
    @push type, message
    this

  colorize: (colors, message) ->
    return message if not @color or process?.env.NODE_ENV?.toLowerCase() is 'production'
    colors  = colors.split ' '
    stylize = chalk
    stylize = stylize[color] for color in colors
    stylize message

  isPrintable: (type) ->
    return true if @level is DEFAULT.UNMUTED
    return false if @level is DEFAULT.MUTED
    @types[type].level <= @types[@level].level

  _format: (messages) ->
    format.apply null, messages
