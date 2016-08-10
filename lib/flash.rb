require 'json'

class Flash

  attr_reader :flash, :req

  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    if cookie
      @flash = JSON.parse(cookie)
    else
      @flash = {}
    end
    @now = {}
  end

  def [](key)
    flash[key] || now[key]
  end

  def []=(key,val)
    flash[key] = val
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', { path: "/", value: @flash.to_json } )
  end

  def now
    @now ||= {}
  end

end
