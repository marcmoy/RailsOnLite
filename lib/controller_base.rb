require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params = {})
    @req, @res = req, res
    @params = req.params.merge(params)
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'redirect again' if already_built_response?
    @already_built_response = true
    res.header["location"] = url
    res.status = 302
    session.store_session(res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'render again' if already_built_response?
    @already_built_response = true
    @res.body = [content]
    @res['Content-Type'] = content_type
    session.store_session(res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.name.underscore
    template = template_name.to_s.underscore

    filename = "views/#{controller_name}/#{template}.html.erb"
    content = ERB.new(File.read(filename)).result(binding)

    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    render(name) unless @already_built_response
  end
end
