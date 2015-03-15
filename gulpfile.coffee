'use strict'

# -- Dependencies --------------------------------------------------------------

gulp       = require 'gulp'
gutil      = require 'gulp-util'
browserify = require 'browserify'
header     = require 'gulp-header'
uglify     = require 'gulp-uglify'
pkg        = require './package.json'
source     = require 'vinyl-source-stream'

# -- Files ---------------------------------------------------------------------

path =
  filename : "#{pkg.name}.js"
  shorcut  : "#{pkg.name}"
  dist     : 'dist'

banner = [
           "/**"
           " * <%= pkg.name %> - <%= pkg.description %>"
           " * @version v<%= pkg.version %>"
           " * @link    <%= pkg.homepage %>"
           " * @author  <%= pkg.author.name %> (<%= pkg.author.url %>)"
           " * @license <%= pkg.license %>"
           " */"].join("\n")

# -- Tasks ---------------------------------------------------------------------

gulp.task 'browserify', ->
  browserify().require './index.js',
      expose: path.shorcut,
      transform: require 'coffeeify'
    .bundle()
    .pipe source(path.filename)
    .pipe gulp.dest path.dist
    .on('end', ->
      gulp.src "#{path.dist}/#{path.filename}"
      .pipe uglify()
      .pipe header banner, pkg: pkg
      .pipe gulp.dest path.dist
      return
    )

gulp.task 'default', ->
  gulp.start 'browserify'
  return
