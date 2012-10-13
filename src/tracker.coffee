uuid = require 'node-uuid'

class Tracker
    constructor: () ->
        @requests = { }
        @offers = {}

    addRequest: (request) ->
        id = uuid.v4()
        @requests[id] = request
        id

module.exports = Tracker
