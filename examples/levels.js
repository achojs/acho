'use strict'

var Acho = require('..')
var acho = Acho({
  diff: true,
  timestamp: true,
  upperCase: true,
  context: 'generated'
  // keyword: 'symbol'
})

var levels = Object.keys(acho.types)

var fixtureObj = {
  foo: 'bar',
  hello: 'world'
}

var fixtureArr = [1, 2, 3, 4, 5]

acho.debug('%j', fixtureObj)
acho.debug(fixtureObj)
acho.debug(fixtureArr)

levels.forEach(function (level) {
  setInterval(function () {
    acho[level]('This is a auto-generated ' + level + ' message')
    acho[level](fixtureObj)
  }, 1000)
})
