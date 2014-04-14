fs            = require 'fs'
express       = require 'express'
http          = require 'http'
passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy (username, password, done) ->
    if username is "alex" and password is "brain"
        return done null, {username, password}
    else
        return done null, false, message: "Incorrect username or password"

passport.serializeUser (user, done) ->
    done null, user.username

passport.deserializeUser (username, done) ->
    done null, {username, password:"brain"}

app = express()

app.configure ->
    app.use express.cookieParser()
    app.use express.bodyParser()
    app.use express.session secret: 'delicious brains'
    app.use express.urlencoded()
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router
    app.use express.static __dirname + "/static"
    app.use "/cms", express.static __dirname + "/_public"

app.get '/', (req, res) -> res.sendfile('static/index.html')

app.get '/login', (req, res) ->
    res.sendfile("static/login.html")

app.post '/login', passport.authenticate "local",
    successRedirect: '/cms'
    failureRedirect: '/login'

app.get '/cms', (req, res, next) ->
    if req.user
        next()
    else
        res.redirect("/login")

app.get '/api/all', (req, res) ->
    if fs.existsSync "data.json"
        res.set "Content-Type", "application/json"
        res.sendfile "data.json"
    else
        res.send error: "data not found"

app.post '/api/segment/:id', (req, res) ->
    unless req.user
        res.send(401, "Unauthorized")
        return

    data = JSON.parse(fs.readFileSync "data.json")
    id = req.params.id
    if data[id]?
        data[id].name = req.body.name
        data[id].description = req.body.description
        fs.writeFileSync "data.json", JSON.stringify(data)
        res.json(success: true)
    else
        res.json(success: false)

http.createServer(app).listen 3333, ->
  console.log 'Express server listening on port ' + 3333
