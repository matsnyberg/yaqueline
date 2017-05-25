require 'yaqueline/watcher'
module Yaqueline
  module Watchers
    class LoggingWatcher < Watcher
      class << self
        
        def on_change(modified, added, removed)
          puts "modified absolute path: #{modified}"
          puts "added absolute path: #{added}"
          puts "removed absolute path: #{removed}"
        end
        
      end # class << self
    end # class
  end # module
end # module
