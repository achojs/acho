'use strict'

chalk        = require 'chalk'
DEFAULT      = require './Default'
CONST        = require './Constants'
format       = require 'format-util'
existsAssign = require 'existential-assign'

module.exports = (options = {}) ->
  acho = existsAssign(DEFAULT, options)
  acho.diff = [] if acho.diff
  acho[key] = value for key, value of acho

  acho.messages = do ->
    messages = {}
    for type of acho.types
      messages[type] = options.messages?[type] or []
      acho[type] = acho.generateTypeMessage type if type isnt 'line'
    messages

  acho.push = (type, messages...) ->
    message = @format messages
    @messages[type].push message
    this

  acho.add = (type, messages...) ->
    message = @format messages
    @[type] message
    @push type, message
    this

  acho.colorize = (colors, message) ->
    return message if not @color or CONST.ENV is 'production'
    colors  = colors.split ' '
    stylize = chalk
    stylize = stylize[color] for color in colors
    stylize message

  acho.isPrintable = (type) ->
    return true if @level is CONST.UNMUTED
    return false if @level is CONST.MUTED
    @types[type].level <= @types[@level].level

  acho.format = (messages) -> format.apply null, messages

  acho
