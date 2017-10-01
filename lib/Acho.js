'use strict'

const CONST = require('./Constants')
const DEFAULT = require('./Default')

function Acho (opts = {}) {
  !(this instanceof Acho) && new Acho(opts)
  const acho = Object.assign({ diff: [] }, DEFAULT(), opts)

  acho.messages = (() =>
    Object.keys(acho.types).reduce((messages, type) => {
      acho[type] = acho.generateTypeMessage(type)
      messages[type] = (opts.messages || {})[type] || []
      return messages
    }, {}))()

  acho.push = function (type, ...messages) {
    const message = this.format(messages)
    this.messages[type].push(message)
    return this
  }

  acho.add = function (type, ...messages) {
    const message = this.format(messages)
    this[type](message)
    this.push(type, message)
    return this
  }

  return acho
}

module.exports = Acho
module.exports.constants = CONST
