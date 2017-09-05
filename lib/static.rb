require 'byebug'
class Static
  attr_reader :app, :root
  def initialize(app)
    @app = app
    @root = :public
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    path = req.path

    if path.index("/#{root}")
      dir = File.dirname(__FILE__)
      file = File.join(dir, '..', path)
      if File.exists?(file)
        file = File.read(file)
        res["Content-Type"] = path.split('/').last.split('.').last
        res.write(file)
      else
        res.status = 404
        res.write("File not found")
      end
    else
      res = app.call(env)
    end
    res
  end
end
