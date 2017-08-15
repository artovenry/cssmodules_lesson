webpack             = require "webpack"
path                = require "path"
fs                  = require "fs"
_                   = require "underscore"
ExtractTextPlugin   = require "extract-text-webpack-plugin"
HtmlWebpackPlugin   = require "html-webpack-plugin"
Autoprefixer        = require "autoprefixer"
PostcssModules      = require "postcss-modules"

module.exports=
  entry: index: ["./index.sass", "./index.coffee"]
  output:
    filename   : "[name].js"
    path       : path.resolve "bundled"
    publicPath : "/bundled/"
  module:
    rules: _.values
      Coffee : test: /\.coffee$/, loader: "coffee-loader"
      Pug    : test: /\.pug$/, loader: "pug-loader"
      Css    : test: /\.(sa|sc|c)ss$/, use: ExtractTextPlugin.extract
        fallback: "style-loader", use: _.values
          Css     : loader: "css-loader?sourceMap&modules&localIdentName=[path][name]---[local]---[hash:base64:5]"
          Postcss : loader: "postcss-loader", options: plugins: _.values
            Autoprefixer   : Autoprefixer()
            PostcssModules : PostcssModules()
              # # getJSON: _.noop()
              # getJSON: (sass, json)->
              #   sass= path.basename(sass, ".sass")
              #   fs.writeFileSync path.resolve("bundled/#{sass}.json"), JSON.stringify(json)
          Sass    : loader: "sass-loader?indentedSyntax"
  plugins: _.flatten _.values
    ExtractText : new ExtractTextPlugin filename: "[name].css"
    Html        : _.values
      Index : new HtmlWebpackPlugin
        template: "index.pug"
        filename: "../dist/index.html"
        inject: off
  devtool: "source-map"
  devServer: contentBase: [
    path.resolve __dirname, "dist"
  ]
