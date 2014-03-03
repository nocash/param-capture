require 'sinatra'
require 'haml'
require 'yaml'

require_relative './lib/param_persisters'

get '/' do
  saved_params = ParamWriter.write(params)
  haml :index,
    layout: :main,
    locals: { params: saved_params.params, filepath: saved_params.filepath }
end

get '/params/:filename' do
  filename = params[:filename]
  raise Sinatra::NotFound unless File.exist? "params/#{filename}"

  read_params = ParamReader.read(filename)
  haml :index,
    layout: :main,
    locals: { params: read_params.params, filepath: read_params.filepath }
end

get '/browse' do
end
