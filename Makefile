# get Makefile directory name: http://stackoverflow.com/a/5982798/376773
THIS_MAKEFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR:=$(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)

# BIN directory
BIN := $(THIS_DIR)/node_modules/.bin

# applications
NODE ?= $(shell which node)
NPM ?= $(NODE) $(shell which npm)
GULP ?= $(NODE) $(BIN)/gulp
MOCHA ?= $(NODE) $(BIN)/mocha

all: dist/acho.js

install: node_modules

clean:
	@rm -f dist/acho.js

wipe: clean
	@rm -rf node_modules

dist:
	@mkdir -p $@

dist/acho.js: node_modules dist
	@$(GULP) --require coffee-script

node_modules: package.json
	@$(NPM) install
	@touch node_modules

test:
	@$(MOCHA) \
	  -b \
	  --compilers coffee:coffee-script/register \
	  --require should \
	  --reporter spec \
	  --timeout 120000 \
	  --slow 300 \
	  test/test.coffee

.PHONY: all install clean wipe test
