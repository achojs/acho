'use strict'

Acho = require '..'
util = require './util'
skinCli = require 'acho-skin-cli'

inlineSkin =
  types:
    pokemon:
      level : 4
      color : 'blue'

describe 'Acho :: skin', ->
  it 'load an skin', ->
    AchoCLI = Acho.skin(skinCli)

    instance = AchoCLI
      uppercase: true

    levels = Object.keys(instance.types)
    levels.should.be.eql ['debug', 'info', 'success', 'warn', 'error']
