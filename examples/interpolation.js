'use strict'

const acho = require('..')
const log = acho()

console.log()

log.info('format text', 'hello world')
log.info('format number interpolation %d', 123)
log.info('format float interpolation %d', 3.14)
log.info('format string interpolation %s', 'hello world')
log.info('format object interpolation %j', {
  hello: 'world',
  foo: 'bar'
})

log.info('format beauty object interpolation %J', {
  hello: 'world',
  foo: 'bar',
  deep: {
    foo: 'bar',
    arr: [1, 2, 3, 4, 5]
  }
})
