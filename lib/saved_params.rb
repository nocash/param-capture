class SavedParams
  class << self
    def cleanup!
      Dir['params/*'].each do |path|
        filename = path[/\d+$/]
        time = Time.parse(filename)
        File.unlink path if too_old(time)
      end
    end

    def too_old(time)
      old = Date.today - 2
      time < old.to_time
    end
  end
end
