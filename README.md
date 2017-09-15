# acho

<p align="center">
  <br>
  <img src="https://i.imgur.com/qdpBpnw.gif" alt="acho">
  <br>
</p>

![Last version](https://img.shields.io/github/tag/achohq/acho.svg?style=flat-square)
[![Build Status](http://img.shields.io/travis/achohq/acho/master.svg?style=flat-square)](https://travis-ci.org/achohq/acho)
[![Coverage Status](https://img.shields.io/coveralls/achohq/acho.svg?style=flat-square)](https://coveralls.io/github/achohq/acho)
[![Dependency status](http://img.shields.io/david/achohq/acho.svg?style=flat-square)](https://david-dm.org/achohq/acho)
[![Dev Dependencies Status](http://img.shields.io/david/dev/achohq/acho.svg?style=flat-square)](https://david-dm.org/achohq/acho#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/acho.svg?style=flat-square)](https://www.npmjs.org/package/acho)
[![Donate](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://paypal.me/kikobeats)

> The Hackable Log

# Why

* Easy to use, customize and extend.
* Expressive API with chaineable methods.
* Mininum dependencies, just focussing on one thing.
* Compatible with AMD/CommonJS or just global object in the browser.

## Install

```bash
npm install acho
```

## Usage

The first thing you need to do is create a new log instance:

```js
const log = acho()
```

Then you can print one of the defaults logging levels:

```
const log = acho()
const types = Object.keys(log.types)
types.forEach(type => {
  log[type]('hello world')
})
```

All public methods are chainable:

<p align="center">
  <br>
  <img src="docs/images/01.png" alt="acho">
  <br>
</p>

```js
acho
.info('hello world')
.error('something bad happens');
```

### Logging level

Establishing the loglevel is a good way to filter out undesired information from output. The available levels by default are:

- `fatal` : Display calls to `.fatal()` messages.
- `error` : Display calls to `.fatal()`, `.error()` messages.
- `warn`  : Display calls from `.fatal()`, `.error()`, `.warn()` messages.
- `info`  : Display calls from `.fatal()`, `.error()`, `.warn()`, `info()` messages.
- `debug` : Display calls from `.fatal()`, `.error()`, `.warn()`, `info()`, `debug()` messages.

Additionally exists two special levels:

- `muted` :  Avoid all output.
- `all`   : Allow print all message types.

The default log level is `all`. You can define it in the constructor:

```js
const log = acho({level: 'debug'})
```

or at runtime:

```js
log.level = 'debug';
```

See more at [examples/levels](https://github.com/achohq/acho/blob/master/examples/levels.js).

### Customize logging levels

### skin-cli
### skin-syslog

### Internal Store

Sometimes, when you are interacting with a logger you need to store the logs to be used later instead of print all of them.

We define `.push` as accumulator for store the log internally:

<p align="center">
  <br>
  <img src="docs/images/02.png" alt="acho">
  <br>
</p>

```js
acho.push('success', 'good job', 'well done', 'great!');
console.log(acho.messages.success);
```

If you want to print previously stored messages, just call the method `print`:

<p align="center">
  <br>
  <img src="docs/images/03.png" alt="acho">
  <br>
</p>

```js
acho.print()
```

or you can retrieve the logs programatically from the internal storage  at `acho.messages`

The method  `.add` combine `.push` and `.print` actions in one: It store the message internally but also print the log.

<p align="center">
  <br>
  <img src="docs/images/04.png" alt="acho">
  <br>
</p>

```js
acho.add('info', 'this message is printed and stored');
console.log(acho.messages.info)
```

## Formatters

We use [printf-style](https://wikipedia.org/wiki/Printf_format_string) formatting. Below are the officially supported formatters:

| Formatter | Representation                                                |
|-----------|---------------------------------------------------------------|
| `%s`      | String.                                                       |
| `%d`      | Number (both integer and float).                              |
| `%j`      | JSON serialization in one line                                |
| `%J`      | JSON pretty object in multiple lines                          |
| `%%`      | Single percent sign ('%'). This does not consume an argument. |

By default, the `%j` is applied when you pass an object to be logged:

```js
acho.info({hello: 'world', foo: 'bar'})
// => 'info hello=world foo=bar'
```

If you want to use a different formatter, use printf markup:

```js
acho.info('formatting with object interpolation %J', {
  hello: 'world',
  foo: 'bar',
  deep: {
    foo: 'bar',
    arr: [1, 2, 3, 4, 5]
  }
})

// info formatting with object interpolation
//  hello: "world"
//    foo: "bar"
//   deep:
//         foo: "bar"
//         arr:
//              0: 1
//              1: 2
//              2: 3
//              3: 4
//              4: 5
```

See more at [examples/formatter](https://github.com/achohq/acho/blob/master/examples/formatter.js).

### Customization

You can completely customize the library to your requirements: changes colors, add more types, sort the priorities... the internal structure of the object is public and you can edit it dynamically. **You have the power**.

By default the messages structure is brief: Just the message type followed by the message itself.

But you can easily modify the output. For example, let's add a timestamp to each message:

<p align="center">
  <br>
  <img src="docs/images/05.png" alt="acho">
  <br>
</p>

```js
var acho = Acho({
  color: true,
  level: 'debug',

  // Customize how to print the 'type' of each message
  outputType: function(type) {
    return '[' + type + '] » ';
  },

  // Customize how to print the message.
  // Add things before and/or after.
  outputMessage: function(message) {
    return Date() + ' :: ' + message;
  }
});

acho.info('I am hungry');
```

If you need customize more the output you can setup `.print` `.generateMessage` (see below) that are a more low level methods for generate and print the output message.

## API

### Acho([options])

It creates a logger instance. Available options:

##### **{String}** keyword

![](docs/images/07.png)

Default: `loglevel`

Instead of print the type log level, print the keyword. By default this behavior is not activated.

You can pass the special keyword `symbol` to show an unicode icon. This is special behavior for CLI programs.

##### **{String}** align

![](docs/images/08.png)

Default: `' '`

It adds an alignment separator between the type of the message and the message.

You can provide your own separator or disable it providing a `false`.

##### **{Boolean}** diff

![](docs/images/06.png)

Default: `false`

Prints timestamp between log from the same level. Specially useful to debug timings.

##### **{Boolean}** color

Default: `true`.

Enable or disable colorized output.

##### **{Boolean}** upperCase

Default: `false`.

Enable or disable print log level in upper case.

##### **{Boolean|Number}** timestamp

Default: `false`.

Prints a numeric counter timestamp associated with each log line. 

The value provided is the minimum quantity of time in milliseconds to consider print a different counter.

##### **{Number}** offset

Default: `2`.

The amount of left whitespace between the property key and all of it's sub-properties.

This option is only applied under JSON pretty object in multiple lines (%J).

##### **{Number}** depth

Default: `Infinity`.

Colapses all properties deeper than specified by depth.

This option is only applied under JSON pretty object in multiple lines (%J).

##### **{String}** level

Default: `all`

Provides the logging level. This sets from what level print logs using tranport.

Additionally you can provide `muted` to express don't print logs.

##### **{Function}** transport

Default: `console.log`

Defines where write the log message.

##### **{Object}** types

You can provide the types and priorities.

##### **{Object}** messages

It provides a initial internal store state per each log level. This option is useful when you want to integrate the logger with the ouptut of a delayed function.

##### **{Function}** print

Provides a function that determines how to print the messages. By default uses `.generateMessage` for generate the mesage that will be outputted.

##### **{Function}** outputType

Provides a function to customize the type in the output.

##### **{Function}** outputMessage

Provides a function to customize the message in the output.

##### **{Function}** generateMessage

Provides a function that generate the message to be outputted. It combines other internal methods for generate the output (as `.isPrintable` or `.colorize`) and normally you are not interested in the definition of it, but you can provide it as option as well.

##### **{Function}** generateTypeMessage

Provides a function used to generate the type message.

### .push({String} &lt;type&gt;, {String} &lt;message&gt;)

Store a message of given `type` internally.

### .add({String} &lt;type&gt;, {String} &lt;message&gt;)

Store a message of given `type` internally and also output it.

For each level you have a function following the pattern:

### .print()

Prints all messages internally stored.

### .\[loglevel\]({String} &lt;message&gt;)

For each log level that you declared in the constructor (or the default log levels provides by the library if you don't declare nothing) will be created a function with the same name to output a message with these log level.

## License

MIT © [Kiko Beats](http://www.kikobeats.com)
