'use strict'

module.exports =
  DECORATE_COUNTER_ZERO_N : 4
  MIN_DIFF_MS             : 10000
  UNMUTED                 : 'all'
  LINE_COLOR              : 'gray'
  SYMBOL_KEYWORD          : 'symbol'
  MUTED                   : 'silent'
  ENV                     : do -> process?.env.NODE_ENV?.toLowerCase() or undefined
