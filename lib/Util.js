'use strict'

const chalk = require('chalk')

const isHexColor = str => str.charAt(0) === '#'

const getChalkColor = color =>
  isHexColor(color) ? chalk.hex(color) : chalk[color]

const getColor = colors => {
  let stylize
  for (const color of colors) stylize = getChalkColor(color)
  return stylize
}

const colorize = (colors, value) => getColor(colors)(value)

module.exports = { getColor, colorize }
