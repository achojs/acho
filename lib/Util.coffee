'use strict'

chalk = require 'chalk'

isHexColor = (str) -> str.charAt(0) is '#'

getChalkColor = (color) ->
  if isHexColor(color) then chalk.hex(color) else chalk[color]

getColor = (colors) ->
  (stylize = getChalkColor color) for color in colors
  stylize

colorize = (colors, value) -> getColor(colors)(value)

module.exports = {getColor, colorize}
