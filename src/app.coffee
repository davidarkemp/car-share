express = require 'express'
cons = require 'consolidate'
tracker = require './tracker.coffee'

the_tracker = new tracker()

app = express()
app.use express.compress()
app.use express.json()
app.use express.multipart()
app.use express.urlencoded()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.cookieSession secret: 'lakjsdlkjasdlkjsad'
app.use express.csrf()

TEMPLATE_DIR = __dirname + '/templates/'

app.set 'view engine', 'html'
app.set 'views', TEMPLATE_DIR
app.engine 'html', cons.eco

index = (req, res) ->
    res.render 'index',
        content: "Boom!",
        csrf: req.session._csrf,

login = (req, res) ->
    console.log JSON.stringify req.body
    req.session.username = req.body.username

    res.redirect 'logged-in'

loggedIn = (req, res) ->
    username = req.session.username
    if not username
        response.redirect '/'
    now = new Date()
    minute = now.getMinutes()
    res.render 'logged-in',
        csrf: req.session._csrf
        username: username
        hour: now.getHours()
        minute: ( (minute - (minute % 5)) + 5) % 60

            
doRequest = (req, res) ->
    res.send the_tracker.addRequest req.body

app.get '/', index
app.post '/', login
app.get '/logged-in', loggedIn
app.post '/dorequest', doRequest

app.listen(3000)
