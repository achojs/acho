Acho   = require '..'
should = require 'should'

randomInterval = (min, max) ->
  Math.floor(Math.random()*(max-min+1)+min)

printLogs = (instance) ->
  instance.error 'error message'
  instance.warn 'warn message'
  instance.success 'success message'
  instance.info 'info message'
  instance.verbose 'verbose message'
  instance.debug 'debug message'
  instance.silly 'silly message'

describe 'Acho ::', ->

  before  ->
    opts =
      color: true
      outputType: (type) -> "[#{type}] » "
    @acho = Acho opts

  it 'create a new object', ->
    @acho.should.be.object

  it 'add a message into the collection', ->
    @acho.push 'error', 'hello world'
    @acho.messages.error.length.should.be.equal 1

  it 'add a message and print', ->
    @acho.add 'error', 'hello world'
    @acho.messages.error.length.should.be.equal 2

  it 'print a normal message', ->
    @acho.warn 'warn message'

  it 'change the color behavior',  ->
    @acho.types.error.color = 'red bold'
    @acho.print()

  it 'print the messages', ->
    @acho.print()

  it 'try to print a message out of the level',  ->
    @acho.verbose 'test of message'

  describe 'logs', ->
    it 'default skin', ->
      printLogs Acho level: 'silly', color: true

    it 'specifying a keyword', ->
      printLogs Acho level: 'silly', color: true, keyword: 'acho'

    it 'enabling diff between logs', (done) ->
      acho = Acho
        level: 'silly'
        color: true
        diff: true

      printWarn = -> acho.warn 'hello world'
      printErr = -> acho.error 'oh noes!'

      warn = setInterval(printWarn, randomInterval(1000, 2000))
      err = setInterval(printErr, randomInterval(2000, 2500))

      setTimeout(->
        clearInterval warn
        clearInterval err
        done()
      , 10000)
