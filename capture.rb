require 'sinatra'
require 'haml'

require_relative './lib/params'

helpers do
  def display_params(params)
    haml :show, locals: { params: params.to_h, permalink: params.permalink }
  end
end

after do
  Params.cleanup!
end

get '/' do
  saved_params = Params.save(params)
  display_params(saved_params)
end

post '/' do
  saved_params = Params.save(params)
  display_params(saved_params)
end

get '/browse' do
  all_params = Params.all
  haml :index, locals: { entries: all_params }
end

get %r{^/(\d{14})} do |filename|
  saved_params = Params.load(filename)
  raise Sinatra::NotFound unless saved_params.exist?
  display_params(saved_params)
end
