'use strict'

Acho   = require '..'
util = require './util'
should = require 'should'

describe 'Acho ::', ->

  beforeEach ->
    opts =
      color: true
      outputType: (type) -> "[#{type}] » "
      transport: util.createFakeTransport()
    @acho = Acho opts

  describe 'initialization', ->

    it 'invoke constructor without new keyword', ->
      @acho.should.be.an.object

    it 'invoke constructor new keyword', ->
      new Acho().should.be.an.object

  describe 'internal store', ->

    it 'passing a initial store state', ->
      instance = Acho
        transport: util.createFakeTransport()
        messages:
          info: ['info message']

      instance.print()
      instance.transport.store.length.should.be.equal 1
      expected = ' \u001b[34minfo\u001b[39m \u001b[90minfo message\u001b[39m'
      instance.transport.store[0].should.be.equal expected

    it '.push: add message into a internal level collection', ->
      @acho.push 'error', 'hello world'
      @acho.messages.error.length.should.be.equal 1

    it '.add: push and print a message', ->
      @acho.add 'error', 'hello world'

      @acho.transport.store.length.should.be.equal 1
      @acho.messages.error.length.should.be.equal 1

      expected = '\u001b[31m[error] » \u001b[39m \u001b[90mhello world\u001b[39m'
      @acho.transport.store[0].should.be.equal expected
      @acho.messages.error[0].should.be.equal 'hello world'

  describe 'print', ->

    it 'print a normal level message', ->
      @acho.warn 'warn message'

      @acho.transport.store.length.should.be.equal 1
      expected = ' \u001b[33m[warn] » \u001b[39m \u001b[90mwarn message\u001b[39m'
      @acho.transport.store[0].should.be.equal expected

    it 'change the color behavior',  ->
      @acho.types.error.color = 'red bold'
      @acho.push 'error', 'hello world'
      @acho.print()

      @acho.transport.store.length.should.be.equal 1
      expected = '\u001b[31m\u001b[1m[error] » \u001b[22m\u001b[39m \u001b[90mhello world\u001b[39m'
      @acho.transport.store[0].should.be.equal expected

    it 'no ouptut messages out of the level',  ->
      level = @acho.level
      @acho.level = 'fatal'
      @acho.error 'test of message'
      @acho.transport.store.length.should.be.equal 0

  describe 'customization', ->
    it 'default skin', ->
      instance = Acho()
      util.printLogs instance
      (instance.keyword?).should.be.false

    it 'specifying a keyword', ->
      instance = Acho color: true, keyword: 'acho'
      util.printLogs instance
      instance.keyword.should.be.equal 'acho'

    it 'specifying a special "symbol" keyword', ->
      instance = Acho color: true, keyword: 'symbol'
      util.printLogs instance
      instance.keyword.should.be.equal 'symbol'

    it 'enabling diff between logs', (done) ->
      acho = Acho color: true, diff: true, timestamp: true, align: false
      printWarn = -> acho.warn 'hello world'
      printErr = -> acho.error 'oh noes!'

      warn = setInterval(printWarn, util.randomInterval(1000, 2000))
      err = setInterval(printErr, util.randomInterval(2000, 2500))

      setTimeout(->
        clearInterval warn
        clearInterval err
        done()
      , 5000)
