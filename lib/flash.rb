require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    #change name.. also in session
    cookie = req.cookies['_rails_lite_app_flash']
    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @now[key] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', value: @flash.to_json, path: '/')
  end

end
