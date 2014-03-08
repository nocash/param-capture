require 'yaml'

class Params
  class ParamWriter
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

    def write
      file << params.to_yaml
      file.close
      self
    end

    def permalink
      '/' + filename
    end

    def filepath
      File.join(PARAM_PATH, filename)
    end

    private

    attr_reader :filename

    def file
      @file ||= File.open(filepath, 'w')
    end

    def create_filename
      Time.now.strftime('%Y%m%d%H%M%S')
    end
  end
end
