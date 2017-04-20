# encoding: UTF-8
$LOAD_PATH.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
STDOUT.sync = true

def require_all(path)
  Dir[File.join(File.dirname(__FILE__), path, '*.rb')].sort.each do |f|
    if match = f.match(/.*\/([a-zA-Z]+\.rb)$/i)
      file = match.captures
      require_relative File.join(path, file)
    end
  end
end

require 'rubygems'
require "safe_yaml"
require 'yaqueline/version'
require 'yaqueline/configuration'
require 'yaqueline/command'
require_all 'yaqueline/commands'

SafeYAML::OPTIONS[:default_mode] = :safe

module Yaqueline
  def self.run
    puts "Yaqueline #{VERSION}"
    configuration = Yaqueline::Configuration.new
    Command.execute configuration
  end
  #Yaqueline.run
end
