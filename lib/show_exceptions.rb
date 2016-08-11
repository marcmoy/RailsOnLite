require 'erb'
require 'byebug'

class ShowExceptions

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue StandardError => e
      render_exception(e)
    end
  end

  private

  def render_exception(e)
    # filename = "lib/templates/rescue.html.erb"
    # content = ERB.new(File.read(filename)).result(binding)

    ['500', {'Content-type' => 'text/html'}, ['RuntimeError']]
  end

end
