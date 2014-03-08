require 'sinatra'
require 'haml'

require_relative './lib/params'

helpers do
  def save_params(params)
    saved_params = Params.save(params)
    haml :index,
      layout: :main,
      locals: { params: saved_params.params, permalink: saved_params.permalink }
  end
end

after do
  Params.cleanup!
end

get '/' do
  save_params(params)
end

post '/' do
  save_params(params)
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
  haml :index,
    layout: :main,
    locals: { params: saved_params.params, permalink: saved_params.permalink }
end
