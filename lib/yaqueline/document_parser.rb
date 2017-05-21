# encoding: UTF-8
require 'yaqueline/configuration'
require 'yaqueline/document'
module Yaqueline

  class DocumentParser
    class << self

      def parse path
        @@root = File.absolute_path Configuration.get(:source)
        @@abspath = absolute_path path
        @@relpath = relativize_path path
        document = Document.new
        document.path = @@relpath
        document.modified = (File.mtime(@@abspath).to_f * 1000).to_i
        document.key = path2key @@abspath
        file_content = IO.read(@@abspath)
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

      def absolute_path path
        path =~ /^\// ? path : File.join(@@root, path)
      end

      def relativize_path path
        path.slice!("#{@@root}/")
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
        %r{([^\/]+)(\.\w+)+$}.match(path).captures[0]
      end

    end # class << self
  end # class

end
