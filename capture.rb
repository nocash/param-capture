require 'sinatra'
require 'haml'

require_relative './lib/params'

helpers do
  def display_params(params)
    haml :index,
      layout: :main,
      locals: { params: params.params, permalink: params.permalink }
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
  files = Dir['params/*'].sort_by { |f| File.mtime(f) }.reverse
  files.map! { |f| ParamFile.new(f) }

  haml :browse,
    layout: :main,
    locals: { files: files }
end

get %r{^/(\d{14})} do |filename|
  # filepath = "params/#{timestamp}"
  # raise Sinatra::NotFound unless File.exist? filepath
  saved_params = Params.load(filename)
  display_params(saved_params)
end
