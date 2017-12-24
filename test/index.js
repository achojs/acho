/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
'use strict'

const should = require('should')

const util = require('./util')
const acho = require('..')
const Acho = acho

describe('acho', function () {
  describe('constructor', function () {
    it('new keyword', () => should(acho()).be.an.Object())
    it('non new keyword', () => should(new Acho()).be.an.Object())
  })

  describe('internal store', function () {
    describe('initialization', () =>
      it('passing a initial store state', function () {
        const log = acho({
          transport: util.createFakeTransport(),
          messages: {
            info: ['info message']
          }
        })

        log.print()

        return should(log.transport.store.length).be.equal(1)
      }))

    describe('.push', () =>
      it('add message into a internal level collection', function () {
        const log = acho().push('error', 'hello world')
        return should(log.messages.error.length).be.equal(1)
      }))

    return describe('.add', () =>
      it('push and print a message', function () {
        const log = acho({ transport: util.createFakeTransport() })
        log.add('error', 'hello world')

        should(log.transport.store.length).be.equal(1)
        should(log.messages.error.length).be.equal(1)
        return should(log.messages.error[0]).be.equal('hello world')
      }))
  })

  describe('levels', function () {
    it('print a normal level message', function () {
      const log = acho({ transport: util.createFakeTransport() })
      log.warn('warn message')

      return should(log.transport.store.length).be.equal(1)
    })

    return it('no ouptut messages out of the level', function () {
      const log = acho({
        transport: util.createFakeTransport(),
        level: 'fatal'
      })

      log.error('test of message')
      return should(log.transport.store.length).be.equal(0)
    })
  })

  return describe('customization', function () {
    it('default skin', function () {
      const log = acho()
      util.printLogs(log)
      return should(log.keyword != null).be.false()
    })

    it('change the color behavior', function () {
      const log = acho({
        transport: util.createFakeTransport(),
        types: {
          error: { color: ['underline', 'bgRed'] }
        }
      })

      log.push('error', 'hello world')
      log.print()

      return should(log.transport.store.length).be.equal(1)
    })

    it('specifying a keyword', function () {
      const log = acho({ keyword: 'acho' })
      util.printLogs(log)
      return should(log.keyword).be.equal('acho')
    })

    it('specifying "symbol" keyword', function () {
      const log = acho({ keyword: 'symbol' })
      util.printLogs(log)
      return should(log.keyword).be.equal('symbol')
    })

    return it('enabling diff between logs', function (done) {
      const log = acho({
        diff: true,
        trace: true
      })

      const printWarn = () => log.warn('hello world')
      const printErr = () => log.error('oh noes!')

      const warn = setInterval(printWarn, util.randomInterval(1000, 2000))
      const err = setInterval(printErr, util.randomInterval(2000, 2500))

      return setTimeout(function () {
        clearInterval(warn)
        clearInterval(err)
        return done()
      }, 5000)
    })
  })
})
