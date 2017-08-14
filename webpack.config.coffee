webpack             = require "webpack"
path                = require "path"
_                   = require "underscore"
ExtractTextPlugin   = require "extract-text-webpack-plugin"
HtmlWebpackPlugin   = require "html-webpack-plugin"

module.exports=
  entry: index: ["./index.sass", "./index.coffee"]
  output:
    filename   : "[name].js"
    path       : path.resolve "bundled"
    publicPath : "/bundled/"
  module:
    rules: [
      COFFEE = test: /\.coffee$/, loader: "coffee-loader"
      PUG    = test: /\.pug$/, loader: "pug-loader"
      # CSS    = test: /\.(sa|sc|c)ss$/, use: ExtractTextPlugin.extract
      #   fallback: "style-loader"
      #   use: [
      #     CSS     = loader: "css-loader?sourceMap&modules"
      #     POSTCSS = loader: "postcss-loader"
      #     SASS    = loader: "sass-loader?indexSyntax"
      #   ]
      CSS    = test: /\.(sa|sc|c)ss$/,
        use: [
          STYLE   = loader: "style-loader"
          CSS     = loader: "css-loader?sourceMap&modules"
          POSTCSS = loader: "postcss-loader"
          SASS    = loader: "sass-loader?indexSyntax"
        ]
    ]
  plugins: _.flatten [
    # ExtractText=
    #   new ExtractTextPlugin
    #     filename: "[name].css"
    Html=
      new HtmlWebpackPlugin
        template: "index.pug"
        filename: "../dist/index.html"
        inject: off
  ]
  devtool: "source-map"
  devServer: contentBase: [
    path.resolve __dirname, "dist"
  ]
