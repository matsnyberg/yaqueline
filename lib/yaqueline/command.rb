# encoding: utf-8
require 'mercenary'
require 'yaqueline/configuration'

module Yaqueline

  ##
  # Superclass of all Yaqueline commands
  class Command
    
    @@commands = Array.new

    def self.inherited(subclass)
      @@commands << subclass
    end

    def self.commands
      @@commands
    end

    def self.execute args, options
      Yaqueline::Configuration.init args, options
      yield
    end

    def compile args, options
    end
    
  end

end
