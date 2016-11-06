require 'webrick'
require_relative '../lib/router'

router = Router.new
router.draw do
  # A collection of routes gets 'drawn' here, for examples:
  # get Regexp("^/users$"), Controller, action
  # post Regexp("^/users$"), Controller, action
end

# ARGV[0] is $PORT (see ../Procfile)
PORT = ARGV[0] || 3000
server = WEBrick::HTTPServer.new(Port: PORT)


# See docs for WEBrick#mount_proc
# https://ruby-doc.org/stdlib-2.0.0/libdoc/webrick/rdoc/WEBrick/HTTPServer.html#method-i-mount_proc
server.mount_proc('/') do |req, res|
  router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
