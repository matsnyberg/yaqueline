require 'yaqueline/configuration'
module Yaqueline

  class Files
    class << self

      
      def collect_files
        source = Yaqueline::Configuration.get(:source)
        @@config = Yaqueline::Configuration.get(:config)
        @@templates = Hash.new
        @@partials = Hash.new
        @@css = Hash.new
        @@scss = Hash.new
        @@converted = Array.new
        @@as_is = Array.new

        config_file = Yaqueline::Configuration.get(:config)
        layouts = Yaqueline::Configuration.get(:layouts)
        includes = Yaqueline::Configuration.get(:includes)
        scss = Yaqueline::Configuration.get(:scss)
        css = Yaqueline::Configuration.get(:css)
        
        files(source).sort.each do |f|
          if File.directory? f
          elsif f == config_file
            @@config = f
          elsif f.start_with? layouts
            template = Template.new f
            @@templates[template.key] = template
          elsif f.start_with? includes
            partial = Partial.new f
            @@partials[partial.key] = partial
          elsif f.start_with?(css)
            doc = Document.new f 
            @@css[doc.key] = doc
          elsif f.start_with?(scss)
            doc = Document.new f
            @@scss[doc.key] = doc
          elsif converter = Yaqueline::Build::Converter.find_converter_for(f)
            document = Document.new f
            document.content = converter.convert document
            @@converted << document
          else
            @@as_is << f
          end
        end
      end

      def files source
        result = Dir[File.join(source, '**/*')]
                   .reject { |f| reject_file? f }
                   .collect { |f|  f.to_s.sub("#{source}/", '')}
      end
      
      def reject_file? f
        return true if f =~ /(\~|\.bak)$/
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

      def converted
        @@converted
      end

      def as_is
        @@as_is
      end

    end # class << self
  end # class

end
