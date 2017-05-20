# encoding: UTF-8
require 'asciidoctor'
require 'yaqueline/converters/asciidoc/htmlconverter'

module Yaqueline
  module Converters
    
    class AsciiDocConverter < Converter

      def self.matches path
        Asciidoctor::ASCIIDOC_EXTENSIONS.each do |ext|
          return true if path.match("\\#{ext[0]}$") # =~ /\.(asciidoc|adoc|ascii|ad)$/
        end
        false
      end
      
      def self.convert document
        result = render document.content
        document.content = result[:content]
      end
      
      def self.render content
        doc = Asciidoctor::Document.new content, :backend => 'yaqueline_html5'
        result = { :title => doc.doctitle, :content => doc.render }
        result
      end
      
      def self.body_content html
        if html =~ /<body>/
          return html.match(%r{(?<=<body>).*(?=</body>)}).to_s
        end
        html
      end
      
    end # class
    
  end
end
