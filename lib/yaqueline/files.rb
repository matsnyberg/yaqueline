require 'yaqueline/configuration'
require 'yaqueline/document_parser'
module Yaqueline
  class Files
    class << self
      attr_accessor :source, :config, :templates, :partials, :css, :scss, :posts, :pages, :as_is

      def collect_files
        Files.source = Configuration.get(:source)
        Files.config = Configuration.get(:config)
        Files.templates = Hash.new
        Files.partials = Hash.new
        Files.css = Array.new
        Files.scss = Array.new
        Files.posts = Array.new
        Files.pages = Array.new
        Files.as_is = Array.new

        config_file = Configuration.absolute_path(:config)
        dest_dir = Configuration.absolute_path(:dest)
        layouts_dir = Configuration.absolute_path(:layouts)
        includes_dir = Configuration.absolute_path(:includes)
        scss_dir = Configuration.absolute_path(:scss)
        css_dir = Configuration.absolute_path(:css)
        plugins_dir = Configuration.absolute_path(:plugins)

        begin
          files(Files.source).sort.each do |f|
            if f == config_file
              config = f
            elsif under? f, plugins_dir
            elsif under? f, dest_dir
            elsif under? f, layouts_dir
              template = DocumentParser.parse f
              templates[template.key] = template
            elsif under? f, includes_dir
              partial = DocumentParser.parse f
              partials[partial.key] = partial
            elsif under? f, css_dir
              css << f if f.to_s.end_with?('.css')
              scss << f if f.to_s.end_with?('.scss')
            elsif under? f, scss_dir
            elsif converter = Converter.find_converter_for(f)
              document = DocumentParser.parse f
              document.content = converter.convert document
              if f =~ /_posts/
                posts << document
              else
                pages << document
              end
            else
              as_is << f
            end
          end
        rescue => error
          STDERR.puts "[Build] Error: " + error.message
          STDERR.puts error.backtrace
        end
      end

      def template key
        templates[key]
      end

      def under? f, dir
        absolute_path(f).start_with? dir
      end

      def absolute_path f
        if f.to_s =~ /^\// then f else File.join(Files.source, f) end
      end

      def files source
        result = Dir[File.join(source, '**/*')]
                   .reject { |f| reject_file? f }
                   .collect { |f|  f.to_s.sub("#{source}/", '')}
      end

      def reject_file? f
        return true if File.directory? f
        return true if f =~ /(\~|\.bak)$/
        return true if under? f, Configuration.get(:plugins)
        return true if under? f, Configuration.get(:scss)
        return true if under? f, Configuration.get(:css)
        false
      end

    end # class << self
  end # class
end # module
