'use strict'

chalk        = require 'chalk'
DEFAULT      = require './Default'
format       = require 'format-util'
existsAssign = require 'existential-assign'

module.exports = class Acho
  constructor: (options = {}) ->
    options = existsAssign(DEFAULT, options)
    options.diff = [] if options.diff
    @[key] = value for key, value of options

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
