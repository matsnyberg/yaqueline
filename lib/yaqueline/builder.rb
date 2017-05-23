require 'yaqueline/configuration'
require 'yaqueline/files'
module Yaqueline
  class Builder
    class << self
      
      def build_all
        puts 'Yaqueline::Build::Builder.build_all'
        Files.collect_files
        load_plugins
        render_pages
        render_posts
        copy_aux_files
      end

      def load_plugins
        require_all File.join(Configuration.get(:plugins))
      end

      def render_pages
      end

      def render_posts
      end

      def copy_aux_files
      end

    end # class << self
  end # class
end # module
