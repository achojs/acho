# acho

<h1 align="center">
	<img src="http://i.imgur.com/XtTjX8G.png" alt="acho">
</h1>


[![Build Status](http://img.shields.io/travis/Kikobeats/acho/master.svg?style=flat)](https://travis-ci.org/Kikobeats/acho)
[![Dependency status](http://img.shields.io/david/Kikobeats/acho.svg?style=flat)](https://david-dm.org/Kikobeats/acho)
[![Dev Dependencies Status](http://img.shields.io/david/dev/Kikobeats/acho.svg?style=flat)](https://david-dm.org/Kikobeats/acho#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/acho.svg?style=flat)](https://www.npmjs.org/package/acho)
[![Gittip](http://img.shields.io/gittip/Kikobeats.svg?style=flat)](https://www.gittip.com/Kikobeats/)

> An extremely simple (but powerful) logging system for NodeJS and browser.

# Why

* Very easy to use, customize and extend.
* Expressive API with chaineable methods.
* Mininum dependencies, just focussing on one thing.

## Install

```bash
npm install acho
```

If you want to use it in the browser (powered by [Browserify](http://browserify.org/)):

```bash
bower install acho --save
```

and later add it to your HTML:

```html
<script src="bower_components/acho/dist/acho.js"></script>
```

## Usage

### First steps

To use it, you just create a new logger instance.

```js
var Acho = require('acho');
var acho = new Acho({color: true});
```

It's time to use it!

```js
acho.info('hello world');
// => 'hello world'
```

All public methods are chaineables:

```js
acho
.info('hello world')
.error('something bad happens');
// => 'info: hello world'
// => 'error: 'something bard happens'
```

Maybe you don't want to output the message, but store it for later use:

```js
acho.push('success', 'good job!');
console.log(acho.messages.success);
// => ['good job']
```

If you want to print previously stored messages, just call the method `print`:

```js
acho.print()
// => 'success: good job!'
```

You might be thinking: Can I combine both, to store and both print a message? Absolutely!

```js
acho.add('info', 'this message is printed and stored');
// => 'info: 'this message is printed and stored'
console.log(acho.messages.info)
// => ['this message is printed and stored']
```

You can also modify the print method!

```js
acho.print = function() {
  // You are in the acho scope, so you can use the properties
  // of the object. Check the API documentation.
  console.log();
  var _this = this;
  Object.keys(this.types).forEach(function(type) {
    // if (isSuccessOrInfoMessage(type)) console.log();
    _this.messages[type].forEach(function(message) {
      _this.printLine(type, message);
    });
  });
};
```

You can completely customize the library to your requirements: changes colors, add more types, sort the priorities... the internal structure of the object is public and you can edit it dynamically. **You have the power**.

### Defining the level

Establishing the loglevel is a good way to filter out undesired information from output. The available levels are:

- `error`:   Display calls to `.error()` messages.
- `warning`: Display calls from `.error()`, `.warning()` messages.
- `success`: Display calls from `.error()`, `.warning()`, `success()` messages.
- `info`:    Display calls from `.error()`, `.warning()`, `success()`, `info()` messages.
- `verbose`: Display calls from `.error()`, `.warning()`, `success()`, `info()`, `verbose()` messages.
- `debug`:   Display calls from `.error()`, `.warning()`, `success()`, `info()`, `verbose()`, `debug()` messages.
- `silly`:   Display calls from `.error()`, `.warning()`, `success()`, `info()`, `verbose()`, `debug()`, `silly()` messages.
- `silent`:  Avoid all output.

The default log level is `info`. You can define it in the the constructor:

```js
var acho = new Acho({level: 'silly'})
```

or at runtime:

```js
acho.level = 'debug';
```

### Customization

By default the messages structure is brief: Just the message type followed by the message itself.

But you can easily modify the output. For example, let's add a timestamp to each message.

To customize the output we offer two methods, `outputType`  and `outputMessage`:

```js
acho = new Acho({
  color: true,
  level: 'silly',
  outputType: function(type) {
    return '[' + type + '] »';
  },

  outputMessage: function(message) {
    return Date() + ' :: ' + message;
  }
});
```

This results in your awesome output:

```js
acho.info('I am hungry');
// => '[ info ] » Fri Mar 13 2015 18:12:48 GMT+0100 (CET) :: I am hungry'
```

You can modify the outputted message at any time.


## API

### .constructor({Object} [options])

Create a new logger. Available options:

- color **{Boolean}**: Enable or disable colorized output. `false` by default.
- level **{String}**: Provide the logging level. `info` by default.
- types **{Object}**: You can provide the types and priorities.
- outputType **{Function}**: Provide a function to customize the type in the output.
- outputMessage **{Function}**: Provide a function to customize the message in the output.
- print **{Function}**: Provide a function to print the messages.

### .push({String} &lt;type&gt;, {String} &lt;message&gt;)

Store a message of given `type` internally.

### .add({String} &lt;type&gt;, {String} &lt;message&gt;)

Store a message of given `type` internally and also output it.

### .error({String} &lt;message&gt;)

Output a `error` message.

### .warning({String} &lt;message&gt;)

Output a `warning` message.

### .success({String} &lt;message&gt;)

Output a `success` message.

### .info({String} &lt;message&gt;)

Output a `info` message.

### .verbose({String} &lt;message&gt;)

Output a `verbose` message.

### .debug({String} &lt;message&gt;)

Output a `debug` message.

### .silly({String} &lt;message&gt;)

Output a `silly` message.

### .isPrintable({String} &lt;type&gt;)

Determines if a type of message should be outputted.

### .colorize({String} &lt;color&gt; {String} &lt;message&gt;)

Determines is a instance of `acho` is outputted with colors.

### .printLine({String} &lt;type&gt; {String} &lt;message&gt;)

Combine `.isPrintable` and `.colorize` to print a line correctly.

### .print()

Default loop to print the messages that are stored internally. By default it uses `.printLine` in each message iteration.

## License

MIT © [Kiko Beats](http://www.kikobeats.com)
