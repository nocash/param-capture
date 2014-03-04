require 'sinatra'
require 'haml'

require_relative './lib/param_things'

after do
  SavedParams.cleanup!
end

get '/' do
  saved_params = ParamWriter.write(params)
  haml :index,
    layout: :main,
    locals: { params: saved_params.params, permalink: saved_params.permalink }
end

get '/browse' do
  files = Dir['params/*'].map { |path| ParamFile.new(path) }.reverse
  haml :browse,
    layout: :main,
    locals: { files: files }
end

get %r{^/(\d{14})} do |timestamp|
  filepath = "params/#{timestamp}"
  raise Sinatra::NotFound unless File.exist? filepath

  read_params = ParamReader.read(filepath)
  haml :index,
    layout: :main,
    locals: { params: read_params.params, permalink: read_params.permalink }
end
