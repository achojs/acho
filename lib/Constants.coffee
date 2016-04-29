'use strict'

figure =
  false:
    info    : 'ℹ'
    success : '✔'
    warning : '⚠'
    error   : '✖'

  true:
    info    : 'i'
    success : '√'
    warning : '‼'
    error   : '×'

module.exports =
  DECORATE_COUNTER_ZERO_N : 4
  MIN_DIFF_MS             : 10000
  UNMUTED                 : 'all'
  LINE_COLOR              : 'gray'
  SYMBOL_KEYWORD          : 'symbol'
  MUTED                   : 'muted'
  ENV                     : do -> process?.env.NODE_ENV?.toLowerCase() or undefined
  FIGURE                  : figure[process.platform is 'win32']
