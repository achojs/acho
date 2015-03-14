var Acho = require('./index.js');

var acho = new Acho({
  level: 'silly',
  color: true
});

acho.error('error message');
acho.warning('warning message');
acho.success('success message');
acho.info('info message');
acho.verbose('verbose message');
acho.debug('debug message');
acho.silly('silly message');
