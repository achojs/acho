'use strict'

const chalk = require('chalk')

const isHexColor = str => str.charAt(0) === '#'

const getChalkColor = function (color) {
  return isHexColor(color) ? chalk.hex(color) : chalk[color]
}

const getColor = function (colors) {
  let stylize
  for (const color of colors) stylize = getChalkColor(color)
  return stylize
}

const colorize = (colors, value) => getColor(colors)(value)

const isEmpty = arr => arr.length === 0
const isString = obj => typeof obj === 'string'
const isSymbol = obj => typeof obj === 'symbol'
const isObject = obj => typeof obj === 'object'
const isBuffer = buf => buf instanceof Buffer
const isError = err => err instanceof Error
const isDate = date => date instanceof Date
const isFalsy = value => [null, undefined, false].indexOf(value) !== -1
const isArray = arr => Array.isArray(arr)
const hasWhiteSpace = s => s.indexOf(' ') !== -1

module.exports = {
  getColor,
  colorize,
  isString,
  isEmpty,
  isSymbol,
  isObject,
  isBuffer,
  isError,
  isDate,
  isFalsy,
  isArray,
  hasWhiteSpace
}
