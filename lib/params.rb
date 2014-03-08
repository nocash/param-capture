require_relative './param_file'
require_relative './param_reader'
require_relative './param_writer'

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
      files = Dir['params/*'].sort_by { |f| File.mtime(f) }.reverse
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

    def too_old(time)
      old = Date.today - MAX_AGE_DAYS
      time < old.to_time
    end
  end
end
