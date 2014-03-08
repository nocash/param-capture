require 'yaml'

class ParamPersister
  class ParamWriter
    attr_reader :params

    def self.write(params)
      new(params).write
    end

    def initialize(params)
      @params = params
    end

    def write
      file << params.to_yaml
      file.close
      self
    end

    def permalink
      '/' + File.basename(filepath)
    end

    def filepath
      "params/#{timestamp}"
    end

    private

    def file
      @file ||= File.open(filepath, 'w')
    end

    def timestamp
      @timestamp ||= Time.now.strftime('%Y%m%d%H%M%S')
    end
  end
end
