{ThreadPool} = require '../'
should = require 'should'
require 'mocha'

describe 'ThreadPool', ->
  describe 'constructor()', ->
    it 'should create properly', (done) ->
      pool = new ThreadPool
      should.exist pool.count
      should.exist pool.threads
      pool.count.should.equal require('os').cpus().length
      pool.count.should.equal pool.threads.length
      done()

  describe 'run()', ->
    it 'should work with a simple task', (done) ->
      task = (name, male, cb) ->
        cb "#{name} is#{if male then '' else ' not'} a male"

      pool = new ThreadPool
      pool.run task, "John", true, (res) ->
        should.exist res
        res.should.equal "John is a male"
        done()
    ###
    it 'should work with a complex task', (done) ->
      task = (url, cb) ->
        require('http').get {host: url}, cb
      pool = new ThreadPool
      pool.run task, "www.google.com", (res) ->
        should.exist res
        ('<html' in res).should.equal true
        done()
    ###
    it 'should work with multiple simple tasks', (done) ->
      c = 0
      comp = -> done() if ++c is 10

      task = (name, male, cb) ->
        cb "#{name} is#{if male then '' else ' not'} a male"
      pool = new ThreadPool

      for i in [0...10]
        pool.run task, "John", true, (res) ->
          should.exist res
          res.should.equal "John is a male"
          comp()

        pool.run task, "Mary", false, (res) ->
          should.exist res
          res.should.equal "Mary is not a male"
          comp()