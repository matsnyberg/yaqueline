require 'yaqueline/configuration'
require 'yaqueline/files'
module Yaqueline

  class Builder
    class << self

      
      def build_all
        puts 'Yaqueline::Build::Builder.build_all'
        Files.collect_files
        load_plugins
        Files.pages.each { |p| puts p.content }
      end

      def load_plugins
        require_all File.join(Configuration.get(:plugins))
      end

    end # class << self
  end # class

end
