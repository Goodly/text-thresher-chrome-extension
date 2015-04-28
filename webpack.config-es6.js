'use strict';

import path from 'path';
import webpack from 'webpack';

const PROTOCOL = 'http';
const HOST = 'localhost';
const PORT = '3001';
const PUBLIC_PATH = `${PROTOCOL}://${HOST}:${PORT}/assets/`;

const WEBPACK_PORT = parseInt(process.env.PORT) + 1 || 3001;

export default {
  server: {
    port: WEBPACK_PORT,
    options: {
      publicPath: (process.env.C9_HOSTNAME) ? '/' : PUBLIC_PATH,
      hot: true,
      stats: {
        assets: true,
        colors: true,
        version: false,
        hash: false,
        timings: true,
        chunks: false,
        chunkModules: false
      }
    }
  },
  webpack: {
    devtool: 'eval-source-map',
    entry: {
      moduleBundle: './src/scripts/moduleBundle'
    },
    publicPath: PUBLIC_PATH,
    output: {
      path: path.join(__dirname, '../dist'),
      filename: '[name]-[chunkhash].js',
      chunkFilename: '[name]-[chunkhash].js',
      publicPath: PUBLIC_PATH
    },
    module: {
      preLoaders: [
        {
          test: /\.js$|.jsx$/,
          include: /src/,
          loaders: ['eslint', 'jscs']
        }
      ],
      loaders: [
        {
          test: /\.json$/,
          loader: 'json'
        },

        {
          test: /\.scss$/,
          loader: 'style!css!postcss-loader!sass'
        },
        {
          test: /\.jpg$/,
          loader: 'file'
        },
        {
          test: /\.(jpe?g|png|gif|svg|woff|eot|ttf)$/,
          loader: "url?limit=10000&name=[sha512:hash:base64:7].[ext]"
        },
        {
          test: /\.js?$/,
          exclude: /node_modules/,
          loaders: ['react-hot', 'babel']
        }
      ]
    },
    noparse: [
      'bower_components',
      'node_modules'
    ],
    resolve: {
      extensions: ['', '.js', '.scss', 'hbs', 'tmpl', 'svg', 'woff', 'eot', 'svg', 'png'],
      modulesDirectories: ['src', 'node_modules', 'web_modules', 'bower_components']
    }
  }
};
