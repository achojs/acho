'use strict'

const { createFormatter } = require('fmt-obj')
const slice = require('sliced')

const { getColor, colorize } = require('./Util')
const CONST = require('./Constants')

const ESCAPE_REGEX = /%{2,2}/g
const TYPE_REGEX = /(%?)(%([Jjds]))/g

const isEmpty = arr => arr.length === 0
const isString = obj => typeof obj === 'string'
const isSymbol = obj => typeof obj === 'symbol'
const isObject = obj => typeof obj === 'object'
const isBuffer = buf => buf instanceof Buffer
const isError = err => err instanceof Error
const isDate = date => date instanceof Date
const isFalsy = value => [null, undefined, false].indexOf(value) !== -1
const isArray = arr => Array.isArray(arr)
const hasWhiteSpace = s => s.indexOf(' ') !== -1

const prettyObj = (obj, color, opts) => {
  const lineColor = getColor(CONST.LINE_COLOR)
  const { offset, depth } = opts

  const fmtObj = createFormatter({
    offset,
    formatter: {
      punctuation: lineColor,
      annotation: lineColor,
      property: getColor(color),
      literal: lineColor,
      number: lineColor,
      string: lineColor
    }
  })

  fmtObj(obj, depth)
}

const serialize = (obj, color, key) => {
  // symbols cannot be directly casted to strings
  isSymbol(isSymbol) && (key = key.toString())
  isSymbol(obj) && (obj = obj.toString())
  isFalsy(obj) && (obj = JSON.stringify(obj))

  if (!isObject(obj)) {
    key && isString(obj) && hasWhiteSpace(obj) && (obj = `'${obj}'`)
    return key ? `${key}=${obj}` : obj
  }

  if (isBuffer(obj)) {
    obj = obj.toString('base64')
    return key ? `${key}=${obj}` : obj
  }

  if (isError(obj)) {
    return obj.message || obj
  }

  let msg = ''
  const keys = Object.keys(obj)
  const length = keys.length
  let i = 0
  while (i < length) {
    key = keys[i]
    const value = obj[key]

    if (isArray(value)) {
      msg += `${key}=[`
      let j = 0
      let l = value.length
      while (j < l) {
        msg += serialize(value[j], color)
        j < l - 1 && (msg += ' ')
        j++
      }
      msg += ']'
    } else if (isDate(value)) {
      msg += `${key}=${value}`
    } else msg += serialize(value, color, colorize(color, key))
    i < length - 1 && (msg += ' ')
    i++
  }
  return msg
}

const format = opts =>
  function (messages) {
    const args = slice(arguments, 1)
    const color = args.pop()

    if (!isEmpty(args)) {
      messages = messages.replace(TYPE_REGEX, (match, escaped, ptn, flag) => {
        let arg = args.shift()
        switch (flag) {
          case 's':
            arg = colorize(color, String(arg))
            break
          case 'd':
            arg = colorize(color, Number(arg))
            break
          case 'j':
            arg = serialize(arg, color)
            break
          case 'J':
            arg = prettyObj(arg, color, opts)
            break
        }
        if (!escaped) {
          return arg
        }
        args.unshift(arg)
        return match
      })
      !isEmpty(args) &&
        (messages += args.map(arg => serialize(arg, color)).join(' '))
    }
    messages.replace && (messages = messages.replace(ESCAPE_REGEX, '%'))
    return serialize(messages, color)
  }

module.exports = format
