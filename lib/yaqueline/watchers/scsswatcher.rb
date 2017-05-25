require 'yaqueline/watcher'
require 'yaqueline/builder'
module Yaqueline
  module Watchers
    class ScssWatcher < Watcher
      class << self
        
        def on_change modified, added, removed
          modified.each do |m|
            if matches? m
              Builder.build_stylesheets
            end
          end
        end

        def matches? file
          puts "matches? #{file}"
          return false if file.nil?
          return true if file =~ /\.scss$/
          false
        end
        
      end # class << self
    end # class
  end # module
end # module
