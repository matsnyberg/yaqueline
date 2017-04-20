require 'nokogiri'

module Yaqueline
  module Formatter

    XSLT = File.read(File.join(File.dirname(__FILE__), '../../etc/prettyprint.xsl'))
    
    def format content
      doc = Nokogiri::HTML(content, &:noblanks)
      xslt = Nokogiri::XSLT(XSLT)
      xslt.transform(doc)
    end
    
  end
end
