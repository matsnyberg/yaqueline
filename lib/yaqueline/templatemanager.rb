# encoding: UTF-8

require 'rake'
require 'yaqueline/document'
require 'yaqueline/template'

module Yaqueline


  class TemplateManager

    @@templates = Hash.new
    @@partials = Hash.new

    
    class << self


      def prepare(layouts_dir, includes_dir)
        Dir[File.join(layouts_dir, "*.html")].sort.each do |f|
          if f.match(/.+\.(html)$/i)
            template = Template.new f
            template.key = File.basename(f, '.html')
            @@templates[template.key] = template
          end
        end
        Dir[File.join(includes_dir, "*")].sort.each do |f|
          if f.match(/.+\.(html)$/i)
            includefile = Document.new f
            includefile.key = File.basename(f, '.html')
            @@partials[includefile.key] = includefile
          end
        end
      end

      def partial name
        @@partials[name].nil? ? nil : @@partials[name].clone
      end
      
      def template name
        @@templates[name].nil? ? nil : @@templates[name].clone
      end
      
      
    end
  end
  

end
