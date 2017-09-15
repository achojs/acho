'use strict'

CONST    = require './Constants'
DEFAULT  = require './Default'

Acho = (opts = {}) ->
  return new Acho opts unless this instanceof Acho

  acho = Object.assign({}, DEFAULT(), opts)
  acho.diff = [] if acho.diff

  acho.messages = do ->
    messages = {}
    for type of acho.types
      messages[type] = opts.messages?[type] or []
      acho[type] = acho.generateTypeMessage type
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
module.exports.constants = CONST
