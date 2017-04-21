# encoding: UTF-8
require 'safe_yaml'
require 'ostruct'
require 'time'
#require 'yaqueline/templatemanager'

module Yaqueline


  ##
  # A general Yaqueline::Document
  # Base class for templates, posts and pages.
  #
  class Document
    attr_reader :key, :body

    def initialize path
      @source = OpenStruct.new(parse_file path)
      @source.modified = (File.mtime(path).to_f * 1000).to_i
    end

    def method_missing(method, *args, &block) # proxy for getters and setters
      @source.send(method, *args, &block)
    end

    def render rendered = nil
      unless rendered.nil?
        @source.content = rendered
      end
      rendered = ERB.new(@body).result(binding)
      unless @source.layout.nil?
        template = Yaqueline::TemplateManager.template layout
        rendered = template.render rendered
      end
      return rendered
    end

    def parse_file path
      file_content = IO.read(path)
      @key = path2key path
      result = Hash.new
      values = file_content.split("---\n")
      if values.length == 3
        @body = values[2] # this is the content below yaml
        head = SafeYAML.load values[1]
        result.merge! head if head
      else
        @body = file_content
      end
      return result
    end

    def path2key path
      %r{^.*\/(\w+)\.\w+$}.match(path).captures[0]
    end

    def to_s
      @source.to_s
    end


  end
end
