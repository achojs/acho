'use strict'

clone = require 'lodash.clonedeep'

DEFAULT  = require './Default'
CONST    = require './Constants'


Acho = (opts = {}) ->
  return new Acho opts unless this instanceof Acho

  # TODO: Merge instead of clonee
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

# TODO: Remove it, unnecessary
Acho.skin = (skinFn) ->
  skin = skinFn(CONST)
  (opts = {}) ->
    Acho(Object.assign({}, opts, skin))

Acho.defaults = DEFAULT

module.exports = Acho
