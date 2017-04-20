# encoding: UTF-8
require 'rake'
module Yaqueline

  class Site

    def initialize(root)
      @root = root
      @files = Array.new
      @variables = Hash.new
    end

  end
  
end
