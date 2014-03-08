require_relative 'param_accessor'
require 'yaml'

class Params
  class ParamWriter < ParamAccessor
    file_access_mode 'w'

    attr_reader :params

    def self.write(params)
      new(params).write
    end

    def initialize(params)
      @filename = create_filename
      @params = params
    end

    def to_h
      @params
    end

    def to_url
      '/' + filename
    end

    def write
      file << params.to_yaml
      file.close
      self
    end

    private

    def create_filename
      Time.now.strftime('%Y%m%d%H%M%S')
    end
  end
end
