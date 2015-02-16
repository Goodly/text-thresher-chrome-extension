path = require 'path'
webpack = require 'webpack'
bowerComponentsPath = path.join(__dirname, '/src/vendor/bower_components')

module.exports =

  contentBase: "#{__dirname}/src/"

  cache: true

  entry:
    moduleBundle: './src/scripts/moduleBundle'

  output:
    path: path.join(__dirname, 'dist/scripts')
    publicPath: 'dist/scripts'
    filename: '[name].js'
    chunkFilename: '[chunkhash].js'

  resolve:
    extensions: ['', '.webpack.js', '.web.js', '.coffee', '.js', '.css', '.scss', '.sass', '.jsx', '.cjsx']
    modulesDirectories: ['./src/scripts', 'web_modules', bowerComponentsPath, 'node_modules', './src/styles']

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
      # {
      #   test: /\.scss$/
      #   loader: "style-loader!sass-loader?outputStyle=expanded&includePaths[]=./bower_components/bootstrap-sass/assets/stylesheets"
      # }
      # {
      #   test: /\.sass$/
      #   loader: "style-loader!sass-loader"
      # }
      {
        test: /\.css$/
        loader: 'style-loader!css-loader'
      }
      {
        test: /\.{scss|sass}$/
        # Passing indentedSyntax query param to node-sass
        loader: "?outputStyle=expanded&indentedSyntax=sass"
      }
      {
        test: /\.(png|woff|woff2|eot|ttf|svg)$/
        loader: 'url-loader?limit=100000'
      }
    ]
  noparse: [
    "#{bowerComponentsPath}"
    "node_modules"
  ]
  plugins: [
    new webpack.HotModuleReplacementPlugin()
    ->
      @plugin 'done', (stats) ->
        stats = stats.toJson()
        console.error JSON.stringify
          assetsByChunkName: stats.assetsByChunkName
  ]
