{Thread} = require '../'
should = require 'should'
require 'mocha'

describe 'Thread', ->
  describe 'constructor()', ->
    it 'should create properly', (done) ->
      task = -> console.log 'hi'
      t = new Thread task
      should.exist t.task
      t.task.should.eql task
      done()

  describe 'run()', ->
    it 'should work with a simple task', (done) ->
      t = new Thread (name, male, cb) ->
        cb "#{name} is#{if male then '' else ' not'} a male"

      t.run "John", true, (res) ->
        should.exist res
        res.should.equal "John is a male"
        done()
    ###
    it 'should work with a complex task', (done) ->
      t = new Thread (url, cb) ->
        require('http').get {host: url}, cb

      t.run "www.google.com", (res) ->
        should.exist res
        ('<html' in res).should.equal true
        done()
    ###
    it 'should work with multiple simple tasks', (done) ->
      c = 0
      comp = -> done() if ++c is 2

      t = new Thread (name, male, cb) ->
        cb "#{name} is#{if male then '' else ' not'} a male"

      t.run "John", true, (res) ->
        should.exist res
        res.should.equal "John is a male"
        comp()

      t.run "Mary", false, (res) ->
        should.exist res
        res.should.equal "Mary is not a male"
        comp()