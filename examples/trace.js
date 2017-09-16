'use strict'

const Acho = require('..')
const acho = Acho({
  diff: true,
  trace: 1000
  // upper: true,
  // keyword: 'symbol'
})

const levels = Object.keys(acho.types)

const fixtureObj = {
  foo: 'bar',
  hello: 'world'
}

const fixtureArr = [1, 2, 3, 4, 5]

acho.debug('%j', fixtureObj)
acho.debug(fixtureObj)
acho.debug(fixtureArr)

levels.forEach(function (level) {
  setInterval(function () {
    acho[level]('This is a auto-generated ' + level + ' message')
    acho[level](fixtureObj)
  }, 1000)
})
