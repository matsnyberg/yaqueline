# encoding: utf-8
require 'ostruct'
require "safe_yaml"

module Yaqueline
  class Configuration


    def initialize
      entries = Hash.new
      entries.merge! default_configuration
      entries.merge! argv_configuration
      entries.merge! site_configuration
      @source = OpenStruct.new(entries)      
    end
    
  
    def default_configuration
      YAML.load_file(File.join(File.dirname(__FILE__), '../../etc/default_config.yml'))
    end
    
    def argv_configuration
      Hash.new
    end
    
    def site_configuration
      config = File.join(Dir.pwd, '_config.yml')
      if File.exist? config
        YAML.load_file(config)
      else
        Hash.new
      end
    end
    
    def method_missing(method, *args, &block) # proxy for getters and setters
      @source.send(method, *args, &block)
    end

    def to_s
      @source.to_s
    end
    
  end
end
