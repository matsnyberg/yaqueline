# encoding: UTF-8
require "yaqueline/command"
require 'yaqueline/watcher'

module Yaqueline
  module Commands
    class Watch < Command
      class << self

        def init_with_program prog
          prog.command(:watch) do |c|
            c.syntax "watch"
            c.description "Build and watch a Yaqueline site"
            c.action do |args, options|
              execute(args, options) do 
                Watcher.start
              end
            end
          end
        end

      end # class << self
    end # class
  end
end
