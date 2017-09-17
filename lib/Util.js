'use strict'

const chalk = require('chalk')

const isHexColor = str => str.charAt(0) === '#'

const getChalkColor = color =>
  isHexColor(color) ? chalk.hex(color) : chalk[color]

const getColor = colors => colors.map(color => getChalkColor(color))

const colorize = (colors, value) => getColor(colors)(value)

module.exports = { getColor, colorize }
