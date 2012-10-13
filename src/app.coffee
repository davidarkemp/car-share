express = require 'express'

app = express()

index = (req, res) ->
    res.send('Boom!')

app.get '/', index

app.listen(3000)
