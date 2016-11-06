# Rails on Lite

A lightweight MVC web framework inspired by Ruby on Rails.

## Server

The `WEBrick` server was used to mount the application. The framework's server is initialized by the `Procfile`:
```
web: ruby bin/server $PORT
```
By default, the `lib/server.rb` will host the project locally on `localhost:3000` if a port is not specified.
```ruby
PORT = ARGV[0] || 3000
server = WEBrick::HTTPServer.new(Port: PORT)
```

## Router

When the server is booted up, the server will manage requests and responses via the `Router` object using [`WEBrick#mount_proc`](https://ruby-doc.org/stdlib-2.0.0/libdoc/webrick/rdoc/WEBrick/HTTPServer.html#method-i-mount_proc):

```ruby
router = Router.new
router.draw do
  # A collection of routes gets 'drawn' here, for examples:
  # get Regexp("^/users$"), Controller, action
  # post Regexp("^/users$"), Controller, action
end
...

server.mount_proc('/') do |req, res|
  router.run(req, res)
end
```

## Routes

In order to create routes, the `Router` class is equipped with a `#draw` method that will `#add_route` using metaprogramming methods, such as `#instance_eval` and `define_method`:

```ruby
def draw(&proc)
  instance_eval(&proc)
end

# make each of these methods that
# when called add route
[:get, :post, :put, :delete].each do |http_method|
  define_method(http_method) do |pattern, controller_class, action_name|
    add_route(pattern, http_method, controller_class, action_name)
  end
end
```

Adding a `Route` object via the `#add_route` method is done so by:
```ruby
def add_route(pattern, method, controller_class, action_name)
  @routes << Route.new(
    pattern,
    method,
    controller_class,
    action_name
  )
end
```

## Controllers

The router will direct the request to `Controller` objects that were inherited by the `ControllerBase` object template. From there, the controller base will write a response using a `View` template depending on the `action_name`.

Controllers come with `session` and `flash` hashes as well as `::protect_from_forgery` and `#form_authenticity_token` methods to mimic the Rails authenticity pattern.

## Views

The `erb` gem was required to render view templates, like so:
```ruby
# use ERB and binding to evaluate templates
# pass the rendered html to render_content
def render(template_name)
  dir_path = File.dirname(__FILE__)
  template_fname = File.join(
    dir_path, "..",
    "views", self.class.name.underscore, "#{template_name}.html.erb"
  )

  template_code = File.read(template_fname)

  render_content(
    ERB.new(template_code).result(binding),
    "text/html"
  )
end
```
