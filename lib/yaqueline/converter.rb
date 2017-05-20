# encoding: UTF-8

module Yaqueline
  class Converter
    
    @@coverters = Array.new
    
    def matches path
      false
    end

    def convert content
      raise NotImplementedError.new 'abstract method'
    end
    
    
    class << self

      def find_converter_for path
        @@coverters.each do |c|
          if c.matches path
            return c
          end
        end
        nil
      end
      
      def inherited subclass
        @@coverters << subclass
      end

      def converters
        @@coverters
      end
      
    end # class << self


  end # class
end
