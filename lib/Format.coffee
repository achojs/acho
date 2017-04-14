'use strict'

slice = require 'sliced'
chalk = require 'chalk'

ESCAPE_REGEX = /%{2,2}/g
TYPE_REGEX = /(%?)(%([jds]))/g

isString = (obj) -> typeof obj is 'string'
isSymbol = (obj) -> typeof obj is 'symbol'
isObject = (obj) -> typeof obj is 'object'
isFalsy = (value) -> [null, undefined, false].indexOf(value) isnt -1
isArray = (arr) -> Array.isArray(arr)
colorize = (value, color) -> chalk[color](value)
hasWhiteSpace = (s) -> s.indexOf(' ') isnt -1

serialize = (color, obj, key) ->
  # symbols cannot be directly casted to strings
  key = key.toString() if isSymbol key
  obj = obj.toString() if isSymbol obj
  obj = JSON.stringify obj if isFalsy obj

  if !isObject obj
    obj = "'#{obj}'" if key and isString obj and hasWhiteSpace obj
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

    if isArray(value)
      msg += key + '=['
      j = 0
      l = value.length
      while j < l
        msg += serialize(color, value[j])
        if j < l - 1
          msg += ' '
        j++
      msg += ']'
    else if value instanceof Date
      msg += key + '=' + value
    else
      msg += serialize(color, value, colorize(key, color))
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
          arg = serialize color, arg
      return arg if !escaped
      args.unshift arg
      match
    )

  fmt += ' ' + serialize color, arg for arg in args if args.length
  fmt = fmt.replace(ESCAPE_REGEX, '%') if fmt.replace?
  serialize color, fmt

module.exports = format
