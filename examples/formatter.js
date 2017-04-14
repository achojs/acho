'use strict'

var Acho = require('..')
var acho = Acho()

acho.info('formatting plain text: hello world')
acho.info('formatting with number interpolation %d', 123)
acho.info('formatting with float interpolation %d', 3.14)
acho.info('formatting with string interpolation %s', 'hello world')
acho.info('formatting with object interpolation %j', {hello: 'world', foo: 'bar'})
acho.info('formatting with object interpolation %J', {
  hello: 'world',
  foo: 'bar',
  deep: {
    foo: 'bar',
    arr: [1, 2, 3, 4, 5]
  }
})
