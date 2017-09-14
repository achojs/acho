'use strict'

chalk = require 'chalk'

isHexColor = (str) -> str.charAt(0) is '#'

getColor = (color) ->
  if isHexColor(color) then chalk.hex(color) else chalk[color]

colorize = (colors, value) ->
  stylize = getColor
  (stylize = getColor color) for color in colors
  stylize value

module.exports = {getColor, colorize}
