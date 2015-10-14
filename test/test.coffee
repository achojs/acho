Acho   = require '..'
should = require 'should'

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
    @acho = new Acho(opts)

  it 'create a new object', ->
    (typeof @acho is 'object').should.be.equal true

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
      printLogs new Acho level: 'silly', color: true

    it 'specifying a keyword', ->
      printLogs new Acho level: 'silly', color: true, keyword: 'acho'
