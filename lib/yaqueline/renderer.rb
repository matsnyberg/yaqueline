# encoding: UTF-8
require "tilt"
require 'erubis'
require 'ostruct'
require 'nokogiri'
require 'yaqueline/files'

module Yaqueline
  Tilt.prefer Tilt::ErubisTemplate

  class Renderer
    @@xsl = Nokogiri::XSLT(File.read(File.join(File.dirname(__FILE__), 'pretty-print.xsl')))
    class << self


      def render document
        erubis = Erubis::Eruby.new(document.content, :trim=>true)
        content = erubis.result(context(document.content, document.frontmatter))
        current = document
        while current.frontmatter.layout
          content = body_content content
          template = Files.template current.frontmatter.layout
          erubis = Erubis::Eruby.new(template.content, :trim=>true)
          content = erubis.result(context(content, document.frontmatter, template.frontmatter))
          current = template
        end
        pretty_print content
      end

      def context content, page, layout=nil
        result = Hash.new
        result[:content] = content
        result[:page] = page
        result[:layout] = layout
        result
      end

      def body_content html
        if html =~ /<body>/
          doc = Nokogiri::HTML html
          children = doc.at('body').children
          result = ""
          children.each do |child|
            result << child.to_s
          end
          return result
        end
        return html
      end

      def _body_content html
        if html =~ /<body>/
          return html.match(%r{(?<=<body>).*(?=</body>)}).to_s
        end
        html
      end

      def pretty_print html
        begin
          doc = Nokogiri::HTML(html)
          @@xsl.apply_to(doc).to_s
        rescue => error
          STDERR.puts "[Build] Error: " + error.message
          STDERR.puts error.backtrace
        end
      end

    end # class << self
  end # class
end # module
