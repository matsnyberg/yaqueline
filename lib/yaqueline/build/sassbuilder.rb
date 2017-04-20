require 'sass'

module Yaqueline
  module Build


    class SassBuilder


      DEFAULT_OPTIONS = {
        :template_location => './css/style.scss',
        :css_location => '_site/css',
        :load_paths => ['./_scss'],
        :style => :nested,
        :cache => true,
        :cache_location => './.sass-cache',
        :syntax => :scss,
        :filesystem_importer => Sass::Importers::Filesystem
      }.freeze
      


      def render sass_content, options = {}
        options = DEFAULT_OPTIONS.clone.merge options
        engine = Sass::Engine.new sass_content, options
        engine.render
      end
    end


  end
end




