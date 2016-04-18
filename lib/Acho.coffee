'use strict'

DEFAULT       = require './Default'
CONST         = require './Constants'
existsDefault = require 'existential-default'

Acho = (options = {}) ->
  return new Acho options unless this instanceof Acho

  acho = existsDefault(options, DEFAULT)
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

  acho

module.exports = Acho
