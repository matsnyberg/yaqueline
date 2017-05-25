require 'yaqueline/watcher'
require 'yaqueline/builder'
module Yaqueline
  module Watchers
    class PostWatcher < Watcher
      class << self
        
        def on_change modified, added, removed
          modified.each do |m|
            if matches? m
              Builder.render_post m
            end
          end
        end

        def matches? file
          puts "matches? #{file}"
          return false if file.nil?
          return true if file =~ /_posts/
          false
        end
        
      end # class << self
    end # class
  end # module
end # module
