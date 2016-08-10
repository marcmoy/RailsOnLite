require 'rack'
require 'byebug'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  debugger
  res.write("/")
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

## what the environment hash looks like

req.env == {
"GATEWAY_INTERFACE"=>"CGI/1.1",
"PATH_INFO"=>"/",
"QUERY_STRING"=>"",
"REMOTE_ADDR"=>"::1",
"REMOTE_HOST"=>"::1",
"REQUEST_METHOD"=>"GET",
"REQUEST_URI"=>"http://localhost:3000/",
"SCRIPT_NAME"=>"",
"SERVER_NAME"=>"localhost",
"SERVER_PORT"=>"3000",
"SERVER_PROTOCOL"=>"HTTP/1.1",
"SERVER_SOFTWARE"=>"WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)",
"HTTP_HOST"=>"localhost:3000",
"HTTP_CONNECTION"=>"keep-alive",
"HTTP_CACHE_CONTROL"=>"max-age=0",
"HTTP_UPGRADE_INSECURE_REQUESTS"=>"1",
"HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36",
"HTTP_ACCEPT"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
"HTTP_ACCEPT_ENCODING"=>"gzip, deflate, sdch",
"HTTP_ACCEPT_LANGUAGE"=>"en-US,en;q=0.8",
"HTTP_COOKIE"=>"_TodoApp_session=N24zR3NYSWdnN0srOE5iUEhaZ1BNZ3ZMR2ZQcm5XZTJVbk5rVnQzMFpmSjhxZnlvMmxtNnJtWWU1WEhjdjd3eGFmbXJ6aks1YkpTUEY1ZEFNVHBocU5VNENsamVZeUtvVlBCSW9wQkx2Y2NrTCtYb0lRcHBJb2ZFQis1SG5xZ204SjhMZU9KU3lHRFJKTmxBc0xjQ3pxUlFsaEtIemNmdE4zWWdzekJiWEN4MlNFTlhFMG1yUVBUQVlDaEhBRk8wRWhyZ1hrc01INnBRTGwyNFlWOE14cG0waGdEM0JsZGZsaEU3a2FubzVMVnQ4cnd4OFY3Q1pjU094ZVZPSFpKcFFCS3R0aEJFc2I1c1dBNUhUTzhLUVdpZVhvNlhwZnJnaitiZERQM2tmbTh2UEIxYzZEcnBSTHRYT0RaVUtNWUNaWXpHNi9EZXZGcW5LVStqRzJhVVRWcnNpRGs5Ri9ZT05ydFVPOVlReCtxTFZDOWg4Z3FmQWhpY0s2TUp4VGNxLS1RMUtTN1hiNDViMmdtQmM0UUgxL3JBPT0%3D--eb5795d777f2b268c99964d8cc0427ad490c10ea; _rails_lite_app=%7B%22count%22%3A44%7D; _rails_lite_app_flash=%7B%7D",
"rack.version"=>[1, 3], "rack.input"=>#<StringIO:0x007fbfaa1f1ac8>,
"rack.errors"=>#<IO:<STDERR>>,
"rack.multithread"=>true,
"rack.multiprocess"=>false,
"rack.run_once"=>false,
"rack.url_scheme"=>"http",
"rack.hijack?"=>true,
"rack.hijack"=>#<Proc:0x007fbfaa1f1988@/Users/JAMSXD/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rack-2.0.1/lib/rack/handler/webrick.rb:74 (lambda)>,
"rack.hijack_io"=>nil,
"HTTP_VERSION"=>"HTTP/1.1",
"REQUEST_PATH"=>"/"
}
