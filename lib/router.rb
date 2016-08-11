require 'byebug'

class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern #Regexp object (i.e. users/:id => Regex.new("^/users/(?<user_id>"))
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  def matches?(req)
    pattern.match(req.path) && req.request_method == http_method.to_s.upcase
  end

  def run(req, res)
    route_params = {}
    params = pattern.match(req.path)
    params.names.each do |name|
      route_params[name] = params[name]
    end

    controller = controller_class.new(req,res,route_params)
    controller.invoke_action(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  def draw(&proc)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  # should return the route that matches this request
  def match(req)
    @routes.select{|route| route.matches?(req)}.first
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    matched_route = match(req)

    if matched_route
      matched_route.run(req, res)
    else
      res.status = 404
    end
  end
end
