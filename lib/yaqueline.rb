# encoding: UTF-8
STDOUT.sync = true

def require_all(path)
  Dir[File.join(File.dirname(__FILE__), path, '*.rb')].sort.each do |f|
    if match = f.match(/.*\/([a-zA-Z]+\.rb)$/i)
      file = match.captures
      require_relative File.join(path, file)
    end
  end
end


module Yaqueline

  require "safe_yaml"
  SafeYAML::OPTIONS[:default_mode] = :safe
  
  require 'yaqueline/version'
  require 'yaqueline/configuration'
  require 'yaqueline/command'
  require_all 'yaqueline/commands'
  require 'yaqueline/converter'
  require_all 'yaqueline/converters'
  
end
