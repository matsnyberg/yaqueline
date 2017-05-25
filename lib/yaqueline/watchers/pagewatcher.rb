require 'yaqueline/watcher'
require 'yaqueline/builder'
module Yaqueline
  module Watchers
    class PageWatcher < Watcher
      class << self
        
        def on_change modified, added, removed
          modified.each do |m|
            if matches? m
              puts "generating #{m}"
              document = DocumentParser.parse m
              Builder.render_page document
            end
          end
        end

        def matches? file
          puts "matches? #{file}"
          return false if file.nil?
          return false if file =~ /_posts/
          [:dest, :posts, :scss, :css, :layouts, :includes].each do |d|
            path = Configuration.absolute_path(d)
            return false if path && file.start_with?(path)
          end
          true
        end
        
      end # class << self
    end # class
  end # module
end # module
