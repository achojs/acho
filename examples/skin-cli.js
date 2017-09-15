'use strict'

const acho = require('acho')
const skinCli = require('acho-skin-cli')

const log = acho({
  types: skinCli,
  keyword: 'symbol'
})

console.log()

const types = Object.keys(log.types)
types.forEach(type => {
  log[type]('hello world')
})
