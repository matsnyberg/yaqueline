# encoding: UTF-8
require 'redcarpet'

module Yaqueline
  module Converters
    
    class MarkdownConverter < Converter

      def self.matches path
        path =~ /\.(markdown|md)$/
      end
      
      def self.convert document
        document.content = render document.content
      end
      
      def self.render content
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
        markdown.render content
      end
      
    end # class
    
  end
end
