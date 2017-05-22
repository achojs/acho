'use strict'

{createFormatter} = require 'fmt-obj'
slice = require 'sliced'
chalk = require 'chalk'

CONST = require './Constants'

ESCAPE_REGEX = /%{2,2}/g
TYPE_REGEX = /(%?)(%([Jjds]))/g

isString = (obj) -> typeof obj is 'string'
isSymbol = (obj) -> typeof obj is 'symbol'
isObject = (obj) -> typeof obj is 'object'
isFalsy = (value) -> [null, undefined, false].indexOf(value) isnt -1
isArray = (arr) -> Array.isArray(arr)
hasWhiteSpace = (s) -> s.indexOf(' ') isnt -1

colorize = (value, color) -> chalk[color](value)

prettyObj = (obj, color, opts = {}) ->
  lineColor = chalk[CONST.LINE_COLOR]
  {offset = 2, depth = Infinity} = opts

  fmtObj = createFormatter({
    offset,
    formatter: {
      punctuation: lineColor
      annotation: lineColor
      property: chalk[color]
      literal: lineColor
      number: lineColor
      string: lineColor
    }
  })

  fmtObj(obj, depth)

serialize = (obj, color, key) ->
  # symbols cannot be directly casted to strings
  key = key.toString() if isSymbol key
  obj = obj.toString() if isSymbol obj
  obj = JSON.stringify obj if isFalsy obj

  if !isObject obj
    obj = "'#{obj}'" if key and isString(obj) and hasWhiteSpace(obj)
    return if key then "#{key}=#{obj}" else obj

  if obj instanceof Buffer
    obj = obj.toString 'base64'
    return if key then "#{key}=#{obj}" else obj

  return obj.message or obj if obj instanceof Error

  msg = ''
  keys = Object.keys(obj)
  length = keys.length
  i = 0
  while i < length
    key = keys[i]
    value = obj[key]

    if isArray value
      msg += key + '=['
      j = 0
      l = value.length
      while j < l
        msg += serialize(value[j], color)
        if j < l - 1
          msg += ' '
        j++
      msg += ']'
    else if value instanceof Date
      msg += key + '=' + value
    else
      msg += serialize(value, color, colorize(key, color))
    if i < length - 1
      msg += ' '
    i++
  msg

format = (fmt) ->
  args = slice arguments, 1
  color = args.pop()

  if args.length
    fmt = fmt.replace(TYPE_REGEX, (match, escaped, ptn, flag) ->
      arg = args.shift()
      switch flag
        when 's'
          arg = colorize(String(arg), color)
        when 'd'
          arg = colorize(Number(arg), color)
        when 'j'
          arg = serialize arg, color
        when 'J'
          arg = prettyObj arg, color
      return arg if !escaped
      args.unshift arg
      match
    )
    fmt += ' ' + serialize arg, color for arg in args if args.length

  fmt = fmt.replace(ESCAPE_REGEX, '%') if fmt.replace?
  serialize fmt, color

module.exports = format
