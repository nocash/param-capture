require 'sinatra'
require 'haml'

require_relative './lib/param_persister'

helpers do
  def save_params(params)
    saved_params = ParamWriter.write(params)
    haml :index,
      layout: :main,
      locals: { params: saved_params.params, permalink: saved_params.permalink }
  end
end

after do
  ParamPersister.cleanup!
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

get %r{^/(\d{14})} do |timestamp|
  filepath = "params/#{timestamp}"
  raise Sinatra::NotFound unless File.exist? filepath

  read_params = ParamReader.read(filepath)
  haml :index,
    layout: :main,
    locals: { params: read_params.params, permalink: read_params.permalink }
end
