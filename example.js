'use strict'

require('date-utils')
var Acho = require('./index.js')
var setDateout = require('set-dateout')

var base = Acho({
  align: true
})

var diff = Acho({
  diff: true
})

var label = Acho({
  align: false,
  keyword: 'worker#1'
})

var colors = Acho({
  color: false
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

messageTimeout('info', 'Simple', base)
messageTimeout('success', 'Tiny', base)
messageTimeout('verbose', 'Customizable', base)
messageTimeout('silly', 'Logger for NodeJS and Browser', base)
messageTimeout('warn', 'in less than...', base)
messageTimeout('error', '10KB!.', base)

lineBreakTimeout(1)

messageTimeout('info', 'Do you wanna to know more?', base)

lineBreakTimeout()

messageTimeout('success', 'support diff', diff)
messageTimeout('success', 'between messages', diff)

lineBreakTimeout()

messageTimeout('warn', 'adapt the logger label', label)
messageTimeout('warn', 'easily', label)

lineBreakTimeout()

messageTimeout('error', 'automatically color disabled', colors)
messageTimeout('error', 'under production', colors)

lineBreakTimeout()

messageTimeout('silly', 'and more more more...', base)
messageTimeout('debug', 'string interpolation', base)
messageTimeout('verbose', 'logs align', base)
messageTimeout('info', 'custom levels and transports', base)

lineBreakTimeout()

messageTimeout('success', 'https://github.com/Kikobeats/acho', visit)
