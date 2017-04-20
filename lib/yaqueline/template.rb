# encoding: UTF-8

require 'erb'
require 'ostruct'

module Yaqueline
  class Template < Yaqueline::Document

    def partial name
      Yaqueline::TemplateManager.partial(name).render
    end

  end  
end
