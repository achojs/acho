Acho   = require '..'
should = require 'should'

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
    @acho.warning 'warning message'

  it 'change the color behavior',  ->
    @acho.types.error.color = 'red bold'
    @acho.print()

  it 'print the messages', ->
    @acho.print()

  it 'try to print a message out of the level',  ->
    @acho.verbose 'test of message'

  describe 'default colors ::', ->
    acho = new Acho level:'silly', color: true
    acho.error 'error message'
    acho.warning 'warning message'
    acho.success 'success message'
    acho.info 'info message'
    acho.verbose 'verbose message'
    acho.debug 'debug message'
    acho.silly 'silly message'
