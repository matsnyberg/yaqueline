require 'yaqueline/configuration'
require 'yaqueline/files'
require 'yaqueline/sasscompiler'
require 'yaqueline/renderer'
require 'yaqueline/publisher'
module Yaqueline
  class Builder
    extend Publisher
    class << self

      def build_all
        puts('Yaqueline::Builder.build_all')
        load_plugins
        Files.collect_files
        build_stylesheets
        render_pages
        render_posts
        copy_aux_files
      end

      def load_plugins
        Dir[File.join(Configuration.absolute_path(:plugins), '**', '*.rb')].each { |f| require(f) }
      end

      def build_stylesheets
        Files.css.each { |p|  copy_css(p) }
        Files.scss.each do |p|
          content = File.read(p)
          css = SassCompiler.compile(content)
          basename = File.basename(p, '.scss') << '.css'
          fileout = File.join(Configuration.absolute_path(:dest), 'css', basename)
          FileUtils.mkdir_p(File.dirname(fileout))
          IO.write(fileout, css)
        end
      end

      def copy_css css
      end

      def render_pages
        Files.pages.each { |p| render_page(p) }
      end

      def render_page(page)
        content = Renderer.render(page)
        filename = new_filename(page.path)
        publish_page(filename, content)
      end

      def render_posts
        Files.posts.each { |p| render_post(p) }
      end

      def render_post(post)
        content = Renderer.render(post)
        filename = new_filename(post.path)
        publish_post(filename, content)
      end

      def copy_aux_files
        Files.as_is.each { |p| copy_aux_file(p) }
      end

      def copy_aux_file(file)
      end

    end # class << self
  end # class
end # module
