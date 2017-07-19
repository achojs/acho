<a name="3.3.1"></a>
## 3.3.1 (2017-07-19)

* Update package.json ([7280535](https://github.com/achohq/acho/commit/7280535))
* fix(package): update pretty-ms to version 3.0.0 ([0653040](https://github.com/achohq/acho/commit/0653040))



<a name="3.3.0"></a>
# 3.3.0 (2017-05-22)

* Add fmt-objet configuration from Acho settings ([aa2e7a5](https://github.com/achohq/acho/commit/aa2e7a5))
* Avoid eval twice times for the same ([b4a0c61](https://github.com/achohq/acho/commit/b4a0c61))
* Avoid unnecessary check ([9585396](https://github.com/achohq/acho/commit/9585396))
* Better naming ([a2c1a2e](https://github.com/achohq/acho/commit/a2c1a2e))
* Fix bumped config ([da83300](https://github.com/achohq/acho/commit/da83300))
* Fix linter ([5857501](https://github.com/achohq/acho/commit/5857501))
* Remove browser build ([f69bb73](https://github.com/achohq/acho/commit/f69bb73))
* Update copy ([63b6c12](https://github.com/achohq/acho/commit/63b6c12))
* Update fmt-objt interface ([71ab2f3](https://github.com/achohq/acho/commit/71ab2f3))
* Update travis builds ([990e1b3](https://github.com/achohq/acho/commit/990e1b3))
* fix(package): update fmt-obj to version 2.0.0 ([22d0546](https://github.com/achohq/acho/commit/22d0546))



<a name="3.2.1"></a>
## 3.2.1 (2017-04-17)

* Fix function params ([645037c](https://github.com/achohq/acho/commit/645037c))



<a name="3.2.0"></a>
# 3.2.0 (2017-04-14)

* Add %J formatter ([4192659](https://github.com/achohq/acho/commit/4192659))
* Refactor formatter ([99585a6](https://github.com/achohq/acho/commit/99585a6))
* Update deps ([e5283d7](https://github.com/achohq/acho/commit/e5283d7))
* Update README.md ([b325807](https://github.com/achohq/acho/commit/b325807))
* Update travis builds ([77a2452](https://github.com/achohq/acho/commit/77a2452))
* chore(package): update dependencies ([76eb538](https://github.com/achohq/acho/commit/76eb538))



<a name="3.1.2"></a>
## 3.1.2 (2017-03-03)

* Remove unnecessary dependency ([2e22e0f](https://github.com/achohq/acho/commit/2e22e0f))
* fix(package): update coffee-script to version 1.12.0 ([79ce119](https://github.com/achohq/acho/commit/79ce119))



<a name="3.1.1"></a>
## 3.1.1 (2016-10-04)

* Change ms dep in favour of pretty-ms ([1ede313](https://github.com/achohq/acho/commit/1ede313))
* Removed typo ([d747872](https://github.com/achohq/acho/commit/d747872))
* Update ([0ca4660](https://github.com/achohq/acho/commit/0ca4660))



<a name="3.1.0"></a>
# 3.1.0 (2016-09-29)

### Minor

* Expose defaults under `Acho.defaults`.
* Configurable `timestamp` passing a `Number` (Previously it was a `Boolean`).
* Drop 0.12 and 0.10 support. Remove polyfill dependency.
* Remove `strip-ansi`.
* Little `Date` optimization.

### Commits

* Add coverage ([1aa6461](https://github.com/achohq/acho/commit/1aa6461))
* Add files section ([8bd39a6](https://github.com/achohq/acho/commit/8bd39a6))
* Configurable timestamp timing ([4fc59d3](https://github.com/achohq/acho/commit/4fc59d3))
* Drop node < 4 support ([42f80ef](https://github.com/achohq/acho/commit/42f80ef))
* Drop repeat-string dep ([dfe30f2](https://github.com/achohq/acho/commit/dfe30f2))
* Expose Acho.defaults ([daf6938](https://github.com/achohq/acho/commit/daf6938))
* Move strip ansi from message out of the logger ([b179882](https://github.com/achohq/acho/commit/b179882))
* new Date() → Date.now() ([254a6f3](https://github.com/achohq/acho/commit/254a6f3))
* Remove stripAnsi reference ([0799f10](https://github.com/achohq/acho/commit/0799f10))
* Remove unused var ([a619744](https://github.com/achohq/acho/commit/a619744))
* chore(package): update dependencies ([c9459ce](https://github.com/achohq/acho/commit/c9459ce))



<a name="3.0.2"></a>
## 3.0.2 (2016-05-26)

* Better smart colorize ([a7b2c78](https://github.com/achohq/acho/commit/a7b2c78))



<a name="3.0.1"></a>
## 3.0.1 (2016-05-26)

* Avoid production special cases ([62db27a](https://github.com/achohq/acho/commit/62db27a))
* strip ansi under production ([837ff8d](https://github.com/achohq/acho/commit/837ff8d))
* Update ([2f5de4f](https://github.com/achohq/acho/commit/2f5de4f))



<a name="3.0.0"></a>
# 3.0.0 (2016-05-01)

## Breaking Changes

- Simplifiest default logging levels to `.fatal()`, `.error()`, `.warn()`, `info()`, `debug()`.
- Mute levels use `muted` keyword instead of `silent`.

## New Features

- Add `upperCase` flag to prints loglevels in uppercase.
- Add `timestamp` flag to prints counter associated with each log.
- Add `.skin` to make easy load different log levels. Check [acho-skin-cli](https://github.com/achohq/acho-skin-cli).

## Fixes, refactoring and optimizations

- Use [lodash#defaults](https://lodash.com/docs#defaults) instead of [existential-defaults](https://github.com/Kikobeats/existential-default) (more lightweight).
- Indent log levels from the left instead of from the right (so cute!).
- Logfmt now works with Error's message.

## Commits

* Add .skin method ([ac1a16d](https://github.com/achohq/acho/commit/ac1a16d))
* Add docs ([822b697](https://github.com/achohq/acho/commit/822b697))
* Add experimental RFC5424 levels ([37661c4](https://github.com/achohq/acho/commit/37661c4))
* Add repeat polyfill ([b2a3337](https://github.com/achohq/acho/commit/b2a3337))
* Add testing dependency ([1a14ea6](https://github.com/achohq/acho/commit/1a14ea6))
* Add timestamp ([8dc0d20](https://github.com/achohq/acho/commit/8dc0d20))
* Add uppercase param ([41fd01c](https://github.com/achohq/acho/commit/41fd01c))
* Correctly indent context ([1fe6f9b](https://github.com/achohq/acho/commit/1fe6f9b))
* Disable timestamp by default ([efbc12f](https://github.com/achohq/acho/commit/efbc12f))
* Expand example ([5cef0cd](https://github.com/achohq/acho/commit/5cef0cd))
* Fix links references ([e08da90](https://github.com/achohq/acho/commit/e08da90))
* Fix output boolean values ([e320e95](https://github.com/achohq/acho/commit/e320e95))
* Fix tests ([8a36b70](https://github.com/achohq/acho/commit/8a36b70))
* Fix typo ([25dcbc7](https://github.com/achohq/acho/commit/25dcbc7))
* Fix typo ([81631e9](https://github.com/achohq/acho/commit/81631e9))
* Improve color style ([786810e](https://github.com/achohq/acho/commit/786810e))
* Little refactor ([2664f02](https://github.com/achohq/acho/commit/2664f02))
* Move CLI types out of the project ([d02b6a2](https://github.com/achohq/acho/commit/d02b6a2))
* move repository references ([f481011](https://github.com/achohq/acho/commit/f481011))
* output correctly align and context ([ed1e454](https://github.com/achohq/acho/commit/ed1e454))
* Refactor tests ([91cbdc9](https://github.com/achohq/acho/commit/91cbdc9))
* Reorganize examples ([305f8e5](https://github.com/achohq/acho/commit/305f8e5))
* Separate align from separator ([671b472](https://github.com/achohq/acho/commit/671b472))
* Separate cli mode from logging levels ([585423a](https://github.com/achohq/acho/commit/585423a))
* silent → muted ([c317250](https://github.com/achohq/acho/commit/c317250))
* Support Error serialization ([0064885](https://github.com/achohq/acho/commit/0064885))
* Update docs ([2e29c7f](https://github.com/achohq/acho/commit/2e29c7f))
* Update example ([209a142](https://github.com/achohq/acho/commit/209a142))
* Update examples ([da0bba5](https://github.com/achohq/acho/commit/da0bba5))
* WIP ([0146df6](https://github.com/achohq/acho/commit/0146df6))
* chore(package): update existential-default to version 1.2.1 ([fc88993](https://github.com/achohq/acho/commit/fc88993))



<a name="2.8.0"></a>
# 2.8.0 (2016-04-22)

* Add keys color based on the level ([d120614](https://github.com/kikobeats/acho/commit/d120614))
* Add testing file ([2934428](https://github.com/kikobeats/acho/commit/2934428))



<a name="2.7.2"></a>
## 2.7.2 (2016-04-20)

* Add a more intelligent align ([644cddd](https://github.com/kikobeats/acho/commit/644cddd))
* Improve serialization ([c583358](https://github.com/kikobeats/acho/commit/c583358))



<a name="2.7.1"></a>
## 2.7.1 (2016-04-18)

* Add instanceof for new keyword ([e02a43e](https://github.com/kikobeats/acho/commit/e02a43e))
* Add messages flag documentation ([c735734](https://github.com/kikobeats/acho/commit/c735734))
* Refactor tests, more useful ([d85467f](https://github.com/kikobeats/acho/commit/d85467f))
* update bumped settings ([189711a](https://github.com/kikobeats/acho/commit/189711a))



<a name="2.7.0"></a>
# 2.7.0 (2016-04-18)

* Add possibility to setup custom align ([c52064f](https://github.com/kikobeats/acho/commit/c52064f))
* Better docs ([e17548a](https://github.com/kikobeats/acho/commit/e17548a))
* Typo ([64c6bc9](https://github.com/kikobeats/acho/commit/64c6bc9))



<a name="2.6.2"></a>
## 2.6.2 (2016-04-16)

* Fix mute levels ([3c3c307](https://github.com/kikobeats/acho/commit/3c3c307))



<a name="2.6.1"></a>
## 2.6.1 (2016-04-16)

* Fix setup a custom keyword ([30dcf5d](https://github.com/kikobeats/acho/commit/30dcf5d))



<a name="2.6.0"></a>
# 2.6.0 (2016-04-16)

* Add object serialization ([428859e](https://github.com/kikobeats/acho/commit/428859e))
* Fix typo ([bb5a29f](https://github.com/kikobeats/acho/commit/bb5a29f))
* Update docs ([ce0064e](https://github.com/kikobeats/acho/commit/ce0064e))
* Update docs ([a038f4f](https://github.com/kikobeats/acho/commit/a038f4f))



<a name="2.5.3"></a>
## 2.5.3 (2016-02-02)


* Release 2.5.2 ([c9315ab](https://github.com/kikobeats/acho/commit/c9315ab))
* Update dependencies ([e4e3206](https://github.com/kikobeats/acho/commit/e4e3206))
* update settings ([5414575](https://github.com/kikobeats/acho/commit/5414575))
* use existential-default instead of assign ([78697cd](https://github.com/kikobeats/acho/commit/78697cd))



<a name="2.5.1"></a>
## 2.5.1 (2016-01-26)


* Delete unnecessary dependency ([831c4e2](https://github.com/kikobeats/acho/commit/831c4e2))
* Release 2.5.1 ([1249c33](https://github.com/kikobeats/acho/commit/1249c33))



<a name="2.5.0"></a>
# 2.5.0 (2016-01-25)


* Add documentation ([c4795a5](https://github.com/kikobeats/acho/commit/c4795a5))
* Add symbol special keyword ([c287277](https://github.com/kikobeats/acho/commit/c287277))
* Release 2.5.0 ([001ab8e](https://github.com/kikobeats/acho/commit/001ab8e))
* Separate align from diff ([134fa13](https://github.com/kikobeats/acho/commit/134fa13))
* update scripts ([cd64037](https://github.com/kikobeats/acho/commit/cd64037))



<a name="2.4.2"></a>
## 2.4.2 (2016-01-23)


* 2.4.2 releases ([8b27e1a](https://github.com/kikobeats/acho/commit/8b27e1a))
* Delete extra space ([d8eeb8f](https://github.com/kikobeats/acho/commit/d8eeb8f))
* Delete line break ([0edd794](https://github.com/kikobeats/acho/commit/0edd794))
* Fix tests script ([cd34ec8](https://github.com/kikobeats/acho/commit/cd34ec8))
* Move prepublish into bumped step ([eefa46a](https://github.com/kikobeats/acho/commit/eefa46a))
* Update bumped config ([16128e6](https://github.com/kikobeats/acho/commit/16128e6))
* update scripts ([d74876f](https://github.com/kikobeats/acho/commit/d74876f))
* Update scripts, more simple ([d5f4209](https://github.com/kikobeats/acho/commit/d5f4209))



<a name="2.4.1"></a>
## 2.4.1 (2015-12-05)


* 2.4.1 releases ([58c3b3d](https://github.com/kikobeats/acho/commit/58c3b3d))
* added existential-assign dep ([f8b35d4](https://github.com/kikobeats/acho/commit/f8b35d4))
* better gif, round 2. ([675710e](https://github.com/kikobeats/acho/commit/675710e))
* bye fat arrow ([431b1d1](https://github.com/kikobeats/acho/commit/431b1d1))
* composition over inheritance ([963907e](https://github.com/kikobeats/acho/commit/963907e))
* little refactor ([3906739](https://github.com/kikobeats/acho/commit/3906739))
* little refactor ([28f225c](https://github.com/kikobeats/acho/commit/28f225c))
* Moved configurable stuff into Default ([f7c3b26](https://github.com/kikobeats/acho/commit/f7c3b26))
* moved getEnvironment inot CONST.ENV ([403cf73](https://github.com/kikobeats/acho/commit/403cf73))
* no moar new keyword ([8417785](https://github.com/kikobeats/acho/commit/8417785))
* refactor test, more expressive ([cb0f665](https://github.com/kikobeats/acho/commit/cb0f665))
* refactored, less is more ([a2edabd](https://github.com/kikobeats/acho/commit/a2edabd))
* removed new keyword, not necessary any more ([85bc524](https://github.com/kikobeats/acho/commit/85bc524))
* removed unnecessary new keyword ([9905b4a](https://github.com/kikobeats/acho/commit/9905b4a))
* Update .travis.yml ([284724c](https://github.com/kikobeats/acho/commit/284724c))
* Update README.md ([01aea77](https://github.com/kikobeats/acho/commit/01aea77))
* Update README.md ([86cf60e](https://github.com/kikobeats/acho/commit/86cf60e))
* updated ([b603a19](https://github.com/kikobeats/acho/commit/b603a19))
* updated bumped settings ([1010569](https://github.com/kikobeats/acho/commit/1010569))



<a name="2.4.0"></a>
# 2.4.0 (2015-11-17)


* 2.4.0 releases ([fd6fb87](https://github.com/kikobeats/acho/commit/fd6fb87))
* added string interpolation support ([f3c7623](https://github.com/kikobeats/acho/commit/f3c7623))
* better gif 💅 ([adae687](https://github.com/kikobeats/acho/commit/adae687))
* fixed disabled colors param ([ab7fd74](https://github.com/kikobeats/acho/commit/ab7fd74))
* fixed extra space with diff param ([f358e5b](https://github.com/kikobeats/acho/commit/f358e5b))
* updated library preview 💪 ([e207335](https://github.com/kikobeats/acho/commit/e207335))



<a name="2.3.0"></a>
# 2.3.0 (2015-10-16)


* 2.3.0 releases ([1453d16](https://github.com/kikobeats/acho/commit/1453d16))
* added experimental .align & .timestamp params ([0a4214f](https://github.com/kikobeats/acho/commit/0a4214f))
* possibility to decide where put diff in the output ([bb03a48](https://github.com/kikobeats/acho/commit/bb03a48))



<a name="2.2.1"></a>
## 2.2.1 (2015-10-14)


* 2.2.1 releases ([425b6d9](https://github.com/kikobeats/acho/commit/425b6d9))
* code more simply ([9e2d748](https://github.com/kikobeats/acho/commit/9e2d748))
* fixed keyword style ([9f18a6c](https://github.com/kikobeats/acho/commit/9f18a6c))



<a name="2.2.0"></a>
# 2.2.0 (2015-10-14)


* 2.2.0 releases ([27cb3b0](https://github.com/kikobeats/acho/commit/27cb3b0))
* added keyword parameter in constructor ([967023d](https://github.com/kikobeats/acho/commit/967023d))
* complemented documentation ([abc2153](https://github.com/kikobeats/acho/commit/abc2153))
* Update package.json ([8b4b0a4](https://github.com/kikobeats/acho/commit/8b4b0a4))
* Update README.md ([c077a60](https://github.com/kikobeats/acho/commit/c077a60))
* Update README.md ([44bc90f](https://github.com/kikobeats/acho/commit/44bc90f))



<a name="2.1.0"></a>
# 2.1.0 (2015-08-17)


* 2.1.0 releases ([ddcc6c3](https://github.com/kikobeats/acho/commit/ddcc6c3))
* added generateTypeMessage as external parameter. ([a0f67f3](https://github.com/kikobeats/acho/commit/a0f67f3))
* Added transport option ([a1170e3](https://github.com/kikobeats/acho/commit/a1170e3))
* fixed production check ([af63da9](https://github.com/kikobeats/acho/commit/af63da9))
* Improve production comparation ([eee1281](https://github.com/kikobeats/acho/commit/eee1281))
* updated ([ca112ba](https://github.com/kikobeats/acho/commit/ca112ba))
* updated ([ad532e2](https://github.com/kikobeats/acho/commit/ad532e2))



<a name="2.0.0"></a>
# 2.0.0 (2015-07-31)


* 2.0.0 releases ([0daf159](https://github.com/kikobeats/acho/commit/0daf159))
* avoid avoid colorize messages in production under NodeJS ([f6d2d54](https://github.com/kikobeats/acho/commit/f6d2d54))
* colors by default ([103194b](https://github.com/kikobeats/acho/commit/103194b))
* documentation refactor ([bc43872](https://github.com/kikobeats/acho/commit/bc43872))
* expose generateMessage ([57c3b9f](https://github.com/kikobeats/acho/commit/57c3b9f))
* little refactor. ([4046677](https://github.com/kikobeats/acho/commit/4046677))
* Update README.md ([fd0acee](https://github.com/kikobeats/acho/commit/fd0acee))
* updated ([2bec971](https://github.com/kikobeats/acho/commit/2bec971))
* updated bumped settings ([3025456](https://github.com/kikobeats/acho/commit/3025456))



<a name="1.0.8"></a>
## 1.0.8 (2015-06-14)


* 1.0.8 releases ([6e56dac](https://github.com/kikobeats/acho/commit/6e56dac))
* use options.messages if is available ([19aff24](https://github.com/kikobeats/acho/commit/19aff24))



<a name="1.0.7"></a>
## 1.0.7 (2015-05-30)


* 1.0.7 releases ([2e5f011](https://github.com/kikobeats/acho/commit/2e5f011))
* improved log level function generation ([0ad83a5](https://github.com/kikobeats/acho/commit/0ad83a5))
* updated ([809217b](https://github.com/kikobeats/acho/commit/809217b))



<a name="1.0.6"></a>
## 1.0.6 (2015-05-10)


* 1.0.6 releases ([a1ac35a](https://github.com/kikobeats/acho/commit/a1ac35a))
* deleted unnecessary code ([72c10f4](https://github.com/kikobeats/acho/commit/72c10f4))
* updated ([3f36779](https://github.com/kikobeats/acho/commit/3f36779))



<a name="1.0.5"></a>
## 1.0.5 (2015-05-09)


* 1.0.4 releases ([e4bcef2](https://github.com/kikobeats/acho/commit/e4bcef2))
* 1.0.5 releases ([448ea4e](https://github.com/kikobeats/acho/commit/448ea4e))
* first commit ([99c44a4](https://github.com/kikobeats/acho/commit/99c44a4))
* Update README.md ([330b4d0](https://github.com/kikobeats/acho/commit/330b4d0))
* update warning message into warn ([5c1654d](https://github.com/kikobeats/acho/commit/5c1654d))



<a name="1.0.4"></a>
## 1.0.4 (2015-03-19)


* fixed extra space ([11d2c1e](https://github.com/kikobeats/acho/commit/11d2c1e))



<a name="1.0.3"></a>
## 1.0.3 (2015-03-19)


* 1.0.3 releases ([193f234](https://github.com/kikobeats/acho/commit/193f234))
* because mac is not a real os ([e636ce2](https://github.com/kikobeats/acho/commit/e636ce2))
* linus torvalds is crying for this ([f4eff0f](https://github.com/kikobeats/acho/commit/f4eff0f))
* Merge pull request #4 from clocklear/master ([4cfdb40](https://github.com/kikobeats/acho/commit/4cfdb40))
* Switched to titleize for propercase ([45a9bfd](https://github.com/kikobeats/acho/commit/45a9bfd))
* Update README.md ([1082a73](https://github.com/kikobeats/acho/commit/1082a73))
* Update README.md ([78407bb](https://github.com/kikobeats/acho/commit/78407bb))
* Update README.md ([88e415d](https://github.com/kikobeats/acho/commit/88e415d))
* Update README.md ([9b04cb2](https://github.com/kikobeats/acho/commit/9b04cb2))
* updated ([8c52aec](https://github.com/kikobeats/acho/commit/8c52aec))
* Updated README.md to include UMD blurb ([f05d703](https://github.com/kikobeats/acho/commit/f05d703))



<a name="1.0.2"></a>
## 1.0.2 (2015-03-17)


* 1.0.2 releases ([fa3b7d1](https://github.com/kikobeats/acho/commit/fa3b7d1))
* Fix example.html, export proper module name to global space ([f6ef959](https://github.com/kikobeats/acho/commit/f6ef959))
* refactor ([1786df2](https://github.com/kikobeats/acho/commit/1786df2))
* Removed makefile, added npm script for build ([c441376](https://github.com/kikobeats/acho/commit/c441376))
* Update README.md ([c61aeb7](https://github.com/kikobeats/acho/commit/c61aeb7))
* updated ([c217034](https://github.com/kikobeats/acho/commit/c217034))
* updated mocha reference to local dependency ([7fc622c](https://github.com/kikobeats/acho/commit/7fc622c))
* Usability changes.  Added a makefile for quick task execution.  Added component.json so that we can  ([9e73dd4](https://github.com/kikobeats/acho/commit/9e73dd4))



<a name="1.0.1"></a>
## 1.0.1 (2015-03-16)


* 1.0.1 releases ([7b1f9e8](https://github.com/kikobeats/acho/commit/7b1f9e8))
* added support for styles ([775e84a](https://github.com/kikobeats/acho/commit/775e84a))
* fixed ([5a37063](https://github.com/kikobeats/acho/commit/5a37063))
* fixed browserify build and little improvements ([c72b67d](https://github.com/kikobeats/acho/commit/c72b67d))
* Grammar and styling corrections ([d703e87](https://github.com/kikobeats/acho/commit/d703e87))
* Merge branch 'master' of github.com:Kikobeats/acho ([c9d3998](https://github.com/kikobeats/acho/commit/c9d3998))
* Merge pull request #3 from saelfaer/patch-1 ([76d4b66](https://github.com/kikobeats/acho/commit/76d4b66))
* Update README.md ([45f08d6](https://github.com/kikobeats/acho/commit/45f08d6))



<a name="1.0.0"></a>
# 1.0.0 (2015-03-14)


* completed ([8d01b7d](https://github.com/kikobeats/acho/commit/8d01b7d))
* completed ([5b73e9e](https://github.com/kikobeats/acho/commit/5b73e9e))
* first commit ([edac5ab](https://github.com/kikobeats/acho/commit/edac5ab))
* fixed url ([9b4d611](https://github.com/kikobeats/acho/commit/9b4d611))
* merged ([222e72d](https://github.com/kikobeats/acho/commit/222e72d))
* refactor and updated documentation ([6824d6a](https://github.com/kikobeats/acho/commit/6824d6a))
* Update README.md ([1194cfa](https://github.com/kikobeats/acho/commit/1194cfa))
* updated ([14b3639](https://github.com/kikobeats/acho/commit/14b3639))
* updated ([2a5d5f7](https://github.com/kikobeats/acho/commit/2a5d5f7))
* updated ([1c12565](https://github.com/kikobeats/acho/commit/1c12565))
* updated ([68b5472](https://github.com/kikobeats/acho/commit/68b5472))
