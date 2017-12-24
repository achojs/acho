'use strict'

const CONST = require('./Constants')
const DEFAULT = require('./Default')

const Acho = function (opts = {}) {
  if (!(this instanceof Acho)) return new Acho(opts)

  const acho = Object.assign({}, DEFAULT(), opts)
  if (acho.diff) acho.diff = []

  acho.messages = (function () {
    const messages = {}
    for (let type in acho.types) {
      messages[type] =
        (opts.messages != null ? opts.messages[type] : undefined) || []
      acho[type] = acho.generateTypeMessage(type)
    }
    return messages
  })()

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
