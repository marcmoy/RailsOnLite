require 'byebug'

class Static

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env

    if public_asset?
      serve_file
    else
      app.call(env)
    end
  end

  private

  def public_asset?
    @env["PATH_INFO"] =~ /^\/public\/*/
  end

  def serve_file
    res = Rack::Response.new

    root = File.dirname(__FILE__)
    file_ext = @env["PATH_INFO"]
    filename = "#{root}/..#{file_ext}"

    if File.exist?(filename)
      res.header["Content-Type"] = "text/plain"
      res.body << File.read(filename)
    else
      res.status = 404
    end

    res
  end

end
