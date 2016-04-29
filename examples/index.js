'use strict'

require('date-utils')
var Acho = require('..')
var setDateout = require('set-dateout')

var base = Acho({})

var diff = Acho({
  diff: true
})

var label = Acho({
  align: false,
  keyword: 'worker#1'
})

var production = Acho({
  color: false,
  align: false
})

var visit = Acho({
  keyword: 'visit'
})

var getStep = (function () {
  var start = 0
  return function (value) {
    if (value) start += value
    else ++start
    return start
  }
})()

var messageTimeout = (function () {
  return function (level, message, logger, time) {
    setDateout(function () {
      logger[level](message)
    }, new Date().add({seconds: getStep(0.8)}))
  }
})()

var lineBreakTimeout = (function () {
  return function (time) {
    setDateout(function () {
      console.log()
    }, new Date().add({seconds: getStep(time || 0.2)}))
  }
})()

messageTimeout('info', 'Hackable', base)
messageTimeout('debug', 'Logging', base)
messageTimeout('warn', 'for NodeJS and Browser', base)
messageTimeout('error', 'in less than', base)
messageTimeout('fatal', '10KB!.', base)

lineBreakTimeout(1)

messageTimeout('info', 'Do you wanna to know more?', base)

lineBreakTimeout()

messageTimeout('debug', 'support diff', diff)
messageTimeout('debug', 'between messages', diff)

lineBreakTimeout()

messageTimeout('warn', 'adapt the logger label', label)
messageTimeout('warn', 'easily', label)

lineBreakTimeout()

messageTimeout('error', 'automatically color and align disabled', production)
messageTimeout('error', 'under production scenario', production)

lineBreakTimeout()

messageTimeout('debug', 'and more more more...', base)

lineBreakTimeout()

messageTimeout('debug', 'string interpolation', base)
messageTimeout('debug', 'logs align', base)
messageTimeout('info', 'custom levels and transports', base)
messageTimeout('info', 'object serialization', base)
messageTimeout('info', {foo: 'bar', hello: 'world'}, base)

lineBreakTimeout()

messageTimeout('debug', 'https://github.com/Kikobeats/acho', visit)
