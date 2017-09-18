'use strict'

module.exports = {
  randomInterval: (min, max) =>
    Math.floor(Math.random() * (max - min + 1) + min),

  printLogs: acho =>
    Object.keys(acho.types).forEach(level => acho[level](level + ' message')),

  createFakeTransport: () => {
    let store = []
    const transport = (...args) => {
      console.log(...args)
      store.push(...args)
    }
    transport.store = store
    return transport
  }
}
