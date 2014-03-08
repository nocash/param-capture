class Params
  class ParamFile
    def initialize(filepath)
      @filepath = filepath
    end

    def display_name
      time_created.strftime('%Y-%m-%d %H:%M:%S')
    end

    def to_url
      '/' + filename
    end

    private

    attr_reader :filepath

    def time_created
      Time.parse(filename)
    end

    def filename
      File.basename(filepath)
    end
  end
end
