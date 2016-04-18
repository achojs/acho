Acho   = require '..'
should = require 'should'

randomInterval = (min, max) ->
  Math.floor(Math.random()*(max-min+1)+min)

printLogs = (acho) ->
  acho.error 'error message'
  acho.warn 'warn message'
  acho.success 'success message'
  acho.info 'info message'
  acho.verbose 'verbose message'
  acho.debug 'debug message'
  acho.silly 'silly message'

createFakeTransport = ->
  store = []
  transport = ->
    console.log.apply(console, arguments)
    store.push.apply(store, arguments)
  transport.store = store
  transport

describe 'Acho ::', ->

  beforeEach ->
    opts =
      color: true
      outputType: (type) -> "[#{type}] » "
      transport: createFakeTransport()
    @acho = Acho opts

  describe 'initialization', ->

    it 'invoke constructor without new keyword', ->
      @acho.should.be.an.object

    it 'invoke constructor new keyword', ->
      new Acho().should.be.an.object

  describe 'internal store', ->

    it 'passing a initial store state', ->
      instance = Acho
        transport: createFakeTransport()
        messages:
          info: ['info message']

      instance.print()
      instance.transport.store.length.should.be.equal 1
      expected = '\u001b[37minfo\t\u001b[39m\u001b[90minfo message\u001b[39m'
      instance.transport.store[0].should.be.equal expected

    it '.push: add message into a internal level collection', ->
      @acho.push 'error', 'hello world'
      @acho.messages.error.length.should.be.equal 1

    it '.add: push and print a message', ->
      @acho.add 'error', 'hello world'

      @acho.transport.store.length.should.be.equal 1
      @acho.messages.error.length.should.be.equal 1

      expected = '\u001b[31m[error] » \u001b[39m\u001b[90mhello world\u001b[39m'
      @acho.transport.store[0].should.be.equal expected
      @acho.messages.error[0].should.be.equal 'hello world'

  describe 'print', ->

    it 'print a normal level message', ->
      @acho.warn 'warn message'

      @acho.transport.store.length.should.be.equal 1
      expected = '\u001b[33m[warn] » \u001b[39m\u001b[90mwarn message\u001b[39m'
      @acho.transport.store[0].should.be.equal expected

    it 'change the color behavior',  ->
      @acho.types.error.color = 'red bold'
      @acho.push 'error', 'hello world'
      @acho.print()

      @acho.transport.store.length.should.be.equal 1
      expected = '\u001b[31m\u001b[1m[error] » \u001b[22m\u001b[39m\u001b[90mhello world\u001b[39m'
      @acho.transport.store[0].should.be.equal expected

    it 'no ouptut messages out of the level',  ->
      level = @acho.level
      @acho.level = 'success'
      @acho.verbose 'test of message'
      @acho.transport.store.length.should.be.equal 0

  describe 'customization', ->
    it 'default skin', ->
      instance = Acho level: 'silly', color: true
      printLogs instance
      (instance.keyword?).should.be.false

    it 'specifying a keyword', ->
      instance = Acho level: 'silly', color: true, keyword: 'acho'
      printLogs instance
      instance.keyword.should.be.equal 'acho'

    it 'specifying a special "symbol" keyword', ->
      instance = Acho level: 'silly', color: true, keyword: 'symbol'
      printLogs instance
      instance.keyword.should.be.equal 'symbol'

    it 'enabling diff between logs', (done) ->
      acho = Acho
        level: 'silly'
        color: true
        diff: true
        align: false

      printWarn = -> acho.warn 'hello world'
      printErr = -> acho.error 'oh noes!'

      warn = setInterval(printWarn, randomInterval(1000, 2000))
      err = setInterval(printErr, randomInterval(2000, 2500))

      setTimeout(->
        clearInterval warn
        clearInterval err
        done()
      , 5000)
