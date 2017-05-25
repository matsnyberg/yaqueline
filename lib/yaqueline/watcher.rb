require 'listen'
module Yaqueline
  class Watcher
    class << self
      attr_accessor :watchers
      Watcher.watchers ||= []

      def inherited(subclass)
        Watcher.watchers << subclass
        puts "registered #{subclass}"
      end

      def start
        source = Configuration.get(:source)
        dest = Regexp.new(Configuration.get(:dest))
        Builder.build_all
        listener = Listen.to(source, only: files(source), ignore: dest) do |modified, added, removed|
          Watcher.watchers.each do |w|
            w.on_change(modified, added, removed)
          end
        end
        listener.start # not blocking
        begin
          sleep
        rescue => e
        end
      end

      def files dir
        filelist = Dir.glob("#{dir}/**/*")
                     .reject { |item| reject? item }
                     .map { |item| item.sub("#{dir}/", '') }
        Regexp.new (filelist.join('$|').gsub!('.', '\.') + '$')
      end

      def reject? item
        return true if File.directory?(item)
        return true if item =~ /\~$/
        return true if item =~ /[\#]/
        return true if item.start_with? Configuration.absolute_path(:dest)
        false
      end

        
    end # class << self
  end # class
end # module
