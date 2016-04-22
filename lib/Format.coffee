'use strict'

chalk = require 'chalk'

REGEX =
  escape: /%{2,2}/g
  type: /(%?)(%([jds]))/g

hasWhiteSpace = (s) ->
  s.indexOf(' ') isnt -1

serialize = (color, obj, key) ->
  # symbols cannot be directly casted to strings
  if typeof key is 'symbol'
    key = key.toString()
  if typeof obj is 'symbol'
    obj = obj.toString()
  if obj is null
    obj = 'null'
  else if obj is undefined
    obj = 'undefined'
  else if obj is false
    obj = 'false'
  if typeof obj isnt 'object'
    obj = '\'' + obj + '\'' if key and typeof obj is 'string' and hasWhiteSpace(obj)
    return if key then key + '=' + obj else obj
  if obj instanceof Buffer
    return if key then key + '=' + obj.toString('base64') else obj.toString('base64')
  msg = ''
  keys = Object.keys(obj)
  length = keys.length
  i = 0
  while i < length
    if Array.isArray(obj[keys[i]])
      msg += keys[i] + '=['
      j = 0
      l = obj[keys[i]].length
      while j < l
        msg += serialize(color, obj[keys[i]][j])
        if j < l - 1
          msg += ' '
        j++
      msg += ']'
    else if obj[keys[i]] instanceof Date
      msg += keys[i] + '=' + obj[keys[i]]
    else
      msg += serialize(color, obj[keys[i]], chalk[color](keys[i]))
    if i < length - 1
      msg += ' '
    i++
  msg

format = (fmt) ->
  args = Array::slice.call(arguments, 1)
  color = args.pop()

  if args.length
    fmt = fmt.replace(REGEX.type, (match, escaped, ptn, flag) ->
      arg = args.shift()
      switch flag
        when 's'
          arg = '' + arg
        when 'd'
          arg = Number(arg)
        when 'j'
          arg = serialize color, arg
      return arg if !escaped
      args.unshift arg
      match
    )

  fmt += ' ' + serialize color, arg for arg in args if args.length
  fmt = fmt.replace(REGEX.escape, '%') if fmt.replace?
  serialize color, fmt

module.exports = format
