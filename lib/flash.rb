require 'json'

class Flash

  attr_reader :flash

  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    if cookie
      @now = JSON.parse(cookie)
    else
      @now = {}
    end
    @flash = {}
  end

  def [](key)
    @flash[key] || now[key]
  end

  def []=(key,val)
    @flash[key] = val
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', { path: "/", value: @flash.to_json } )
  end

  def now
    @now ||= {}
  end

end
