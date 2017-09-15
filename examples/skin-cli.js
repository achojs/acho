'use strict'

const acho = require('acho')
const skinCli = require('acho-skin-cli')

const log = acho({
  types: skinCli
})

const logSymbols = acho({
  types: skinCli,
  keyword: 'symbol'
})

const printLogs = log =>
  Object.keys(log.types).forEach(type => {
    log[type]('hello world')
  })

console.log('\nwithout symbols\n')

printLogs(log)

console.log('\nwith symbols\n')

printLogs(logSymbols)
