'use strict'

const acho = require('acho')
const skinCli = require('acho-skin-syslog')

const log = acho({
  types: skinCli
})

console.log()

const types = Object.keys(log.types)
types.forEach(type => {
  log[type]('hello world')
})
