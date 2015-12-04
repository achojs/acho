# acho

<p align="center">
  <br>
  <img src="https://i.imgur.com/qdpBpnw.gif" alt="acho">
  <br>
</p>

![Last version](https://img.shields.io/github/tag/Kikobeats/acho.svg?style=flat-square)
[![Build Status](http://img.shields.io/travis/Kikobeats/acho/master.svg?style=flat-square)](https://travis-ci.org/Kikobeats/acho)
[![Dependency status](http://img.shields.io/david/Kikobeats/acho.svg?style=flat-square)](https://david-dm.org/Kikobeats/acho)
[![Dev Dependencies Status](http://img.shields.io/david/dev/Kikobeats/acho.svg?style=flat-square)](https://david-dm.org/Kikobeats/acho#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/acho.svg?style=flat-square)](https://www.npmjs.org/package/acho)
[![Donate](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://paypal.me/kikobeats)

> An extremely simple (but powerful) logging system for NodeJS and browser.

# Why

* Very easy to use, customize and extend.
* Expressive API with chaineable methods.
* Mininum dependencies, just focussing on one thing.
* Compatible with AMD/CommonJS or just global object in the browser.

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

Acho exports itself according to UMD best practices, which means that no matter where you are using the library, you get a version tailored for your environment.

If you're using a module loader (or Node), simple require the library as you would any other module.

If you're using a browser, the library falls back to attaching itself to window as the global `Acho`.

#### CommonJS

```js
var Acho = require('acho');
var acho = Acho();
```

#### Global/Browser

```js
var acho = Acho();
```

#### AMD

I don't use personally use AMD, so I can't conjure an example, but it should work fine as well.

It's time to use it!

```js
acho.info('hello world');
// => 'hello world'
```

All public methods are chainable:

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

### Defining the level

Establishing the loglevel is a good way to filter out undesired information from output. The available levels by default are:

- `error`:   Display calls to `.error()` messages.
- `warn`: Display calls from `.error()`, `.warn()` messages.
- `success`: Display calls from `.error()`, `.warn()`, `success()` messages.
- `info`:    Display calls from `.error()`, `.warn()`, `success()`, `info()` messages.
- `verbose`: Display calls from `.error()`, `.warn()`, `success()`, `info()`, `verbose()` messages.
- `debug`:   Display calls from `.error()`, `.warn()`, `success()`, `info()`, `verbose()`, `debug()` messages.
- `silly`:   Display calls from `.error()`, `.warn()`, `success()`, `info()`, `verbose()`, `debug()`, `silly()` messages.

Additionally exists two special levels:

- `silent`:  Avoid all output.
- `all`: Allow print all message types.

The default log level is `all`. You can define it in the constructor:

```js
var acho = Acho({level: 'silly'})
```

or at runtime:

```js
acho.level = 'debug';
```

### Customization

You can completely customize the library to your requirements: changes colors, add more types, sort the priorities... the internal structure of the object is public and you can edit it dynamically. **You have the power**.

By default the messages structure is brief: Just the message type followed by the message itself.

But you can easily modify the output. For example, let's add a timestamp to each message:

```js
acho = Acho({
  color: true,
  level: 'silly',

  // Customize how to print the 'type' of each message
  outputType: function(type) {
    return '[' + type + '] »';
  },

  // Customize how to print the message.
  // Add things before and/or after.
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

In addition, you can use a custom keyword to use as logging level instead of print the logging level. Just provide `keyword` parameter in the constructor. Providing it in the above example as `{ keyword: 'acho' }` the result is:

```js
acho.info('I am hungry');
// => '[ acho ] » Fri Mar 13 2015 18:12:48 GMT+0100 (CET) :: I am hungry'
```

If you need customize more the output you can setup `.print` `.generateMessage` (see below) that are a more low level methods for generate and print the output message.

## API

### Acho({Object} [options])

Create a logger. Available options:

#### keyword **{String}**

Instead of print the type log level, print the keyword. By default this behavior is not activated.

#### color **{Boolean}**

Enable or disable colorized output. `false` by default.

#### level **{String}**

Provides the logging level. `all` by default.

#### types **{Object}**

You can provide the types and priorities.

#### print **{Function}**

Provides a function that determines how to print the messages. By default uses `.generateMessage` for generate the mesage that will be outputted.

#### transport **{Function}**

Defines what happens with the log message. By default is `console.log`.

#### outputType **{Function}**

Provides a function to customize the type in the output.

#### outputMessage **{Function}**

Provides a function to customize the message in the output.

#### generateMessage **{Function}**

Provides a function that generate the message to be outputted. It combines other internal methods for generate the output (as `.isPrintable` or `.colorize`) and normally you are not interested in the definition of it, but you can provide it as option as well.

#### generateTypeMessage **{Function}**

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
