'use strict'

const acho = require('acho')

const log = acho({ upperCase: true })
const types = Object.keys(log.types)
types.forEach(type => {
  log[type]('hello world')
})
