'use strict'

DEFAULT  = require './Default'
CONST    = require './Constants'
defaults = require 'lodash.defaults'

Acho = (params = {}) ->
  return new Acho params unless this instanceof Acho

  acho = defaults({}, params, DEFAULT)
  acho.diff = [] if acho.diff
  acho[key] = value for key, value of acho

  acho.messages = do ->
    messages = {}
    for type of acho.types
      messages[type] = params.messages?[type] or []
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

Acho.skin = (skinFn) ->
  skin = skinFn(CONST)
  (params = {}) ->
    defaults(params, skin)
    Acho(params)

module.exports = Acho
