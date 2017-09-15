'use strict'

{createFormatter} = require 'fmt-obj'
slice = require 'sliced'

{getColor, colorize} = require './Util'
CONST = require './Constants'

ESCAPE_REGEX = /%{2,2}/g
TYPE_REGEX = /(%?)(%([Jjds]))/g

isEmpty = (arr) -> arr.length is 0
isString = (obj) -> typeof obj is 'string'
isSymbol = (obj) -> typeof obj is 'symbol'
isObject = (obj) -> typeof obj is 'object'
isBuffer = (buf) -> buf instanceof Buffer
isError = (err) -> err instanceof Error
isDate = (date) -> date instanceof Date
isFalsy = (value) -> [null, undefined, false].indexOf(value) isnt -1
isArray = (arr) -> Array.isArray(arr)
hasWhiteSpace = (s) -> s.indexOf(' ') isnt -1

prettyObj = (obj, color, opts) ->
  lineColor = getColor(CONST.LINE_COLOR)
  {offset, depth} = opts

  fmtObj = createFormatter({
    offset,
    formatter: {
      punctuation: lineColor
      annotation: lineColor
      property: getColor(color)
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

  unless isObject obj
    obj = "'#{obj}'" if key and isString(obj) and hasWhiteSpace(obj)
    return if key then "#{key}=#{obj}" else obj

  if isBuffer obj
    obj = obj.toString 'base64'
    return if key then "#{key}=#{obj}" else obj

  return obj.message or obj if isError obj

  msg = ''
  keys = Object.keys obj
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
    else if isDate value
      msg += key + '=' + value
    else
      msg += serialize(value, color, colorize(color, key))
    if i < length - 1
      msg += ' '
    i++
  msg

format = (opts) ->
  (messages) ->
    args = slice arguments, 1
    color = args.pop()

    unless isEmpty args
      messages = messages.replace(TYPE_REGEX, (match, escaped, ptn, flag) ->
        arg = args.shift()
        switch flag
          when 's'
            arg = colorize(color, String(arg))
          when 'd'
            arg = colorize(color, Number(arg))
          when 'j'
            arg = serialize arg, color
          when 'J'
            arg = prettyObj arg, color, opts
        return arg if !escaped
        args.unshift arg
        match
      )
      messages += ' ' + serialize arg, color for arg in args unless isEmpty args

    messages = messages.replace(ESCAPE_REGEX, '%') if messages.replace?
    serialize messages, color

module.exports = format
