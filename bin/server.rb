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
server.mount_proc('/') do |req, res|
  router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
