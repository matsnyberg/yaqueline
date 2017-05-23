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
        Files.css = Hash.new
        Files.scss = Hash.new
        Files.posts = Array.new
        Files.pages = Array.new
        Files.as_is = Array.new
        
        config_file = Configuration.get(:config)
        layouts = Configuration.get(:layouts)
        includes = Configuration.get(:includes)
        scss = Configuration.get(:scss)
        css = Configuration.get(:css)
        plugins = Configuration.get(:plugins)
        
        files(Files.source).sort.each do |f|
          if File.directory? f
          elsif f == config_file
            Files.config = f
          elsif under? f, layouts
            template = DocumentParser.parse f
            Files.templates[template.key] = template
          elsif under? f, includes
            partial = DocumentParser.parse f
            Files.partials[partial.key] = partial
          elsif under? f, css
            doc = DocumentParser.parse f 
            Files.css[doc.key] = doc
          elsif under? f, scss
            doc = DocumentParser.parse f
            Files.scss[doc.key] = doc
          #elsif under? f, plugins
          elsif converter = Converter.find_converter_for(f)
            document = DocumentParser.parse f
            document.content = converter.convert document
            if f =~ /_posts/
              Files.posts << document
            else
              Files.pages << document
            end
          else
            Files.as_is << f
          end
        end
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
        return true if f =~ /(\~|\.bak)$/
        return true if f =~ /_plugins/
        false
      end

    end # class << self
  end # class

end
