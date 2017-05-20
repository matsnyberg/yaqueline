# encoding: UTF-8

module Yaqueline
  module Converters

    class HTMLConverter < Converter

      def self.matches path
        path =~ /\.(html)$/
      end
      
      def self.convert document
        document.content
      end

    end # class

  end
end
