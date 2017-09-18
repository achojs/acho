'use strict'

const should = require('should')

const util = require('./util')
const acho = require('..')
const Acho = acho

describe('acho', () => {
  describe('constructor', () => {
    it('non new keyword', () => should(acho()).be.an.Object())
    it('new keyword', () => should(new Acho()).be.an.Object())
  })

  describe('internal store', () => {
    describe('initialization', () => {
      it('passing a initial store state', () => {
        const log = acho({
          transport: util.createFakeTransport(),
          messages: { info: ['info message'] }
        })
        log.print()
        should(log.transport.store.length).be.equal(1)
      })

      describe('.push', () => {
        it('add message into a internal level collection', () => {
          const log = acho().push('error', 'hello world')
          should(log.messages.error.length).be.equal(1)
        })
      })

      describe('.add', () => {
        it('push and print a message', () => {
          const log = acho({ transport: util.createFakeTransport() })
          log.add('error', 'hello world')
          should(log.transport.store.length).be.equal(1)
          should(log.messages.error.length).be.equal(1)
          should(log.messages.error[0]).be.equal('hello world')
        })
      })
    })

    describe('levels', () => {
      it('print a normal level message', () => {
        const log = acho({ transport: util.createFakeTransport() })
        log.warn('warn message')
        should(log.transport.store.length).be.equal(1)
      })

      it('no ouptut messages out of the level', () => {
        const log = acho({
          transport: util.createFakeTransport(),
          level: 'fatal'
        })
        log.error('test of message')
        should(log.transport.store.length).be.equal(0)
      })
    })

    describe('customization', () => {
      it('default skin', () => {
        const log = acho()
        util.printLogs(log)
        should(!!log.keyword).be.false()
      })

      it('change the color behavior', () => {
        const log = acho({
          transport: util.createFakeTransport(),
          types: { error: { color: ['underline', 'bgRed'] } }
        })
        log.push('error', 'hello world')
        log.print()
        should(log.transport.store.length).be.equal(1)
      })

      it('specifying a keyword', () => {
        const log = acho({ keyword: 'acho' })
        util.printLogs(log)
        should(log.keyword).be.equal('acho')
      })

      it('specifying "symbol" keyword', () => {
        const log = acho({ keyword: 'symbol' })
        util.printLogs(log)
        should(log.keyword).be.equal('symbol')
      })

      it('enabling diff between logs', done => {
        const log = acho({
          diff: true,
          trace: true
        })
        const warn = setInterval(
          () => log.warn('hello world'),
          util.randomInterval(1000, 2000)
        )
        const err = setInterval(
          () => log.error('oh noes!'),
          util.randomInterval(2000, 2500)
        )
        setTimeout(() => {
          clearInterval(warn)
          clearInterval(err)
          done()
        }, 5000)
      })
    })
  })
})
