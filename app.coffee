path = require('path')
express = require('express')
stylus = require 'stylus'
app = module.exports = express.createServer()

# ------------------------------------------------------------
#  Configuration
# ------------------------------------------------------------

app.configure ->
  app.set 'views', __dirname + '/app/views'
  app.set 'view engine', 'jade'
  app.use stylus.middleware src: __dirname + '/app' , compress: on
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + '/app')
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use(express.errorHandler())


# ------------------------------------------------------------
#  Routes
# ------------------------------------------------------------

app.get '/', (req, res) ->
  res.render 'application', layout: false

app.listen(process.env.PORT or 3000)
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)