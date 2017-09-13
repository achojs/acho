'use strict'

chalk = require 'chalk'

isHexColor = (str) -> str.charAt(0) is '#'

module.exports =
  getColor: (color) ->
    if isHexColor(color) then chalk.hex(color) else chalk[color]

  colorize: (value, color) => @getColor(color)(value)
