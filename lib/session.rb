class Session
  def initialize(req)
    if req.cookies['_monocular']
      @session = JSON.parse(req.cookies['_monocular'])
    else
      @session = {}
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  #change cookie name...
  def store_session(res)
    res.set_cookie('_monocular', {
      value: @session.to_json,
      path: '/'
      })
  end
end
