Autoprefixer        = require("autoprefixer")
PostcssModules      = require("postcss-modules")

module.exports={
  plugins: [
    Autoprefixer(),
    PostcssModules()
  ]
}
