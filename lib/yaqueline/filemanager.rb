# encoding: UTF-8

require 'rake'
require 'yaqueline/document'
require 'yaqueline/template'

module Yaqueline
  class FileManager

    def initialize site_root, config
      @config = nil
      @templates = Hash.new
      @partials = Hash.new
      @scss = Hash.new
      @other = []

      config_file = File.join(site_root, config.config_file)
      layouts = File.join(site_root, config.layouts_dir)
      includes = File.join(site_root, config.includes_dir)
      scss = File.join(site_root, config.scss_dir)
      css = File.join(site_root, config.css_dir)
      
      files(site_root).sort.each do |f|
        puts "filemanager: #{f}"
        if File.directory? f
          #puts :dir
        elsif f == config_file
          @config = f
        elsif f.start_with? layouts
          template = Template.new f
          puts "key #{template.key}"
          @templates[template.key] = template
        elsif f.start_with? includes
          partial = Partial.new f
          @partials[partial.key] = partial
        elsif f.start_with?(scss) || f.start_with?(css)
          doc = Document.new f
          @scss[doc.key] = doc
        elsif f =~ /\.(md|html|ascii)$/
          doc = Document.new f
          @other << doc
        else
          @others << f
        end
      end
      puts @templates
    end

    def partial name
      @partials[name].nil? ? nil : @partials[name].clone
    end
    
    def template name
      @templates[name].nil? ? nil : @templates[name].clone
    end


    private


    def files site_root
      Dir[File.join(site_root, '**/*')].reject { |f| f =~ /(\~|\.bak)$/ }
    end
    
    
  end
end
