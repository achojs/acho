/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
'use strict'

module.exports = {
  randomInterval (min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
  },

  printLogs (acho) {
    const levels = Object.keys(acho.types)
    return levels.forEach(level => acho[level](level + ' message'))
  },

  createFakeTransport () {
    const store = []
    const transport = function () {
      console.log.apply(console, arguments)
      return store.push.apply(store, arguments)
    }
    transport.store = store
    return transport
  }
}
