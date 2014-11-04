# See example gulpfile.js for file system development build:
# https://github.com/webpack/webpack-with-common-libs/blob/master/gulpfile.js

gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
webpackConfig = require './webpack.config.coffee'

paths = {
  scripts: [
    './src/scripts/**/*.{jsx,coffee,cjsx}'
  ]
}
# Default task
gulp.task 'default', ['watch', 'webpack:build'], ->

gulp.task 'build', ['webpack:build'], ->

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['webpack:build']


# gulp.task 'scripts', () ->
#   gulp.src(paths.scripts)
#     .pipe(coffee(bare:true).on('error', gutil.log))
#     .pipe gulp.dest('./dist/scripts')

# TODO: Discover if you can pipe the dev-server into the chrome extension
#

gulp.task 'webpack-dev-server', (callback) ->
  # modify some webpack config options
  conf = Object.create webpackConfig
  conf.devtool = 'source-map'
  conf.debug = true

  # Start a webpack-dev-server
  new WebpackDevServer webpack(conf),
    contentBase: conf.contentBase
    stats:
      colors: true
  .listen 3030, 'localhost', (err) ->
    throw new gutil.PluginError('webpack-dev-server', err) if err
    gutil.log '[webpack-dev-server]', 'http://localhost:3030/webpack-dev-server/index.html'


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
