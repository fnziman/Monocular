require 'erb'

class ShowExceptions
  attr_reader :app
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue Exception => e
    render_exception(e)
  end

  private

  def render_exception(e)
    @error = e
    file = File.read("lib/templates/rescue.html.erb")
    content = ERB.new(file).result(binding)
    res = Rack::Response.new
    res['Content-Type'] = 'text/html'
    res.write(content)
    res.finish
  end
end
