require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    if req.cookies['_rails_lite_app_flash'] #change name.. also in session
      @now = JSON.parse(req.cookies['_rails_lite_app_flash'])
    else
      @now = {}
    end
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', value: @flash.to_json, path: '/')
  end

end
