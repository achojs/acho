'use strict'

require('date-utils')
const acho = require('..')
const setDateout = require('set-dateout')

const base = acho({})

const diff = acho({
  diff: true
})

const label = acho({
  align: false,
  keyword: 'worker#1'
})

const visit = acho({
  types: require('acho-skin-cli'),
  keyword: 'symbol'
})

const log = acho({
  keyword: 'log'
})

const getStep = (function () {
  let start = 0
  return function (value) {
    if (value) start += value
    else ++start
    return start
  }
})()

const messageTimeout = (function () {
  return function (level, message, logger, time) {
    setDateout(function () {
      logger[level](message)
    }, new Date().add({ seconds: getStep(0.8) }))
  }
})()

const lineBreakTimeout = (function () {
  return function (time) {
    setDateout(function () {
      console.log()
    }, new Date().add({ seconds: getStep(time || 0.2) }))
  }
})()

console.log()
messageTimeout('info', 'The', base)
messageTimeout('debug', 'Hackable', base)
messageTimeout('warn', 'Log', base)
messageTimeout('error', 'in less than', base)
messageTimeout('fatal', '10KB!.', base)

lineBreakTimeout(1)

messageTimeout('debug', 'support diff', diff)
messageTimeout('debug', 'between messages', diff)

lineBreakTimeout()

messageTimeout('warn', 'adapt the logger label', label)
messageTimeout('warn', 'easily', label)

lineBreakTimeout()

messageTimeout('info', 'pretty serialization', log)

messageTimeout('info', { foo: 'bar', hello: 'world' }, log)

lineBreakTimeout()

messageTimeout(
  'success',
  'See more at https://github.com/Kikobeats/acho',
  visit
)
