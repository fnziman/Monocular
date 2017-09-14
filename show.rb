require 'rack'
require_relative './lib/controller_base'
require_relative './lib/router'

class Show
  attr_reader :title, :personal_rating

  def self.all
    @shows ||= []
  end

  def initialize(params = {})
    @title = params["title"]
    @personal_rating = params["personal_rating"]
  end

  def errors
    @errors ||= []
  end

  def valid?
    errors << "Title can't be blank" unless title.present?
    errors << "Personal Rating can't be blank" unless personal_rating.present?
    errors.empty?
  end

  def save
    return false unless valid?
    Show.all << self
    true
  end

end

class ShowsController < ControllerBase
  def new
    @show = Show.new
    render :new
  end

  def create
    @show = Show.new(params["show"])

    if @show.save
      flash[:notice] = "New Show Added!"
      redirect_to "/shows"
    else
      flash.now[:errors] = @show.errors
      render :new
    end
  end

  def index
    @shows = Show.all
    render :index
  end
end

router = Router.new

router.draw do
  get Regexp.new("^/shows/new$"), ShowsController, :new
  post Regexp.new("^/shows$"), ShowsController, :create
  get Regexp.new("^/shows$"), ShowsController, :index
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(app: app, Port: 3000)
