require_relative './params/param_file'
require_relative './params/param_reader'
require_relative './params/param_writer'

class Params
  MAX_AGE_DAYS = 30
  PARAM_DIR = 'params'

  class << self
    def save(params)
      ParamWriter.write(params)
    end

    def load(filename)
      ParamReader.read(filename)
    end

    def all
      files.map { |f| ParamFile.new(f) }
    end

    def cleanup!
      Dir['params/*'].each do |path|
        filename = path[/\d+$/]
        time = Time.parse(filename)
        File.unlink path if too_old(time)
      end
    end

    private

    def files
      # Sort most recent entries first.
      Dir["#{PARAM_DIR}/*"].sort.reverse
    end

    def too_old(time)
      old = Date.today - MAX_AGE_DAYS
      time < old.to_time
    end
  end
end
