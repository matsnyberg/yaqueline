# encoding: UTF-8
require 'yaqueline/configuration'
require 'yaqueline/document'
module Yaqueline

  class DocumentParser
    class << self

      def parse path
        @@root = File.absolute_path Yaqueline::Configuration.get(:source)
        puts "root: #{@@root}"
        document = Yaqueline::Document.new
        document.path = relativize_path path
        #path = File.absolute_path path
        document.modified = (File.mtime(path).to_f * 1000).to_i
        document.key = path2key path
        file_content = IO.read(path)
        parts = file_content.split("---\n").reject{ |p| p.nil? || "".eql?(p)}
        if parts.length == 2
          document.frontmatter = parse_frontmatter path, parts[0]
          document.content = parts[1] # this is the content below yaml
        else
          document.frontmatter = OpenStruct.new
          document.content = file_content
        end
        document
      end

      def relativize_path path
        puts "relativize: #{path}"
        #raise ArgumentError.new("#{path} is not within #{@@root}") unless path.slice @@root
        path.slice!("#{@@root}/")
        puts "relativized: #{path}"
        path
      end

      def parse_frontmatter path, yaml
        begin
          hash = SafeYAML.load yaml
          OpenStruct.new(hash)
        rescue
          raise %Q{Could not load frontmatter from #{path}}
        end
      end

      def path2key path
        %r{\/([^\/]+)(\.\w+)+$}.match(path).captures[0]
      end

    end # class << self
  end # class

end
