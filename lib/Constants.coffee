'use strict'

module.exports =
  MIN_DIFF_MS: 10000
  MUTED: 'silent'
  UNMUTED: 'all'
  SYMBOL_KEYWORD: 'symbol'
  ENV: do -> process?.env.NODE_ENV?.toLowerCase() or undefined
