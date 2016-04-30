'use strict'

module.exports =
  randomInterval: (min, max) ->
    Math.floor(Math.random()*(max-min+1)+min)

  printLogs: (acho) ->
    levels = Object.keys(acho.types)
    levels.forEach (level) -> acho[level](level + ' message')

  createFakeTransport: ->
    store = []
    transport = ->
      console.log.apply(console, arguments)
      store.push.apply(store, arguments)
    transport.store = store
    transport

