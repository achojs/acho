'use strict'

REGEX =
  escape: /%{2,2}/g
  type: /(%?)(%([jds]))/g

serialize = (obj, key) ->
  # symbols cannot be directly casted to strings
  if typeof key == 'symbol'
    key = key.toString()
  if typeof obj == 'symbol'
    obj = obj.toString()
  if obj == null
    obj = 'null'
  else if obj == undefined
    obj = 'undefined'
  else if obj == false
    obj = 'false'
  if typeof obj != 'object'
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
        msg += serialize(obj[keys[i]][j])
        if j < l - 1
          msg += ', '
        j++
      msg += ']'
    else if obj[keys[i]] instanceof Date
      msg += keys[i] + '=' + obj[keys[i]]
    else
      msg += serialize(obj[keys[i]], keys[i])
    if i < length - 1
      msg += ', '
    i++
  msg

format = (fmt) ->
  args = Array::slice.call(arguments, 1)
  if args.length
    fmt = fmt.replace(REGEX.type, (match, escaped, ptn, flag) ->
      arg = args.shift()
      switch flag
        when 's'
          arg = '' + arg
        when 'd'
          arg = Number(arg)
        when 'j'
          arg = serialize arg
      return arg if !escaped
      args.unshift arg
      match
    )

  fmt += ' ' + serialize arg for arg in args if args.length
  fmt = fmt.replace(REGEX.escape, '%') if fmt.replace?
  serialize fmt

module.exports = format
