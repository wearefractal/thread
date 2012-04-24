/*
JASON = require 'JASON'

process.on "message", (msg) ->
  {fn, args} = JASON.parse msg
  cb = (args...) -> 
    process.send JASON.stringify {args: args}
    process.exit()
  fn args..., cb
*/

var JASON;
var __slice = Array.prototype.slice;
JASON = require('JASON');

process.on("message", function(msg) {
  var args, cb, fn, _ref;
  _ref = JASON.parse(msg), fn = _ref.fn, args = _ref.args;
  cb = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    process.send(JASON.stringify({
      args: args
    }));
    return process.exit();
  };
  return fn.apply(null, __slice.call(args).concat([cb]));
});