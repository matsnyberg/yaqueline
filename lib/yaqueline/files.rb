require 'yaqueline/configuration'
require 'yaqueline/document_parser'
module Yaqueline

  class Files
    class << self
      
      def collect_files
        @@source = Configuration.get(:source)
        @@config = Configuration.get(:config)
        @@templates = Hash.new
        @@partials = Hash.new
        @@css = Hash.new
        @@scss = Hash.new
        @@posts = Array.new
        @@pages = Array.new
        @@as_is = Array.new
        
        config_file = Configuration.get(:config)
        layouts = Configuration.get(:layouts)
        includes = Configuration.get(:includes)
        scss = Configuration.get(:scss)
        css = Configuration.get(:css)
        plugins = Configuration.get(:plugins)
        
        files(@@source).sort.each do |f|
          if File.directory? f
          elsif f == config_file
            @@config = f
          elsif under? f, layouts
            template = DocumentParser.parse f
            @@templates[template.key] = template
          elsif under? f, includes
            partial = DocumentParser.parse f
            @@partials[partial.key] = partial
          elsif under? f, css
            doc = DocumentParser.parse f 
            @@css[doc.key] = doc
          elsif under? f, scss
            doc = DocumentParser.parse f
            @@scss[doc.key] = doc
          #elsif under? f, plugins
          elsif converter = Converter.find_converter_for(f)
            document = DocumentParser.parse f
            document.content = converter.convert document
            if f =~ /_posts/
              @@posts << document
            else
              @@pages << document
            end
          else
            @@as_is << f
          end
        end
      end

      def under? f, dir
        absolute_path(f).start_with? dir
      end

      def absolute_path f
        if f.to_s =~ /^\// then f else File.join(@@source, f) end
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

      def templates
        @@templates
      end

      def partials
        @@partials
      end

      def css
        @@css
      end

      def scss
        @@scss
      end

      def posts
        @@posts
      end

      def pages
        @@pages
      end

      def as_is
        @@as_is
      end

    end # class << self
  end # class

end
