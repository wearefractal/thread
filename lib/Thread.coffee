JASON = require 'JASON'
{fork} = require 'child_process'
{join} = require 'path'

worker = "#{__dirname}/worker.js"

class Thread
  constructor: (@task) ->

  run: (args..., cb) ->
    child = fork worker
    child.on 'message', (msg) ->
      {args} = JASON.parse(msg) or []
      cb args...
    child.send JASON.stringify {fn: @task, args: args}

module.exports = Thread