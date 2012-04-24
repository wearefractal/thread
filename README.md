![status](https://secure.travis-ci.org/wearefractal/thread.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>thread</td>
</tr>
<tr>
<td>Description</td>
<td>Threads for node</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Usage

## Thread
```coffee-script
{Thread} = require 'thread'

# Think of a new Thread like a task
# You give it a function to run - you can pass any args to this
# The last argument is always a callback for when the task is done
t = new Thread (name, cb) ->
  cb "Hey #{name}!"

# When you run a task it will open it in a new process
# You can pass any arguments to a task 
# The last param to .run is the callback for when the Thread says it is finished
t.run "Tony", (msg) ->
  console.log msg

# Calling .run multiple times will still run everything asynchronously
t.run "Mike", (msg) ->
  console.log msg
```

## ThreadPool

Thread is cool but it takes a while to start up (30ms per Thread - blame node!). ThreadPool will create these threads when your application starts and let them wait for commands. Give ThreadPool a function and some arguments and it will run on one of your Threads instantly.

```coffee-script
{ThreadPool} = require 'thread'

# 4 is the number of threads in the pool
# This defaults to the number of CPU cores you have
pool = new ThreadPool 4

task = (name, cb) -> 
  cb "Hey #{name}!"

pool.run task, "Tony", (msg) ->
  console.log msg

pool.run task, "Mike", (msg) ->
  console.log msg
```

## Examples

You can view more examples in the [example folder.](https://github.com/wearefractal/thread/tree/master/examples)

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
