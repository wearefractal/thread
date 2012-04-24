os = require 'os'
Thread = require './Thread'

runner = (task, args, cb) ->
  task.apply null, Array.prototype.slice.call(args).concat([cb]) # Can't use ... here

class ThreadPool
  threads: []
  next: 0

  constructor: (@count=os.cpus().length) ->
    throw 'count must be > 0' unless @count > 0
    @threads = (new Thread runner for i in [0...@count])

  run: (task, args..., cb) ->
    @threads[@next].run task, args, cb
    @next = if @next is @count-1 then 0 else ++@next

module.exports = ThreadPool