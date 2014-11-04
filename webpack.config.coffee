# See webpack.config.js for more examples:
# https://github.com/webpack/webpack-with-common-libs/blob/master/webpack.config.js

path = require 'path'
webpack = require 'webpack'
bowerComponentsPath = path.join(__dirname, '/dist/scripts/vendor/bower_components')

# resolveBowerPath = (componentPath) ->
#   path.join __dirname, "bower_components", componentPath

# webpack-dev-server options used in gulpfile
# https://github.com/webpack/webpack-dev-server

module.exports =

  contentBase: "#{__dirname}/src/"

  cache: true

  entry:
    # background: './src/scripts/background'
    # contentscript: './src/scripts/contentscript'
    vendor: './src/scripts/vendor'
    bundle: ['./src/scripts/bundle']
    # bundle: ['./src/scripts/bundle', 'webpack/hot/dev-server', 'webpack-dev-server/client?http://localhost:3030']
  output:
    path: path.join(__dirname, 'dist/scripts')
    publicPath: 'dist/scripts'
    filename: '[name].js'
    chunkFilename: '[chunkhash].js'

  resolve:
    extensions: ['', '.webpack.js', '.web.js', '.coffee', '.js', '.scss', '.sass', '.jsx', '.coffee', '.cjsx']
    modulesDirectories: ['./src/scripts', 'web_modules', bowerComponentsPath, 'node_modules']

  module:
    loaders: [
      {
        test: /\.js(x?)$/
        loader: 'jsx-loader?harmony'
      }
      {
        test: /\.cjs(x?)$/
        loaders: [
          'coffee-loader',
          'cjsx-loader'
        ]
      }
      {
        test: /\.coffee$/
        loader: 'coffee-loader'
      }
      {
        test: /\.scss$/,
        loader: "style-loader!sass-loader?outputStyle=expanded&includePaths[]=./bower_components/bootstrap-sass-official/assets/stylesheets"
      }
      {
        test: /\.sass$/,
        loader: "style-loader!sass-loader?outputStyle=expanded&includePaths[]=./bower_components/foundation/scss/"
      }
      {
        # required to write 'require('./style.css')'
        test: /\.css$/
        loader: 'style-loader!css-loader'
      }
      {
        test: /\.jade$/
        loader: 'jade'
      }

    ]
  noparse: [
    "#{bowerComponentsPath}/jquery/"
    "#{bowerComponentsPath}/modernizr"
  ]
  plugins: [
    new webpack.HotModuleReplacementPlugin()
    ->
      @plugin 'done', (stats) ->
        stats = stats.toJson()
        console.error JSON.stringify
          assetsByChunkName: stats.assetsByChunkName
  ]



# module.exports = {
#     entry: ['webpack/hot/dev-server', './client'],
#     output: {
#         path: path.join(__dirname, 'output'),
#         filename: 'bundle.js'
#     },
#     resolveLoader: {
#         modulesDirectories: ['..', 'node_modules']
#     },
#     resolve: {
#         extensions: ['', '.js', '.cjsx', '.coffee']
#     },
#     module: {
#         loaders: [
#             { test: /\.cjsx$/, loaders: ['react-hot', 'coffee-loader', 'cjsx-loader']},
#             { test: /\.coffee$/, loader: 'coffee-loader' }
#         ]
#     }
# };
