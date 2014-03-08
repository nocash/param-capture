class Params
  class ParamAccessor
    PARAM_DIR = 'params'

    def self.file_access_mode(mode)
      @filemode = mode
    end

    private

    attr_reader :filemode, :filename

    def file
      @file ||= File.open(filepath, filemode)
    end

    def filepath
      File.join(PARAM_DIR, filename)
    end
  end
end
