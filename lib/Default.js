'use strict'

const ms = require('pretty-ms')

const { isString, colorize } = require('./Util')
const CONST = require('./Constants')
const format = require('./Format')

module.exports = function () {
  return {
    print () {
      Object.keys(this.types).forEach(type => {
        this.messages[type].forEach(message => {
          this.transport(this.generateMessage(type, message))
        })
      })
    },

    decorateCounter (counter) {
      const str = `${counter}`
      const n = CONST.DECORATE_COUNTER_ZERO_N - str.length
      return n > 0 ? '0'.repeat(n) + str : str
    },

    outputMessage (message) {
      return message
    },

    outputType (type) {
      if (this.keyword) {
        if (this.keyword === CONST.SYMBOL_KEYWORD) {
          type = this.types[type].symbol
        } else {
          type = this.keyword
        }
      }
      if (this.upper) type = type.toUpperCase()
      return type
    },

    outputAlign () {
      return !this.align ? ' ' : this.align
    },

    outputCounter () {
      if (!this.trace) return ''

      // first time initialization
      if (this._countertrace === undefined) {
        this._countertrace = -1
        this._lasttrace = 0
      }

      const diff = Date.now() - this._lasttrace

      if (this.trace === true || diff > this.trace) {
        ++this._countertrace
        this._lasttrace = Date.now()
      }

      return ` [${this.decorateCounter(this._countertrace)}]`
    },

    outputSeparator (type) {
      return this.keyword ? '' : this.types[type].separator || ''
    },

    outputContext () {
      return !this.context ? '' : ` ${this.context}`
    },

    transport: console.log,

    generateMessage (type, message) {
      if (!this.isPrintable(type)) return
      const colorType = this.types[type].color
      message = this.outputMessage(message)
      message = this.colorizeMessage(type, message)
      let diff = null

      if (this.diff) {
        if (this.diff[type]) {
          diff = ms(Date.now() - this.diff[type])
          diff = ` +${diff}`
          this.diff[type] = Date.now()
        } else {
          this.diff[type] = Date.now()
          diff = ' +0ms'
        }
      }

      let messageType = this.outputType(type)
      messageType = colorize(colorType, messageType)

      const separator = this.outputSeparator(type)

      let messageCounter = this.outputCounter()
      messageCounter = colorize(CONST.LINE_COLOR, messageCounter)

      let messageContext = this.outputContext()
      messageContext = colorize(CONST.LINE_COLOR, messageContext)

      const align = this.outputAlign()

      let output = `${separator}${messageType}${messageCounter}${messageContext}${align}${message}`
      if (diff) {
        output += colorize(colorType, diff)
      }
      return output
    },

    generateTypeMessage (type) {
      return function (...message) {
        const { color } = this.types[type]
        message = this.format(message, color)
        message = this.generateMessage(type, message)
        if (message) this.transport(message)
        return this
      }
    },

    colorizeMessage (type, message) {
      if (!this.color) return message
      const lineColor = CONST.LINE_COLOR
      if (isString(message) && message.indexOf('=' === -1)) {
        return colorize(lineColor, message)
      }
      const typeColor = this.types[type].color

      return message
        .toString()
        .split(' ')
        .map(function (msg) {
          msg = msg.split('=')
          if (msg.length > 1) {
            msg[0] = colorize(typeColor, msg[0])
            msg[1] = colorize(lineColor, msg[1])
            return msg.join(colorize(lineColor, '='))
          } else {
            return colorize(lineColor, msg)
          }
        })
        .join(' ')
    },

    isPrintable (type) {
      if (this.level === CONST.UNMUTED) return true
      if (this.level === CONST.MUTED) return false
      return this.types[type].level <= this.types[this.level].level
    },

    format (messages, color) {
      const opts = { offset: this.offset, depth: this.depth }
      const applyFormatter = format(opts)

      messages.push(color)
      return applyFormatter(...(messages || []))
    },

    align: ' ',
    color: true,
    trace: 0,
    offset: 2,
    depth: Infinity,

    level: CONST.UNMUTED,

    types: {
      debug: {
        level: 4,
        color: ['white'],
        symbol: CONST.FIGURE.info
      },

      info: {
        level: 3,
        color: ['#33ccff'],
        separator: ' ',
        symbol: CONST.FIGURE.info
      },

      warn: {
        level: 2,
        color: ['#ffcc33'],
        separator: ' ',
        symbol: CONST.FIGURE.warning
      },

      error: {
        level: 1,
        color: ['#FF3333'],
        symbol: CONST.FIGURE.error
      },

      fatal: {
        level: 0,
        color: ['#ff3366'],
        symbol: CONST.FIGURE.error
      }
    }
  }
}
