# Required modules
gulp = require 'gulp'
gutil = require 'gulp-util'
del = require 'del'
coffee = require 'gulp-coffee'
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
webpackConfig = require './webpack.config.coffee'

# Watch paths
paths = {
  assets: [
    './src/**/*.{html,png}'
  ],
  styles: [
    './src/styles/**/*.css'
  ],
  scripts: [
    './src/scripts/**/*.{jsx,cjsx,coffee,js}'
  ],
  webpackScripts: [
    './src/scripts/**/*.{jsx,cjsx,coffee}'
  ],
  vanillaScripts: [
    './src/scripts/**/*.js'
  ]
}

# Default: Runs an INITIAL COPY TASK then initializes our WATCHER
gulp.task 'default', ['build', 'watch'], ->

# Task to build the dist folder on initial load
gulp.task 'build', ['assets:copy', 'styles:copy', 'webpack:build', 'js:copy'], ->

# The watcher task which polls for changes to our scripts files
gulp.task 'watch', ->
  gulp.watch paths.webpackScripts, ['webpack:build']
  gulp.watch paths.vanillaScripts, ['js:copy']


# Task to clean the dist directory
gulp.task 'clean', (callback) ->
  del [
    'dist/**'
  ], callback

# Task to copy vanilla JS files
gulp.task 'assets:copy', ->
  gulp.src(paths.assets)
    .pipe gulp.dest('./dist')

# Task to copy vanilla JS files
gulp.task 'styles:copy', ->
  gulp.src(paths.styles)
    .pipe gulp.dest('./dist/styles')

# Task to copy vanilla JS files
gulp.task 'js:copy', ->
  gulp.src(paths.vanillaScripts)
    .pipe gulp.dest('./dist/scripts')

# gulp.task 'coffee:compile', () ->
#   gulp.src(paths.coffeeScripts)
#     .pipe(coffee(bare:true).on('error', gutil.log))
#     .pipe gulp.dest('./dist/scripts')

gulp.task 'webpack:build', (callback) ->
  # modify some webpack config options
  conf = Object.create(webpackConfig)
  conf.plugins = conf.plugins.concat new webpack.DefinePlugin
    'process.env':
      NODE_ENV: JSON.stringify('production')
  , new webpack.optimize.DedupePlugin(), new webpack.optimize.UglifyJsPlugin()

  # run webpack
  webpack conf, (err, stats) ->
    throw new gutil.PluginError('webpack:build', err) if err
    gutil.log '[webpack:build]', stats.toString colors: true
    callback()

# TODO: invenstigate whether we can get hot module replacement talking to the the chrome livereload script
# gulp.task 'webpack:dev-server', (callback) ->
#   # modify some webpack config options
#   conf = Object.create webpackConfig
#   conf.devtool = 'source-map'
#   conf.debug = true

#   # Start a webpack-dev-server
#   new WebpackDevServer webpack(conf),
#     contentBase: conf.contentBase
#     stats:
#       colors: true
#   .listen 3030, 'localhost', (err) ->
#     throw new gutil.PluginError('webpack-dev-server', err) if err
#     gutil.log '[webpack-dev-server]', 'http://localhost:3030/webpack-dev-server/index.html'
