# encoding: UTF-8
require 'ostruct'
require 'time'

module Yaqueline


  ##
  # A general Yaqueline::Document
  # Base class for templates, posts and pages.
  #
  class Document

    # basename of the underlying file w/o extension
    attr_accessor :key
    # content of the file
    attr_accessor :content
    # path of the underlying file, relative to +site_root+
    attr_accessor :path
    # YAML frontmatter of the file
    attr_accessor :frontmatter
    # +mtime+ of the file
    attr_accessor :modified

    def to_s
      to_h.to_s
    end

    def to_h
      hash = frontmatter.to_h
      hash[:key] = key
      hash[:path] = path
      hash[:content] = content
      hash
    end

  end

end
